#[test_only]
module charifun::donation_board_test {

  #[test]
  public fun create_test() {
    use sui::test_scenario;

    use charifun::donation_board::{Self, DonationBoard};

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      donation_board::create(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonationBoard>(&mut scenario);

      assert!(donation_board::donations_count(&board) == 0u64, 0);
      assert!(donation_board::total_value(&board) == 0u128, 0);

      test_scenario::return_shared<DonationBoard>(board);
    };

    test_scenario::end(scenario);
  }
}