module charifun::donor {
  use sui::tx_context::{Self, TxContext};
  use sui::object::{Self, UID, ID};
  use sui::transfer::transfer;

  use std::string::{String};
  use std::option::{Self, Option};

  struct Donor has key, store {
    id: UID,
    name: String,
    hash_email: vector<u8>,
    amount_donated: u64,
    donations_count: u64,
    frame: Option<ID>,
  }

  public fun create(name: String, email: String, ctx: &mut TxContext): ID {
    let hash_email = hash(&email);
    let id = object::new(ctx);
    let inner_id = object::uid_to_inner(&id);

    let donor = Donor {
      id: id,
      name,
      hash_email,
      amount_donated: 0u64,
      donations_count: 0u64,
      frame: option::none(),
    };

    transfer(donor, tx_context::sender(ctx));
    inner_id
  }

  public fun name(donor: &Donor): &String {
    &donor.name
  }

  public fun hash(email: &String): vector<u8> {
    let hash :vector<u8> = std::hash::sha3_256(*std::string::bytes(email));
    hash
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

  public fun hash_email(donor: &Donor): &vector<u8> {
    &donor.hash_email
  }

}