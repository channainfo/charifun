module charifun::donation_board {
  use sui::object::{Self, UID};
  use sui::tx_context::{TxContext};
  use sui::transfer;

  struct DonationBoard has key, store{
    id: UID,
    donations_count: u64,
    total_value: u128
  }

  // call only once
  public fun create(ctx: &mut TxContext ) {
    let board = DonationBoard {
      id: object::new(ctx),
      donations_count: 0u64,
      total_value: 0u128
    };

    transfer::public_share_object(board);
  }

  public fun id(donation_board: &DonationBoard): &UID {
    &donation_board.id
  }

  public fun donations_count(donation_board: &DonationBoard): u64 {
    donation_board.donations_count
  }

  public fun total_value(donation_board: &DonationBoard): u128 {
    donation_board.total_value
  }
}