#[test_only]
module charifun::donable_test {

  #[test]
  public fun test_init_donor_board(){
    use sui::test_scenario;
    use charifun::donable::{Self, DonorBoard};

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      donable::init_donor_board(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonorBoard>(&scenario);
      let donors_count = donable::donors_count(&board);

      assert!(donors_count == 0u64, 0);
      test_scenario::return_shared<DonorBoard>(board);
    };

    test_scenario::end(scenario);
  }

  #[test]
  // when donor does not exist
  public fun test_register_donor_successfully_if_donor_not_exists(){
    use sui::test_scenario;
    use sui::object::{ID};
    use std::string::{Self};
    use std::option;
    use charifun::donable::{Self, DonorBoard, Donor};
    use charifun::libs;

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    // setup donor_board
    {
      let ctx = test_scenario::ctx(&mut scenario);
      donable::init_donor_board(ctx);
    };

    // register a donor admin@monik.org
    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonorBoard>(& scenario);
      let ctx = test_scenario::ctx(&mut scenario);

      let name = string::utf8(b"Monika");
      let email = string::utf8(b"admin@monik.org");

      let result = donable::register_donor(name, email, &mut board, ctx);
      assert!(result == true, 0);

      test_scenario::return_shared<DonorBoard>(board);
    };

    // Expectation
    let effects = test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonorBoard>(& scenario);
      let name = string::utf8(b"Monika");
      let email = string::utf8(b"admin@monik.org");
      let hash_email = libs::hash(&email);

      // board is now has donors_count
      assert!(donable::donors_count(&board) == 1, 0);

      // read the donor from the board and verify
      let donor: &Donor = donable::find_donor_by_email(&board, &email);
      assert!(donable::name(donor) == &name, 0);
      assert!(donable::hash_email(donor) == &hash_email, 0);
      assert!(donable::amount_donated(donor) == 0, 0);
      assert!(donable::donations_count(donor) == 0, 0);
      assert!(option::is_none<ID>(donable::fame(donor)) == true, 0);
      test_scenario::return_shared<DonorBoard>(board);
    };

    // expect 1 event is emitted
    sui::test_utils::assert_eq(test_scenario::num_user_events(&effects), 1);

    // if register the same donor ( existed ) it return false
    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonorBoard>(& scenario);
      let ctx = test_scenario::ctx(&mut scenario);

      let name = string::utf8(b"Monika");
      let email = string::utf8(b"admin@monik.org");

      let result = donable::register_donor(name, email, &mut board, ctx);
      assert!(result == false, 0);

      test_scenario::return_shared<DonorBoard>(board);
    };

    test_scenario::end(scenario);
  }

  #[test]
  public fun test_donate() {

    use sui::test_scenario;

    use charifun::donable::{Self, DonorBoard, DonationBoard};
    use charifun::campaignable::{Self, CampaignBoard};
    use std::string::{Self};

    let owner = @0x0001;
    let scenario = test_scenario::begin(owner);
    {
      let ctx = test_scenario::ctx(&mut scenario);
      donable::init_donor_board(ctx);
      donable::init_donation_board(ctx);
      campaignable::init_campaign_board(ctx);
    };

    let _effects = test_scenario::next_tx(&mut scenario, owner);
    {
      let name = string::utf8(b"Monika");
      let email = string::utf8(b"admin@monik.org");

      let c_code = string::utf8(b"kanthabopha-fun20399");
      let c_name = string::utf8(b"kanthabopha fun");
      let c_desc = string::utf8(b"fun for saving lives");
      let c_url = string::utf8(b"https://monik.org/kanthabopha");
      let c_target_value = 45_000_000;
      let c_start_date = 1_845_787_222_222;
      let c_end_date = 1_885_787_222_222;

      let donor_board = test_scenario::take_shared<DonorBoard>(& scenario);
      let campaign_board = test_scenario::take_shared<CampaignBoard>(&scenario);

      let ctx = test_scenario::ctx(&mut scenario);

      donable::register_donor(name, email, &mut donor_board, ctx);
      campaignable::register_campaign(
        c_code,
        c_name,
        c_desc,
        c_url,
        c_target_value,
        c_start_date,
        c_end_date,
        &mut campaign_board,
        ctx
      );

      test_scenario::return_shared<DonorBoard>(donor_board);
      test_scenario::return_shared<CampaignBoard>(campaign_board);
    };

    // std::debug::print(&string::utf8(b"**********************************************************************"));
    // std::debug::print(&effects);

    let effects = test_scenario::next_tx(&mut scenario, owner);
    let donation_id = {
      let donor_board = test_scenario::take_shared<DonorBoard>(&scenario);
      let donation_board = test_scenario::take_shared<DonationBoard>(&scenario);
      let campagin_board = test_scenario::take_shared<CampaignBoard>(&scenario);

      let email = string::utf8(b"admin@monik.org");
      let donor = donable::find_donor_by_email_mut(&mut donor_board, &email);

      let code = string::utf8(b"kanthabopha-fun20399");
      let campaign = campaignable::find_campaign_by_code_mut(&mut campagin_board, &code);

      let amount = 4_000u64;
      let ctx = test_scenario::ctx(&mut scenario);
      let donation_id = donable::donate(donor, campaign, &mut donation_board, amount, ctx);

      test_scenario::return_shared<DonorBoard>(donor_board);
      test_scenario::return_shared<DonationBoard>(donation_board);
      test_scenario::return_shared<CampaignBoard>(campagin_board);

      donation_id
    };

    // std::debug::print(&string::utf8(b"**********************************************************************"));
    // std::debug::print(&effects);
    // Expect 2 events emitted: DonorCreatedEvent, CampaignCreatedEvent
    assert!(test_scenario::num_user_events(&effects) == 2, 0);

    // std::debug::print(&donation_id);

    let effects = test_scenario::next_tx(&mut scenario, owner);
    {
      let donor_board = test_scenario::take_shared<DonorBoard>(&scenario);
      let donation_board = test_scenario::take_shared<DonationBoard>(&scenario);
      let campagin_board = test_scenario::take_shared<CampaignBoard>(&scenario);

      // Expect the donor to be modified with
      let email = string::utf8(b"admin@monik.org");
      let donor = donable::find_donor_by_email(&donor_board, &email);
      assert!(donable::amount_donated(donor) == 4_000u64, 0);
      assert!(donable::donations_count(donor) == 1, 0);

      // Expect the campaign to be modified with
      let code = string::utf8(b"kanthabopha-fun20399");
      let campaign = campaignable::find_campaign_by_code(& campagin_board, &code);
      assert!(campaignable::received_value(campaign) == 4_000u64, 0);
      assert!(campaignable::donations_count(campaign) == 1, 0);

      // Expect donation to be listed in the board
      assert!(donable::board_donations_count(&donation_board) == 1, 0);
      assert!(donable::board_total_amount(&donation_board) == (4_000u64 as u128), 0);

      // Expect donation to be created with correct data
      let donation = donable::find_donation_by_id(&donation_board, donation_id);
      assert!(donable::donation_amount(donation)== 4_000u64, 0);
      assert!(donable::donation_donor_id(donation)== donable::donor_id(donor), 0);
      assert!(donable::donation_campaign_id(donation)== campaignable::campaign_id(campaign), 0);

      // std::debug::print(donor);
      // std::debug::print(campaign);
      // std::debug::print(&donor_board);
      // std::debug::print(&donation_board);
      // std::debug::print(&campagin_board);

      test_scenario::return_shared<DonorBoard>(donor_board);
      test_scenario::return_shared<DonationBoard>(donation_board);
      test_scenario::return_shared<CampaignBoard>(campagin_board);
    };
    // std::debug::print(&string::utf8(b"**********************************************************************"));
    // std::debug::print(&effects);
    // Expect 1 event emitted: DonationCreatedEvent
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    test_scenario::end(scenario);

  }

}