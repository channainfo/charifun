#[test_only]
module charifun::main_test {
  use charifun::main;
  use std::string::{utf8};

  #[test]
  public fun create_donor_test(){

    use sui::test_scenario;
    use charifun::donor::{Self, Donor};
    use std::debug::{print};

    let owner = @0x01;
    let scenario = test_scenario::begin(owner);

    // The first txn to invoke the create_donor
    {
      // return &mut
      let ctx = test_scenario::ctx(&mut scenario);
      let name = utf8(b"Monika Ly");
      let email = utf8(b"csr@monik.com");

      main::create_donor(name, email, ctx);
    };

    // The second txn to read the donor
    test_scenario::next_tx(&mut scenario, owner);
    {
      let donor = test_scenario::take_from_sender<Donor>(&mut scenario);

      print(donor::name(&donor));
      print(donor::email(&donor));
      test_scenario::return_to_sender(&mut scenario, donor);
    };

    // end the transaction
    test_scenario::end(scenario);

  }
}