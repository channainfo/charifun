#[test_only]
module charifun::donor_board_test {

  #[test]
  public fun create_test() {
    use sui::test_scenario;
    use charifun::donor_board::{Self, DonorBoard};

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);
    {
      let ctx = test_scenario::ctx(&mut scenario);
      donor_board::create(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<DonorBoard>(&scenario);

      assert!(donor_board::donors_count(&board) == 0u64, 0);

      test_scenario::return_shared<DonorBoard>(board);
    };

    test_scenario::end(scenario);
  }
}