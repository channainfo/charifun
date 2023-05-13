#[test_only]
module charifun::sum_test {
  use charifun::sum;
  use std::debug;

  #[test]
  public fun sum_test() {
    let a: u32 = 10u32;
    let b: u32 =  20u32;

    let result = sum::sum(a, b);

    debug::print(&result);
    assert!(result == 30u32, 0);

  }
}