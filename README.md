## Owned

An expanded `Owned` API for user and inter-contract ownership and safe ownership transfers.

This API encodes a safe pattern of contract ownership transfers in which ownership does not change until the new owner accepts the ownership thus proving the new owner address is capable of calling. This prevents inadvertant loss of contract control by assigning ownership to a wrong address.

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

### receiveOwnership
```
function receiveOwnership(address _kAddr) public returns (bool);
```
Allows the contract to accept ownership by calling `acceptOwnership()` of another contract.

`_kAddr` The address of a contract.

returns success boolean.

Optional: Requires implementation per contract requirement

### ChangeOwner
```
event ChangeOwnerTo(address indexed _newOwner);
```
Triggered on initiation of ownership transfer.

```
event ChangedOwner(address indexed _oldOwner, address indexed _newOwner);
```
Triggered on change of owner address.

### ReceivedOwnership
```
event ReceivedOwnership(address indexed _kAddr);
```
Triggered when the contract accepts ownership of another contract.

Optional: Requires implementation per contract requirement