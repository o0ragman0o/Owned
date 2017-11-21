/*****************************************************************************\

file:   Disownable.sol
ver:    0.3.1
updated:21-Nov-2017
author: Darryl Morris (o0ragman0o)
email:  o0ragman0o AT gmail.com

To provision a contract to allow an owner to explicitly delete ownership

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See MIT Licence for further details.
<https://opensource.org/licenses/MIT>.

Change Log
----------
* Added interface to `Owning.sol

\*****************************************************************************/

pragma solidity ^0.4.13;

import "./Owned.sol";

interface DisownableItfc
{
    /// @notice WARNING: This will remove all ownership of the contract
    /// @param _safePhrase Must be equal to "This contract is to be disowned."
    /// @return A boolean success value
	function burnOwnership(bytes32 _safePhrase) public returns (bool);
}

contract Disownable is Owned, DisownableItfc
{
    /// @notice WARNING: This will remove all ownership of the contract
    /// @param _safePhrase Must be equal to "This contract is to be disowned."
    /// @return A boolean success value
	function burnOwnership(bytes32 _safePhrase)
		public
		onlyOwner
		returns (bool)
	{
		require(_safePhrase == "This contract is to be disowned.");
    	ChangedOwner(owner, 0x0);
		delete owner;
		return true;
	}
}
