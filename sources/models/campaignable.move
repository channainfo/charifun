module charifun::campaignable {

  use sui::object::{ Self, UID, ID };
  use sui::tx_context::{Self,TxContext};
  use sui::transfer;
  use sui::dynamic_object_field;
  use sui::event;

  use charifun::libs::{ Self };

  use std::string::{ Self, String };

  const STATE_PENDING :vector<u8> = b"pending";
  const STATE_RUNNING :vector<u8> = b"running";
  const STATE_CLOSED :vector<u8> = b"closed";

  struct CampaignBoard has key, store {
    id: UID,
    campaigns_count: u64
  }

  struct Campaign has key, store{
    id: UID,
    code: String,
    name: String,
    desc: String,
    url: String,
    target_value: u64,
    received_value: u64,
    donations_count: u64,
    donors_count: u64,
    owner: address,
    start_date: u64,
    end_date: u64,
    state: String,
    created_at: u64
  }

  struct CampaignCreatedEvent has copy, drop {
    campaign_id: ID,
    code: String,
    name: String,
    desc: String,
    url: String,
    target_value: u64,
    owner: address,
    start_date: u64,
    end_date: u64,
    created_at: u64
  }

  public fun init_campaign_board(ctx: &mut TxContext) {
    let board = CampaignBoard {
      id: object::new(ctx),
      campaigns_count: 0u64
    };

    transfer::public_share_object(board);
  }

  public fun register_campaign(code: String, name: String, desc: String, url: String, target_value: u64, start_date: u64, end_date: u64, board: &mut CampaignBoard, ctx: &mut TxContext): bool {
    let key: vector<u8> = libs::hash(&code);

    if(dynamic_object_field::exists_<vector<u8>>(&board.id, key)){
      return false
    };

    let owner = tx_context::sender(ctx);

    let campaign = Campaign {
      id: object::new(ctx),
      code,
      name,
      desc,
      url,
      target_value,
      received_value: 0u64,
      donations_count: 0u64,
      donors_count: 0u64,
      owner,
      start_date,
      end_date,
      state: string::utf8(STATE_PENDING),
      created_at: tx_context::epoch_timestamp_ms(ctx)
    };

    let campaign_id = object::uid_to_inner(&campaign.id);
    dynamic_object_field::add<vector<u8>, Campaign>(&mut board.id, key, campaign);

    board.campaigns_count = board.campaigns_count + 1u64;

    let campaign_created_event = CampaignCreatedEvent {
      campaign_id,
      code,
      name,
      desc,
      url,
      target_value,
      owner,
      start_date,
      end_date,
      created_at: tx_context::epoch_timestamp_ms(ctx)
    };

    event::emit(campaign_created_event);
    true
  }

  public fun campaign_by_code(board: &CampaignBoard, code: &String): &Campaign {
    let key = libs::hash(code);

    dynamic_object_field::borrow<vector<u8>, Campaign>(&board.id, key)
  }

  public fun campaigns_count(board: &CampaignBoard): u64 {
    board.campaigns_count
  }

  public fun code(campaign: &Campaign): &String {
    &campaign.code
  }

  public fun name(campaign: &Campaign): &String {
    &campaign.name
  }

  public fun desc(campaign: &Campaign): &String {
    &campaign.desc
  }

  public fun url(campaign: &Campaign): &String {
    &campaign.url
  }

  public fun target_value(campaign: &Campaign): u64 {
    campaign.target_value
  }

  public fun start_date(campaign: &Campaign): u64 {
    campaign.start_date
  }

  public fun end_date(campaign: &Campaign): u64 {
    campaign.end_date
  }


}