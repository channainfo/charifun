module charifun::main {
  use sui::tx_context::TxContext;
  use std::string::String;

  use charifun::cap::{Self, PackageOwnerCap};
  use charifun::donable::{Self, DonorBoard};

  fun init(ctx: &mut TxContext) {
    cap::init_create_package_owner_cap(ctx);
  }

  public entry fun register_donor(name: String, email: String, board: &mut DonorBoard, ctx: &mut TxContext): bool {
    donable::register_donor(name, email, board, ctx)
  }

  public entry fun setup(_owner: &PackageOwnerCap, ctx: &mut TxContext) {
    // one timed called
    donable::init_donor_board(ctx);
  }

  #[test]
  public fun init_test() {
    use sui::test_scenario;
    use charifun::cap::{PackageOwnerCap};

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      init(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let pack_owner_cap = test_scenario::has_most_recent_for_sender<PackageOwnerCap>(&mut scenario);
      assert!(pack_owner_cap, 0);
    };

    test_scenario::end(scenario);
  }
}