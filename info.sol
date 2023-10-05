// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*
A very simple smart contract that stores hashed information for a wallet address,
then allows anyone to verify the information that is stored.
*/

contract Info {

  mapping (address => bytes32) public information;
  
  //Input the already made hash, to avoid letting someone see the raw input.
  //This is the only function that adds data to the blockchain.
  function addRecord(address client, bytes32 info) external{
    information[client] = info;
  }

  //This simply calls the keccak256 hashing function for ease of interaction with the other functions.
  function callKeccak256(string calldata input) public pure returns(bytes32 result){
      return keccak256(abi.encode(input));
  }
  
  //Input the raw string, compute the hash, then check if the hash matches the stored data.
  function checkRecord(address client, string calldata info) public view returns(bool verification){
    if (information[client] == keccak256(abi.encode(info))) {
      return true;
    } else {
      return false;
    }
  }

}
