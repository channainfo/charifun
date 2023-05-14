#[test_only]
module charifun::sum_test {
  use charifun::sum;

  #[test]
  public fun sum_test() {
    let a: u32 = 10u32;
    let b: u32 =  20u32;

    let result = sum::sum(a, b);
    assert!(result == 30u32, 0);
  }
}