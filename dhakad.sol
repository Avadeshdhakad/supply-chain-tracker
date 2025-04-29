// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainTracker {
    struct Product {
        string name;
        address currentOwner;
        string status;
    }

    mapping(uint => Product) public products;
    uint public productCount = 0;

    event ProductAdded(uint indexed productId, string name, address indexed owner);
    event ProductUpdated(uint indexed productId, string status, address indexed newOwner);

    function addProduct(string memory _name, string memory _status) public {
        productCount++;
        products[productCount] = Product(_name, msg.sender, _status);
        emit ProductAdded(productCount, _name, msg.sender);
    }

    function updateProduct(uint _productId, string memory _newStatus, address _newOwner) public {
        require(products[_productId].currentOwner == msg.sender, "Only current owner can update.");
        products[_productId].status = _newStatus;
        products[_productId].currentOwner = _newOwner;
        emit ProductUpdated(_productId, _newStatus, _newOwner);
    }
}
