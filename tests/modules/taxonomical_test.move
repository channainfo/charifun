#[test_only]
module charifun::taxonomical_test {

  #[test]
  public fun test_init_taxonomy_board(){

    use sui::test_scenario;

    use charifun::taxonomical::{Self, TaxonomyBoard, Taxonomy};

    let owner = @0x0001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      taxonomical::init_taxonomy_board(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<TaxonomyBoard>(&scenario);
      let cat: &Taxonomy = taxonomical::find_category(&board);
      let tag: &Taxonomy = taxonomical::find_tag(&board);
      let label: &Taxonomy = taxonomical::find_lable(&board);

      assert!(taxonomical::is_category(cat) == true, 0);
      assert!(taxonomical::is_tag(tag) == true, 0);
      assert!(taxonomical::is_label(label) == true, 0);

      assert!(taxonomical::taxons_count(cat) == 0u64, 0);
      assert!(taxonomical::taxons_count(tag) == 0u64, 0);
      assert!(taxonomical::taxons_count(label) == 0u64, 0);

      test_scenario::return_shared<TaxonomyBoard>(board);
    };

    test_scenario::end(scenario);
  }

  #[test]
  public fun test_register_taxon() {

    use sui::test_scenario;

    use charifun::taxonomical::{Self, TaxonomyBoard};

    use std::string::{Self};

    let owner = @0x0001;
    let scenario = test_scenario::begin(owner);

    {
      let ctx = test_scenario::ctx(&mut scenario);
      taxonomical::init_taxonomy_board(ctx);
    };

    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<TaxonomyBoard>(&scenario);
      let ctx = test_scenario::ctx(&mut scenario);

      let name = string::utf8(b"flood relief fun");
      let code = string::utf8(b"flood-relief");
      let excerpt = string::utf8(b"");
      let content = string::utf8(b"");
      let type = 0u8;

      // Expect register_taxon is ok
      let result = taxonomical::register_taxon(name, code, excerpt, content, type, &mut board, ctx);
      assert!(result == true, 0);

      test_scenario::return_shared<TaxonomyBoard>(board);
    };

    // Expect output
    let effects = test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<TaxonomyBoard>(&scenario);

      let name = string::utf8(b"flood relief fun");
      let code = string::utf8(b"flood-relief");
      let type = 0u8;

      // Expect the taxon is saved with correct values
      let taxon = taxonomical::find_taxon_by_code(&board, code, type);
      assert!(taxonomical::taxon_code(taxon) == &code, 0);
      assert!(taxonomical::taxon_name(taxon) == &name, 0);

      // Expect taxonomy is updated
      let taxonomy = taxonomical::find_category(&board);
      assert!(taxonomical::taxons_count(taxonomy) == 1, 0);

      test_scenario::return_shared<TaxonomyBoard>(board);
    };

    // Expect one event created: TaxonCreatedEvent
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    // try to register the existing taxon, it will failed
    test_scenario::next_tx(&mut scenario, owner);
    {
      let board = test_scenario::take_shared<TaxonomyBoard>(&scenario);
      let ctx = test_scenario::ctx(&mut scenario);

      let name = string::utf8(b"");
      let code = string::utf8(b"flood-relief");
      let excerpt = string::utf8(b"");
      let content = string::utf8(b"");
      let type = 0u8;

      let result = taxonomical::register_taxon(name, code, excerpt, content, type, &mut board, ctx);
      assert!(result == false, 0);

      test_scenario::return_shared<TaxonomyBoard>(board);
    };
    test_scenario::end(scenario);
  }
}