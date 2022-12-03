// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Proposal.sol";

///@title Votiply
///@author Olayinka
contract Votiply is Ownable, Proposal("") {
    ProposalDetails[] proposals;
    address[] voters;

    event ProposalCreated(uint256);

    function newProposal(string calldata _question) external onlyOwner {
        proposal = proposals.push();
        proposal._creator = msg.sender;
        proposal._decision = _question;
        emit ProposalCreated(proposals.length);
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

    function voteYes(address _voter) external {
        for (uint _voterIndex = 0; _voterIndex < voters.length; ) {
            if (voters[_voterIndex] != _voter) {
                addVoter(_voter);
            }
            unchecked {
                ++_voterIndex;
            }
        }
        proposal._yesCount++;
    }

    function voteNo(address _voter) external {
        for (uint _voterIndex = 0; _voterIndex < voters.length; ) {
            if (_voter != voters[_voterIndex]) {
                addVoter(_voter);
            }
            unchecked {
                ++_voterIndex;
            }
        }
        proposal._noCount++;
    }

    function addVoter(address _voter) private {
        voters.push(_voter);
    }

    function getYesVoteCount() external view returns (uint256 yesCount) {
        yesCount = proposal._yesCount;
        return yesCount;
    }

    function getNoVoteCount() external view returns (uint256 noCount) {
        noCount = proposal._noCount;
        return noCount;
    }
}
