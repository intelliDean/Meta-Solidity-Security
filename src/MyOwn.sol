// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/*
Summary of Fixes
Uninitialized Storage Pointer: Fixed by using the memory keyword for local variables in the store function.
Constructor Syntax: Updated to use the constructor keyword.
Events: Added an event StorageUpdated to log storage updates.
Visibility of owner Variable: Explicitly marked owner as public.
*/

contract StorageVictim {

    address public owner;

    struct Storage {
        address user;
        uint amount;
    }

    mapping(address => Storage) storages;

    event StorageUpdated(address indexed user, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function store(uint _amount) public {
        Storage memory str;
        str.user = msg.sender;
        str.amount = _amount;

        storages[msg.sender] = str;

        emit StorageUpdated(msg.sender, _amount);
    }

    function getStore() public view returns (address, uint) {
        Storage memory str = storages[msg.sender];
        return (str.user, str.amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}




/*
Contract Overview
The StorageVictim contract allows users to store an amount associated with their address and retrieve this stored data later. It also allows querying the contract owner’s address.

Findings and Potential Vulnerabilities
Uninitialized Storage Pointer:

Issue: In the original contract, the local variable Storage str; is uninitialized and points to storage location 0, which can lead to unexpected behavior.
Risk: High. This can corrupt the state of the contract by unintentionally modifying storage.
Lack of Access Control on store Function:

Issue: Any user can call the store function to store data.
Risk: Low. This is by design, but should be noted for use cases requiring access control.
Use of Deprecated Constructor Syntax:

Issue: The constructor uses the old Solidity constructor syntax.
Risk: Low. This is a non-critical issue but should be updated for modern Solidity standards.
Lack of Events:

Issue: The contract does not emit any events for actions like storing data.
Risk: Medium. Lack of events makes it difficult to track activity on the blockchain.
Visibility of owner Variable:

Issue: The owner variable was not explicitly marked as public.
Risk: Low. Visibility should be explicitly stated for clarity and best practices.
Recommendations
Fix Uninitialized Storage Pointer:
Solution: Use memory keyword for local variables to avoid unintended storage reference.
Use Explicit Constructor Syntax:
Solution: Update the constructor to use the constructor keyword.
Add Events:
Solution: Add events to log significant actions like storing data.
Improve Code Readability and Safety:
Solution: Mark the owner variable as public for better readability.
*/