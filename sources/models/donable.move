module charifun::donable {
  use sui::tx_context::{Self, TxContext};
  use sui::object::{Self, UID, ID};
  use sui::transfer;
  use sui::dynamic_object_field;

  use std::string::{String};
  use std::option::{Self, Option};

  struct DonorBoard has key, store{
    id: UID,
    donors_count: u64,
  }

  struct Donor has key, store {
    id: UID,
    name: String,
    hash_email: vector<u8>,
    amount_donated: u64,
    donations_count: u64,
    fame: Option<ID>,
    created_at: u64,
  }

  struct DonorCreatedEvent has copy, drop {
    donor_id: ID,
    name: String,
    owner: address,
    hash_email: vector<u8>,
    created_at: u64
  }

  struct DonationBoard has key, store {
    id: UID,
    donations_count: u64,
    total_amount: u128
  }

  struct Donaton has key, store {
    id: UID,
    donor_id: ID,
    donated_at: u64,
    amount: u64,
  }

  public fun name(donor: &Donor): &String {
    &donor.name
  }

  public fun init_donor_board(ctx: &mut TxContext){
    let board = DonorBoard {
      id: object::new(ctx),
      donors_count: 0u64
    };

    transfer::public_share_object(board);
  }

  public fun register_donor(name: String, email: String, board: &mut DonorBoard, ctx: &mut TxContext): bool{

    let registered = dynamic_object_field::exists_<vector<u8>>(&board.id, hash(&email));

    if(registered){
      return false
    };

    let hash_email = hash(&email);
    let created_at = tx_context::epoch_timestamp_ms(ctx);

    let donor = new_donor(name, email, created_at, ctx);
    let donor_id = object::uid_to_inner(&donor.id);
    let owner = tx_context::sender(ctx);

    dynamic_object_field::add(&mut board.id, hash_email, donor);
    board.donors_count = board.donors_count + 1u64;

    let donor_created_event = DonorCreatedEvent {
      donor_id,
      name,
      owner,
      hash_email,
      created_at
    };

    sui::event::emit(donor_created_event);
    true
  }

  public fun donor_by_email(board: &DonorBoard, email: &String): &Donor {
    let hash_email = hash(email);

    dynamic_object_field::borrow<vector<u8>, Donor>(&board.id, hash_email)
  }

  fun new_donor(name: String, email: String, created_at: u64, ctx: &mut TxContext): Donor {
    let hash_email = hash(&email);
    let id = object::new(ctx);

    Donor {
      id,
      name,
      hash_email,
      amount_donated: 0u64,
      donations_count: 0u64,
      fame: option::none(),
      created_at
    }
  }

  public fun donors_count(board: &DonorBoard): u64 {
    board.donors_count
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

  public fun fame(donor: &Donor): &Option<ID> {
    &donor.fame
  }

  public fun created_at(donor: &Donor): u64 {
    donor.created_at
  }

  public fun hash_email(donor: &Donor): &vector<u8> {
    &donor.hash_email
  }
}