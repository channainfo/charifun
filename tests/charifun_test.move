#[test_only]
module charifun::charity_test {
  use charifun::charity;
  use std::debug;

  #[test]
  public fun sum_test() {
    let a: u32 = 10u32;
    let b: u32 =  20u32;

    let result = charity::sum(a, b);

    debug::print(&result);
    assert!(result == 30u32, 0);

  }
}