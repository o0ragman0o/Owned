## Version 0.3.2 
* Using Solidity 0.4.24 syntax

## Version 0.3.1
* Added OwningItfc
* Added DisownableItfc

## Version 0.3.0
* fixed == to = bug in `changeOwner()`. Thanks @hugopeixoto
* Moved `receiveOwnership() into new contract `Owning`
* Added contract `Owning` which derives from `Owned` adds `changeOwnerOf()`
