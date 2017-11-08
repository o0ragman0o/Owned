/*****************************************************************************\

file:   Ownable.sol
ver:    0.3.0
updated:8-Nov-2017
author: Darryl Morris (o0ragman0o)
email:  o0ragman0o AT gmail.com

A contract which can be owned and own other contracts.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See MIT Licence for further details.
<https://opensource.org/licenses/MIT>.

\*****************************************************************************/

pragma solidity ^0.4.13;
import "./Owned.sol";
import "./Owning.sol";

contract Ownable is Owned, Owning
{
	// nothing to implement
}