// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Proposal.sol";

///@title Votiply
///@author Olayinka
contract Votiply is Ownable, Proposal("") {
    ProposalDetails proposal;
    ProposalDetails[] proposals;

    event ProposalCreated(uint256);

    function newProposal(string calldata _question) external onlyOwner {
        emit ProposalCreated(proposals.length);
        proposal = proposals.push();
        proposal._creator = msg.sender;
        proposal._decision = _question;
    }

    function getProposal()
        public
        view
        override
        returns (string memory _decision)
    {
        _decision = proposal._decision;
        return _decision;
    }
}
