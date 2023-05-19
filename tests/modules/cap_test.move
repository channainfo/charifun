#[test_only]
module charifun::cap_test {

  #[test]
  public fun test_init_create_package_owner_cap() {
    use sui::test_scenario;
    use charifun::cap::{Self, PackageOwnerCap};

    let owner = @0x001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      cap::init_create_package_owner_cap(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let pack_owner_cap = test_scenario::has_most_recent_for_sender<PackageOwnerCap>(&mut scenario);
      assert!(pack_owner_cap, 0);
    };

    test_scenario::end(scenario);
  }
}