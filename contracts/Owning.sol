/*****************************************************************************\

file:   Owning.sol
ver:    0.3.1
updated:21-Nov-2017
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
* Added OwningItfc
\*****************************************************************************/

pragma solidity ^0.4.13;

import "./Owned.sol";

interface OwningItfc
{
    /// @dev Logged when the contract accepts ownership of another contract.
    event ReceivedOwnership(address indexed _kAddr);

    /// @dev Logged when the contract initiates an ownership change in a
    /// contract it owns.
    event ChangeOwnerOf(address indexed _kAddr, address indexed _owner);

    /// @notice Contract to recieve ownership of `_kAddr`
    /// @param _kAddr An address of an `Owned` contract
    function receiveOwnershipOf(address _kAddr) public returns (bool);

    /// @notice Change the owner of the owned contract `_kAddr` to `_owner`
    /// @param _kAddr The address of the owned contract
    /// @param _owner The address of the new owner
    /// @dev could be used to migrate to an upgraded SandalStraps
    /// @return bool value indicating success
    function changeOwnerOf(address _kAddr, address _owner)
        public returns (bool);
}


contract Owning is Owned, OwningItfc
{
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

    /// @notice Change the owner of the owned contract `_kAddr` to `_owner`
    /// @param _kAddr The address of the owned contract
    /// @param _owner The address of the new owner
    /// @dev could be used to migrate to an upgraded SandalStraps
    /// @return bool value indicating success
    function changeOwnerOf(address _kAddr, address _owner)
        public
        onlyOwner
        returns (bool)
    {
        require(Owned(_kAddr).changeOwner(_owner));
        ChangeOwnerOf(_kAddr, _owner);
        return true;
    }
}