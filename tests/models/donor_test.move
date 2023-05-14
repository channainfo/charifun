#[test_only]
module charifun::donor_test {
  use charifun::donor::{Self, Donor};

  #[test]
  public fun create() {
    use std::string::{utf8};
    use std::option;

    use sui::test_scenario;
    use sui::object::ID;

    let owner = @0x001;

    // Begin transaction with the owner
    let scenario = test_scenario::begin(owner);
    {
      let ctx = test_scenario::ctx(&mut scenario);
      let name = utf8(b"Monika Ly");
      let email = utf8(b"admin@monik.org");

      donor::create(name, email, ctx);
    };

    // Retrieve data using the owner address
    test_scenario::next_tx(&mut scenario, owner);
    {
      let donor = test_scenario::take_from_sender<Donor>(&mut scenario);

      assert!(donor::name(&donor) == &utf8(b"Monika Ly"), 0);
      assert!(donor::amount_donated(&donor) == 0u64, 0);
      assert!(option::is_none<ID>(donor::frame(&donor)), 0);

      let email = utf8(b"admin@monik.org");
      let hash_email = donor::hash(&email);

      assert!(hash_email == *donor::hash_email(&donor), 0);
      test_scenario::return_to_sender(&mut scenario, donor);
    };

    test_scenario::end(scenario);
  }

}