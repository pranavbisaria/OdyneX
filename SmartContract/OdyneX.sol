// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract OdyneX{
    struct Access{
        address user;
        bool access;
    }
    mapping(address=>string[]) myData; // User Data Here Stores
    mapping(address=>mapping(address=>bool)) ownership;
    mapping(address=>Access[]) accessList;
    mapping(address=>mapping(address=>bool)) previousData;

    function add(address currentUser, string memory url) external{
        myData[currentUser].push(url);
    }
    function allowAccess(address userToBeAllowed) external{
        ownership[msg.sender][userToBeAllowed]=true;
        if(previousData[msg.sender][userToBeAllowed]){
            for(uint i=0; i<accessList[msg.sender].length; i++){
                if(accessList[msg.sender][i].user== userToBeAllowed){
                    accessList[msg.sender][i].access = true;
                }
            }
        }
        else{
            accessList[msg.sender].push(Access(userToBeAllowed, true));
            previousData[msg.sender][userToBeAllowed] = true;
        }
    }
    function disallowAccess(address userToBeDisallowed) external{
        ownership[msg.sender][userToBeDisallowed]=false;
        for(uint i=0; i<accessList[msg.sender].length; i++){
            if(accessList[msg.sender][i].user == userToBeDisallowed){
                accessList[msg.sender][i].access = false;
            }
        }
    }
    function display(address currentUser) external view returns(string[] memory){
        require(currentUser==msg.sender || ownership[currentUser][msg.sender], "You don't have the access");
        return myData[currentUser];
    }
    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }
}