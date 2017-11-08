## Owned and Owning
Version 0.3.0

## Release Notes
* fixed == to = bug in `changeOwner()`. Thanks @hugopeixoto
* Moved `receiveOwnership() into new contract `Owning`
* Added contract `Ownable` which derives from `Owned` and `Owning`

## Owned

An expanded `Owned` API for safe two stage ownership transfers.

This API encodes a safe pattern of ownership transfers in which ownership does
not change until the new owner accepts the ownership thus proving the new owner
address is capable of calling. This prevents inadvertant loss of contract
control by assigning ownership to an incorrect address.

### ABI
```
[{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
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

## Owning
A contract of type `Owning` provisions the contract to call `acceptOwnership()`
upon an `Owned` contract.

### ABI
```
[{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
```

### receiveOwnership
```
function receiveOwnership(address _kAddr) public returns (bool);
```
To be implemented by a contact which can own `Owned` contracts.
The contract calls `acceptOwnership()` upon an `Owned` contract.

`_kAddr` The address of a contract.

returns success boolean.

### ReceivedOwnership
```
event ReceivedOwnership(address indexed _kAddr);
```
Logged when a contract accepts ownership of another contract.

## Ownable
A contract deriving from `Owned` and `Owning` API.

### ABI
```
[{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_kAddr","type":"address"}],"name":"receiveOwnership","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"changeOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_kAddr","type":"address"}],"name":"ReceivedOwnership","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangeOwnerTo","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_oldOwner","type":"address"},{"indexed":true,"name":"_newOwner","type":"address"}],"name":"ChangedOwner","type":"event"}]
```