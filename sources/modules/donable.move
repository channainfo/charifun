module charifun::donable {
  use sui::tx_context::{Self, TxContext};
  use sui::object::{Self, UID, ID};
  use sui::transfer;
  use sui::dynamic_object_field;
  use sui::event;

  use std::string::{String};
  use std::option::{Self, Option};

  use charifun::libs::{ Self };
  use charifun::campaignable::{Self, Campaign};

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

  struct Donation has key, store {
    id: UID,
    donor_id: ID,
    campaign_id: ID,
    amount: u64,
    donated_at: u64,
  }

  struct DonationCreatedEvent has copy, drop {
    donation_id: ID,
    campaign_id: ID,
    donor_id: ID,
    amount: u64,
    created_at: u64
  }

  public fun init_donor_board(ctx: &mut TxContext){
    let board = DonorBoard {
      id: object::new(ctx),
      donors_count: 0u64
    };

    transfer::public_share_object(board);
  }

  public fun register_donor(name: String, email: String, board: &mut DonorBoard, ctx: &mut TxContext): bool{

    let registered = dynamic_object_field::exists_<vector<u8>>(&board.id, libs::hash(&email));

    if(registered){
      return false
    };

    let hash_email = libs::hash(&email);
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

    event::emit(donor_created_event);
    true
  }

  public fun init_donation_board(ctx: &mut TxContext) {
    let board = DonationBoard {
      id: object::new(ctx),
      donations_count: 0u64,
      total_amount: 0u128
    };

    transfer::public_share_object(board);
  }

  public fun donate(donor: &mut Donor, campaign: &mut Campaign, donation_board: &mut DonationBoard, amount: u64, ctx: &mut TxContext): ID{
    let campaign_id = campaignable::campaign_id(campaign);
    let donor_id = donor_id(donor);
    let created_at = tx_context::epoch_timestamp_ms(ctx);

    campaignable::register_donation(campaign, amount);

    donor.amount_donated = donor.amount_donated + amount;
    donor.donations_count = donor.donations_count + 1;

    let id = object::new(ctx);

    let donation = Donation {
      id,
      amount,
      campaign_id,
      donor_id,
      donated_at: created_at
    };

    let donation_id = object::uid_to_inner(&donation.id);
    dynamic_object_field::add(&mut donation_board.id, donation_id, donation);
    donation_board.donations_count = donation_board.donations_count + 1;
    donation_board.total_amount = donation_board.total_amount + (amount as u128);

    let donation_event = DonationCreatedEvent {
      donor_id,
      donation_id,
      campaign_id,
      amount,
      created_at
    };

    event::emit(donation_event);
    donation_id
  }

  public fun find_donation_by_id(donation_board: &DonationBoard, donation_id: ID): &Donation {
    dynamic_object_field::borrow<ID, Donation>(&donation_board.id, donation_id)
  }

  public fun find_donor_by_email(board: &DonorBoard, email: &String): &Donor {
    let hash_email = libs::hash(email);

    dynamic_object_field::borrow<vector<u8>, Donor>(&board.id, hash_email)
  }

  public fun find_donor_by_email_mut(board: &mut DonorBoard, email: &String): &mut Donor {
    let hash_email = libs::hash(email);

    dynamic_object_field::borrow_mut<vector<u8>, Donor>(&mut board.id, hash_email)
  }

  fun new_donor(name: String, email: String, created_at: u64, ctx: &mut TxContext): Donor {
    let hash_email = libs::hash(&email);
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

  public fun name(donor: &Donor): &String {
    &donor.name
  }

  public fun donors_count(board: &DonorBoard): u64 {
    board.donors_count
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

  public fun donor_id(donor: &Donor): ID {
    object::uid_to_inner(&donor.id)
  }

  public fun donation_id(donation: &Donation): ID {
    object::uid_to_inner(&donation.id)
  }

  public fun donation_amount(donation: &Donation): u64 {
    donation.amount
  }

  public fun donation_campaign_id(donation: &Donation): ID {
    donation.campaign_id
  }

  public fun donation_donor_id(donation: &Donation): ID {
    donation.donor_id
  }

  public fun board_donations_count(board: &DonationBoard): u64 {
    board.donations_count
  }

  public fun board_total_amount(board: &DonationBoard): u128 {
    board.total_amount
  }
}