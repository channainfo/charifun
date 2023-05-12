module charifun::main {
  use sui::tx_context::TxContext;

  use std::string::String;

  use charifun::donor;

  public entry fun create_donor(name: String, email: String, ctx: &mut TxContext) {
    donor::create(name, email, ctx);

  }
}