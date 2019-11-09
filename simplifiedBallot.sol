pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

contract Ballot {
    struct Voter {
        bool voted;  // true si esa persona ya ha votado
        address delegate; // persona a la que se delega el voto
    }

    // Representa una opcion
    struct option {
        bytes Name;//hashOfName   // nombre corto (hasta 32 bytes)
        bytes Company;//hashOfCompany
        bytes Type;//hashOfType
        uint CountOfVotes;
    }

    //Diccionario 
    mapping(address => Voter) public voters;

    //Diccionario de opciones
    option[] public options;

    constructor() public {
        options.push(option({Name:"Blockchain", Company:"Everis", Type:"Challenge", CountOfVotes:0}));
        options.push(option({Name:"APP Móvil", Company:"esPublico", Type:"Challenge", CountOfVotes:0}));
        options.push(option({Name:"Alexa y Ayto ZGZ", Company:"UST Global", Type:"Starter", CountOfVotes:0}));
        options.push(option({Name:"Picking por ChatVoice", Company:"Grupo Sesé", Type:"Challenge", CountOfVotes:0}));
    }
    
    function vote(string memory name) public {
        //bytes memory nameEnBytes = bytes(name);
        require(optionsContains(keccak256(bytes(name))) == true, "No valid option");
        require(voters[msg.sender].voted == false, "Already voted.");
        voters[msg.sender].voted = true;
        plusVote(keccak256(bytes(name)));
    }
    
    function plusVote(bytes32 name) public {
        for(uint i = 0; i < options.length; i++) {
            if(keccak256(options[i].Name) == name)
            {
                options[i].CountOfVotes++;
            }
        }
    }
    
    function optionsContains(bytes32 name) public returns (bool) {
        for(uint i = 0; i < options.length; i++) {
            if(keccak256(options[i].Name) == name)
            {
                return true;
            }
        }
        return false;
    }
    
    function result() public view returns (option[] memory)
    {
        return options;
    }
    
    
}