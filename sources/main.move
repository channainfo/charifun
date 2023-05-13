module charifun::main {
  use sui::tx_context::TxContext;
  use std::string::String;

  use charifun::cap::{Self};

  use charifun::donor;

  fun init(ctx: &mut TxContext) {
    cap::io_create_package_owner_cap(ctx);
  }

  public entry fun create_donor(name: String, email: String, ctx: &mut TxContext) {
    donor::create(name, email, ctx);
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