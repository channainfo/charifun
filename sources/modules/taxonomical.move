module charifun::taxonomical {
  const CATEGORY: u8 = 0;
  const TAG: u8 = 1;
  const LABEL: u8 = 2;

  use sui::tx_context::{Self, TxContext};
  use sui::object::{Self, UID, ID};
  use sui::dynamic_object_field;
  use sui::transfer;
  use sui::event;

  use std::string::{String};
  use std::vector::{Self};

  struct TaxonomyBoard has key, store {
    id: UID,
    taxonomies_count: u64
  }

  struct Taxonomy has key, store {
    id: UID,
    taxons_count: u64,
    type: u8
  }

  struct Taxon has key, store {
    id: UID,
    name: String,
    code: String,
    excerpt: String,
    content: String,
    type: u8,
  }

  struct TaxonCreatedEvent has drop, copy {
    taxon_id: ID,
    name: String,
    code: String,
    excerpt: String,
    content: String,
    type: u8,
    created_at: u64
  }

  public fun init_taxonomy_board(ctx: &mut TxContext) {
    let taxs = vector::empty<u8>();

    vector::push_back(&mut taxs, CATEGORY);
    vector::push_back(&mut taxs, TAG);
    vector::push_back(&mut taxs, LABEL);

    let board = TaxonomyBoard{
      id: object::new(ctx),
      taxonomies_count: 0
    };

    let i = 0u64;
    while(i < vector::length(&taxs)){
      let type = *vector::borrow(&taxs, i);
      let taxonomy = Taxonomy {
        id: object::new(ctx),
        taxons_count: 0,
        type
      };

      dynamic_object_field::add(&mut board.id, type, taxonomy);
      i = i + 1;
    };

    transfer::public_share_object(board);
  }

  public fun find_taxonomy_by_type(board: &TaxonomyBoard, type: u8): &Taxonomy {
    dynamic_object_field::borrow<u8, Taxonomy>(&board.id, type)
  }

  public fun find_category(board: &TaxonomyBoard): &Taxonomy {
    find_taxonomy_by_type(board, CATEGORY)
  }

  public fun find_tag(board: &TaxonomyBoard): &Taxonomy {
    find_taxonomy_by_type(board, TAG)
  }

  public fun find_lable(board: &TaxonomyBoard): &Taxonomy {
    find_taxonomy_by_type(board, LABEL)
  }

  public fun find_taxon_by_code(board: &TaxonomyBoard, code: String, type: u8): &Taxon {
    let taxonomy = find_taxonomy_by_type(board, type);

    dynamic_object_field::borrow<String, Taxon>(&taxonomy.id, code)
  }

  public fun is_category(board: &Taxonomy): bool {
    board.type == CATEGORY
  }

  public fun is_tag(board: &Taxonomy): bool {
    board.type == TAG
  }

  public fun is_label(board: &Taxonomy): bool {
    board.type == LABEL
  }

  public fun taxonomy_type(taxonomy: &Taxonomy): u8 {
    taxonomy.type
  }

  public fun taxons_count(taxonomy: &Taxonomy): u64 {
    taxonomy.taxons_count
  }

  public fun taxon_name(taxon: &Taxon): &String {
    &taxon.name
  }

  public fun taxon_code(taxon: &Taxon): &String {
    &taxon.code
  }

  public fun register_taxon_in_category(name: String, code: String, excerpt: String, content: String, board: &mut TaxonomyBoard, ctx: &mut TxContext): bool {
    register_taxon(name, code, excerpt, content, CATEGORY, board, ctx)
  }

  public fun register_taxon_in_tag(name: String, code: String, excerpt: String, content: String, board: &mut TaxonomyBoard, ctx: &mut TxContext): bool {
    register_taxon(name, code, excerpt, content, TAG, board, ctx)
  }

  public fun register_taxon_in_label(name: String, code: String, excerpt: String, content: String, board: &mut TaxonomyBoard, ctx: &mut TxContext): bool {
    register_taxon(name, code, excerpt, content, LABEL, board, ctx)
  }

  public fun register_taxon(name: String, code: String, excerpt: String, content: String, type: u8, board: &mut TaxonomyBoard, ctx: &mut TxContext): bool {
    let taxonomy = dynamic_object_field::borrow_mut<u8, Taxonomy>(&mut board.id, type);
    let exists = dynamic_object_field::exists_<String>(&taxonomy.id, code);

    if(exists) {
      return false
    };

    let id = object::new(ctx);
    let taxon_id = object::uid_to_inner(&id);

    let taxon = Taxon {
      id,
      name,
      code,
      excerpt,
      content,
      type
    };

    dynamic_object_field::add<String, Taxon>(&mut taxonomy.id, code, taxon);
    taxonomy.taxons_count = taxonomy.taxons_count + 1 ;

    let created_at = tx_context::epoch(ctx);
    let taxon_created_event = TaxonCreatedEvent {
      taxon_id,
      name,
      code,
      excerpt,
      content,
      type,
      created_at
    };

    event::emit(taxon_created_event);
    true
  }
}