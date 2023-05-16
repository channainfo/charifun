module charifun::cap {
  use sui::object::{Self, UID};
  use sui::tx_context::{Self, TxContext};
  use sui::transfer::transfer;

  struct PackageOwnerCap has key, store {
    id: UID,
  }

  public fun init_create_package_owner_cap(ctx: &mut TxContext) {
    let admin_cap = PackageOwnerCap {
      id: object::new(ctx)
    };

    let sender = tx_context::sender(ctx);

    transfer(admin_cap, sender);
  }
}