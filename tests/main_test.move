#[test_only]
module charifun::main_test {
  use charifun::main;
  use std::string::{utf8};

  #[test]
  public fun create_donor_test(){

    use sui::test_scenario;
    use sui::object::ID;
    use charifun::donor::{Self, Donor};
    use std::option;

    let owner = @0x01;
    let scenario = test_scenario::begin(owner);

    // The first txn to invoke the create_donor
    {
      // return &mut
      let ctx = test_scenario::ctx(&mut scenario);
      let name = utf8(b"Monika Ly");
      let email = utf8(b"admin@monik.com");

      main::create_donor(name, email, ctx);
    };

    // The second txn to read the donor
    test_scenario::next_tx(&mut scenario, owner);
    {
      let donor = test_scenario::take_from_sender<Donor>(&mut scenario);
      assert!(donor::name(&donor) == &utf8(b"Monika Ly"), 0);
      assert!(donor::amount_donated(&donor) == 0u64, 0);
      assert!(option::is_none<ID>(donor::frame(&donor)), 0);

      let email = utf8(b"admin@monik.org");
      let hash_email = donor::hash(&email);
      std::debug::print<vector<u8>>(&hash_email);
      test_scenario::return_to_sender(&mut scenario, donor);
    };

    // end the transaction
    test_scenario::end(scenario);

  }
}