/*****************************************************************************\

file:   Owning.sol
ver:    0.3.0
updated:8-Nov-2017
author: Darryl Morris (o0ragman0o)
email:  o0ragman0o AT gmail.com

To provision a contract to own another contract which has implemented the
`Owned` API  

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See MIT Licence for further details.
<https://opensource.org/licenses/MIT>.

Change Log
----------
* pulled out of `Owned` v0.2.0
\*****************************************************************************/

pragma solidity ^0.4.13;

import "./Owned.sol";

contract Owning
{
    /// @dev Logged when the contract accepts ownership of another contract.
    event ReceivedOwnership(address indexed _kAddr);

    /// @notice Contract to recieve ownership of `_kAddr`
    /// @param _kAddr An address of an `Owned` contract
    function receiveOwnershipOf(address _kAddr)
         public
         returns (bool)
     {
         require(OwnedAbstract(_kAddr).acceptOwnership());
         ReceivedOwnership(_kAddr);
         return true;
     }
}