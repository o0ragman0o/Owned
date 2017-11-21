## Owned and Owning
Version 0.3.1

## OwnedAbstract and Owned

An expanded `Owned` API for safe two stage ownership transfers.

This API encodes a safe pattern of ownership transfers in which ownership does
not change until the new owner accepts the ownership thus proving the new owner
address is capable of calling. This prevents inadvertant loss of contract
control by assigning ownership to an incorrect address.

This contract does not initialise the owner with an address and must be done by
the deriving contract

### Heritage
```
OwnedAbstract <- Owned
```

### ABI
```
[{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
```

### owner
```
function owner() public constant returns (address);
```
Returns the address of the contract's current owner.

### newOwner
```
function newOwner() public constant returns (address);
```
Returns the address which is permissioned to accept ownership of the contract

### changeOwner
```
function changeOwner(address _newOwner) public returns (bool);
```
Permissions an address to accept ownership.

`_newOwner` The address to permission ownership acceptance.

Returns success boolean

### acceptOwnership
```
function acceptOwnership() public returns (bool);
```
Allows a permissioned address to take ownership of the contract.

### ChangeOwner
```
event ChangeOwnerTo(address indexed _newOwner);
```
Logged on initiation of ownership transfer.

```
event ChangedOwner(address indexed _oldOwner, address indexed _newOwner);
```
Logged on change of owner address.


## OwningItfc and Owning is Owned, OwningItfc
A contract of type `Owning` provisions the contract to call `acceptOwnership()`
upon an `Owned` contract.

### Heritage
```
OwnedAbstract <- Owned -.
                        |
OwningItfc <------------+- Owning
```

### ABI
```
[{"constant":false,"inputs":[{"name":"_kAddr","type":"address"}],"name":"receiveOwnershipOf","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_kAddr","type":"address"},{"name":"_owner","type":"address"}],"name":"changeOwnerOf","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_kAddr","type":"address"}],"name":"ReceivedOwnership","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_kAddr","type":"address"},{"indexed":true,"name":"_owner","type":"address"}],"name":"ChangeOwnerOf","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
```

### receiveOwnershipOf
```
function receiveOwnershipOf(address _kAddr) public returns (bool);
```
Calls `acceptOwnership()` upon an `Owned` contract.

`_kAddr` The address of a contract.

Returns boolean success value

### changeOwnerOf
```
function changeOwnerOf(address _kAddr, address _owner) public returns (bool)
```
Change the owner of the owned contract `_kAddr` to `_owner`

`_kAddr` The address of the owned contract

`_owner` The address of the new owner

Returns boolean success value

### ReceivedOwnership
```
event ReceivedOwnership(address indexed _kAddr);
```
Logged when a contract accepts ownership of another contract.


## DisownableItfc and Disownable is Owned, DisownableItfc
Disownable is an `Owned` contract that explicitly allows deleting the `owner`.  This may be a requirement for trustless contracts.

### Heritage
```
OwnedAbstract <- Owned -.
                        |
DisownableItfc <--------+- Disownable
```

### ABI
```
[{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_safePhrase","type":"bytes32"}],"name":"burnOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
```

### burnOwnership
```
function burnOwnership(bytes32 _safePhrase);
```
Deletes the `owner` state variable.

WARNING: This will block all calls to functions which are permissioned only to the owner.

`_safePhrase` Must be equal to the string *"This contract is to be disowned."*

Returns boolean success value
