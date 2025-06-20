// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Buildblock {
    struct Material {
        string name;
        string origin;
        uint256 carbonFootprint; // in kg CO2 per unit
        uint256 price;
        address supplier;
    }

    address public admin;

    mapping(uint256 => Material) public materials;
    uint256 public materialCount;

    event MaterialAdded(uint256 id, string name, string origin, uint256 carbonFootprint, uint256 price, address supplier);
    event PriceUpdated(uint256 id, uint256 newPrice);

    constructor() {
        admin = msg.sender;
    }

    function addMaterial(string memory _name, string memory _origin, uint256 _carbonFootprint, uint256 _price) public {
        materials[materialCount] = Material(_name, _origin, _carbonFootprint, _price, msg.sender);
        emit MaterialAdded(materialCount, _name, _origin, _carbonFootprint, _price, msg.sender);
        materialCount++;
    }

    function updatePrice(uint256 _id, uint256 _newPrice) public {
        require(msg.sender == materials[_id].supplier, "Only supplier can update price");
        materials[_id].price = _newPrice;
        emit PriceUpdated(_id, _newPrice);
    }

    function getMaterial(uint256 _id) public view returns (Material memory) {
        return materials[_id];
    }
}
