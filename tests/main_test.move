#[test_only]
module charifun::main_test {
  #[test]
  public fun test_init() {
    use sui::test_scenario;
    use charifun::cap::{PackageOwnerCap};
    use charifun::main;

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      main::init_package(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let pack_owner_cap = test_scenario::has_most_recent_for_sender<PackageOwnerCap>(&mut scenario);
      assert!(pack_owner_cap, 0);
    };

    test_scenario::end(scenario);
  }
}