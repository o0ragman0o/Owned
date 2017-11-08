/******************************************************************************\

file:   Owned.sol
ver:    0.3.0
updated:8-Nov-2017
author: Darryl Morris (o0ragman0o)
email:  o0ragman0o AT gmail.com

An expanded `Owned` API for user and inter-contract ownership and safe ownership
transfers.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See MIT Licence for further details.
<https://opensource.org/licenses/MIT>.

Change Log
----------
* fixed == to = bug in `changeOwner()`. Thanks @hugopeixoto
* Added contract `Owning`
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

	/// @dev Logged on initiation of change owner address
    event ChangeOwnerTo(address indexed _newOwner);

    /// @dev Logged on change of owner address
    event ChangedOwner(address indexed _oldOwner, address indexed _newOwner);

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

    /// @notice Initiate a change of owner to `_newOwner`
    /// @param _newOwner The address to which ownership is to be transfered
    function changeOwner(address _newOwner) public returns (bool);

    /// @dev optional
    /// @notice Finalise change of ownership to newOwner
    function acceptOwnership() public returns (bool);
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
}
