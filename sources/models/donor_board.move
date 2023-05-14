module charifun::donor_board {
  use sui::object::{Self, UID};
  use sui::tx_context::{TxContext};
  use sui::transfer;

  struct DonorBoard has key, store{
    id: UID,
    donors_count: u64
  }

  // call only once
  public fun create(ctx: &mut TxContext ) {
    let board = DonorBoard {
      id: object::new(ctx),
      donors_count: 0u64
    };

    transfer::public_share_object(board);
  }

  public fun id(donor_board: &DonorBoard): &UID {
    &donor_board.id
  }

  public fun donors_count(donor_board: &DonorBoard): u64 {
    donor_board.donors_count
  }
}