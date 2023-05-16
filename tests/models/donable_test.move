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
      let hash_email = donable::hash(&email);

      // board is now has donors_count
      assert!(donable::donors_count(&board) == 1, 0);

      // read the donor from the board and verify
      let donor: &Donor = donable::donor_by_email(&board, &email);
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

}