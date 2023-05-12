module charifun::donor {
  use sui::tx_context::{Self, TxContext};
  use sui::object::{Self, UID, ID};
  use sui::transfer::transfer;

  use std::string::{String};
  use std::option::{Self, Option};

  struct Donor has key, store {
    id: UID,
    name: String,
    email: String,
    amount_donated: u64,
    donations_count: u64,
    frame: Option<ID>,
  }

  public fun create(name: String, email: String, ctx: &mut TxContext) {
    let donor = Donor {
      id: object::new(ctx),
      name,
      email,
      amount_donated: 0u64,
      donations_count: 0u64,
      frame: option::none(),
    };

    transfer(donor, tx_context::sender(ctx));
  }

  public fun name(donor: &Donor): &String {
    &donor.name
  }

  public fun email(donor: &Donor): &String {
    &donor.email
  }

  public fun amount_donated(donor: &Donor): u64 {
    donor.amount_donated
  }

  public fun donations_count(donor: &Donor): u64 {
    donor.donations_count
  }

  public fun frame(donor: &Donor): &Option<ID> {
    &donor.frame
  }



}