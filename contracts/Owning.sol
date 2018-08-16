/*****************************************************************************\

file:   Owning.sol
ver:    0.3.2
updated:16-Aug-18
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
* Using Solidity 0.4.24 syntax
* dropped use of `interface` and reverting back to abstract contracts. see:
  https://github.com/ethereum/solidity/issues/4832
* Changed from `Itfc` to `Abstract` suffix

\*****************************************************************************/

pragma solidity ^0.4.24;

import "./Owned.sol";

contract OwningAbstract
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


contract Owning is Owned, OwningAbstract
{
    /// @notice Contract to recieve ownership of `_kAddr`
    /// @param _kAddr An address of an `Owned` contract
    function receiveOwnershipOf(address _kAddr)
        public
        returns (bool)
     {
        require(OwnedAbstract(_kAddr).acceptOwnership());
        emit ReceivedOwnership(_kAddr);
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
        emit ChangeOwnerOf(_kAddr, _owner);
        return true;
    }
}