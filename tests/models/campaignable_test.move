#[test_only]
module charifun::campaignable_test {

  #[test]
  public fun test_init_campaign_board() {

    use sui::test_scenario;
    use charifun::campaignable::{Self, CampaignBoard};

    let owner = @0x0001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      campaignable::init_campaign_board(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<CampaignBoard>(& scenario);
      assert!(campaignable::campaigns_count(&board) == 0u64, 0);

      test_scenario::return_shared<CampaignBoard>(board);
    };

    test_scenario::end(scenario);
  }

  #[test]
  public fun test_register_campaign(){
    use sui::test_scenario;
    use charifun::campaignable::{Self, CampaignBoard, Campaign};

    use std::string::{Self, String};

    let owner = @0x0001;
    let scenario = test_scenario::begin(owner);

    // setup the board
    {
      let ctx = test_scenario::ctx(&mut scenario);
      campaignable::init_campaign_board(ctx);
    };


    // call to the method
    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<CampaignBoard>(& scenario);

      let name :String = string::utf8(b"Kanthabopha Hospital Fun");
      let code :String = string::utf8(b"kantabopha-hospital-fun-5892006789");
      let desc :String = string::utf8(b"Supported fun to save thousands of live");
      let url :String = string::utf8(b"https://kbp.hospital/fun-4-life");
      let target_value: u64 = 4_500_000_000_000;
      let start_date = 1684331572092;
      let end_date = 1689331572092;

      let ctx = test_scenario::ctx(&mut scenario);
      let registered = campaignable::register_campaign(
        code,
        name,
        desc,
        url,
        target_value,
        start_date,
        end_date,
        &mut board,
        ctx
      );

      // expectation of the call result
      assert!(registered == true, 0);

      test_scenario::return_shared<CampaignBoard>(board);
    };

    // Expectation of the data storage
    let effects = test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<CampaignBoard>(& scenario);
      let code :String = string::utf8(b"kantabopha-hospital-fun-5892006789");

      let campaign: &Campaign = campaignable::campaign_by_code(&board, &code);

      assert!(campaignable::code(campaign) == &string::utf8(b"kantabopha-hospital-fun-5892006789"), 0);
      assert!(campaignable::name(campaign) == &string::utf8(b"Kanthabopha Hospital Fun"), 0);
      assert!(campaignable::desc(campaign) == &string::utf8(b"Supported fun to save thousands of live"), 0);
      assert!(campaignable::url(campaign) == &string::utf8(b"https://kbp.hospital/fun-4-life"), 0);
      assert!(campaignable::target_value(campaign) == 4_500_000_000_000, 0);
      assert!(campaignable::start_date(campaign) == 1684331572092, 0);
      assert!(campaignable::end_date(campaign) == 1689331572092, 0);
      test_scenario::return_shared<CampaignBoard>(board);
    };

    // Expectation of the event creation with 1 event created
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    // Test to add existing campaign
    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<CampaignBoard>(& scenario);

      let name :String = string::utf8(b"any name");
      let code :String = string::utf8(b"kantabopha-hospital-fun-5892006789");
      let desc :String = string::utf8(b"any desc");
      let url :String = string::utf8(b"https://kbp.hospital/fun-4-life");
      let target_value: u64 = 4_500_000_000_000;
      let start_date = 1684331572092;
      let end_date = 1689331572092;

      let ctx = test_scenario::ctx(&mut scenario);
      let register = campaignable::register_campaign(
        code,
        name,
        desc,
        url,
        target_value,
        start_date,
        end_date,
        &mut board,
        ctx
      );

      // it should fail and on campaign is created.
      assert!(register == false, 0);
      assert!(campaignable::campaigns_count(&board) == 1, 0);

      test_scenario::return_shared<CampaignBoard>(board);
    };

    test_scenario::end(scenario);
  }

}

