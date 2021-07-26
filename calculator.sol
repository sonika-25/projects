pragma solidity 0.8.0;

contract Calculator {

  int finalResult = 0;

  function add (int a, int b) public returns(int){
    finalResult = a+b;
    return finalResult;
  }
  function subtract (int a, int b) public returns(int){
    finalResult = a-b;
    return finalResult;
  }
  function multiply (int a, int b) public returns(int){
    finalResult = a*b;
    return finalResult;
  }
  function divide (int a, int b) public returns(int){
    finalResult = a/b;
    return finalResult;
  }
  function getFinalResult() public view returns(int){
    return finalResult;
  }
}
