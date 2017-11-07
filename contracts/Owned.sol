/******************************************************************************\

file:   Owned.sol
ver:    0.2.0
updated:26-Aug-2017
author: Darryl Morris (o0ragman0o)
email:  o0ragman0o AT gmail.com

An expanded `Owned` API for user and inter-contract ownership and safe ownership
transfers.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See MIT Licence for further details.
<https://opensource.org/licenses/MIT>.

\******************************************************************************/

pragma solidity ^0.4.13;

contract OwnedAbstract {

//
// State Variable
//

    /// @return The address of the contract's owner
	address owner;

	/// @dev optional
	/// @return An address which can accept ownership.
	address newOwner;

	/// @dev Triggered on initiation of change owner address
    event ChangeOwnerTo(address indexed _newOwner);

    /// @dev Triggered on change of owner address
    event ChangedOwner(address indexed _oldOwner, address indexed _newOwner);

    /// @dev Triggered when the contract accepts ownership of another contract.
    // event ReceivedOwnership(address indexed _kAddr);

//
// Modifiers
//

    modifier onlyOwner {
		require (msg.sender == owner);
		_;
	}
	
//
// Function Abstracts
//

    /// @notice Initiate a change of owner to `_newOowner`
    /// @param _newOwner The address to which ownership is to be transfered
    function changeOwner(address _newOwner) public returns (bool);

    /// @dev optional
    /// @notice Finalise change of ownership to newOwner
    function acceptOwnership() public returns (bool);

    /// @dev optional
    /// @notice This contract will call `_kAddr`.acceptOwnership()
    /// @param _kAddr A thirdparty contract which this contract can accept
    /// ownership
    // function receiveOwnership(address _kAddr) public returns (bool);
}

// Example implementation.
contract Owned is OwnedAbstract{

	function changeOwner(address _newOwner)
		public
		onlyOwner
		returns (bool)
	{
		newOwner = _newOwner;
	    ChangeOwnerTo(_newOwner);
		return true;
	}

	function acceptOwnership()
		public
		returns (bool)
	{
		require(msg.sender == newOwner);
	    ChangedOwner(owner, msg.sender);
		owner = msg.sender;
		return true;
	}


    // Implempent for contracts with ownership functionality over other
    // contracts
    // 	function receiveOwnership(address _kAddr)
    // 		public
    // 		returns (bool)
    // 	{
    // 	    return false;
    // 		require(OwnedAbstract(_kAddr).acceptOwnership());
    // 	    ReceivedOwnership(_kAddr);
    // 	    return true;
    // 	}
}
