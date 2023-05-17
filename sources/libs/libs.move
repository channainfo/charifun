module charifun::libs {
  use std::string:: {String};

  public fun hash(value: &String): vector<u8> {
    let hash :vector<u8> = std::hash::sha3_256(*std::string::bytes(value));
    hash
  }
}