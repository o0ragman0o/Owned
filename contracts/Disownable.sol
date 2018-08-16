/*****************************************************************************\

file:   Disownable.sol
ver:    0.3.2
updated:16-Aug-2016
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
* Using Solidity 0.4.24 syntax
* dropped use of `interface` and reverting back to abstract contracts. see:
  https://github.com/ethereum/solidity/issues/4832
* Changed from `Itfc` to `Abstract` suffix


\*****************************************************************************/

pragma solidity ^0.4.24;

import "./Owned.sol";

contract DisownableAbstract
{
    /// @notice WARNING: This will remove all ownership of the contract
    /// @param _safePhrase Must be equal to "This contract is to be disowned."
    /// @return A boolean success value
	function burnOwnership(bytes32 _safePhrase) public returns (bool);
}

contract Disownable is Owned, DisownableAbstract
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
    	emit ChangedOwner(owner, 0x0);
		delete owner;
		return true;
	}
}
