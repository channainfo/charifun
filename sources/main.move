module charifun::main {
  use sui::tx_context::TxContext;
  use std::string::String;

  use charifun::cap::{Self, PackageOwnerCap};
  use charifun::donable::{Self, DonorBoard};
  use charifun::campaignable::{Self, CampaignBoard};
  use charifun::taxonomical::{Self};

  fun init(ctx: &mut TxContext) {
    init_package(ctx);
  }

  public fun init_package(ctx: &mut TxContext) {
    cap::init_create_package_owner_cap(ctx);
  }

  public entry fun setup(_owner: &PackageOwnerCap, ctx: &mut TxContext) {
    // one timed called
    donable::init_donor_board(ctx);
    donable::init_donation_board(ctx);
    campaignable::init_campaign_board(ctx);
    taxonomical::init_taxonomy_board(ctx);

  }

  public entry fun register_donor(name: String, email: String, board: &mut DonorBoard, ctx: &mut TxContext): bool {
    donable::register_donor(name, email, board, ctx)
  }

  public entry fun register_campaign(code: String, name: String, desc: String, url: String, target_value: u64, start_date: u64, end_date: u64, board: &mut CampaignBoard, ctx: &mut TxContext): bool {
    campaignable::register_campaign(code, name, desc, url, target_value, start_date, end_date, board, ctx)
  }
}