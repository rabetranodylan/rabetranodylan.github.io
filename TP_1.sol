# Rcongre.github.io
TP-1 Blockchain
Binome CONGRÉ Régis Dylan RABETRANO

pragma solidity ^0.4.0;
contract vote 
	{
    struct Voter 
    {   
        string prenom;
        string nom;
        bool voted;
        uint vote;
    }
    struct projet 
    {
        string nom_projet;
        uint voteCount;
    }
    uint vote_blanc;
    projet[] public projets;
    mapping(address => Voter) voters;

    modifier ownerOnly(){
        if (msg.sender !=chairperson)throw;
        _;
    }


    /// Crée un nouveau bulletin de vote avec _numprojet
    function Ballot(uint _numprojet) 
    {
        projets.length = _numprojet;
    }

    /// Give $(voter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function giveRightToVote(address voter) 
    {
        if (voters[voter].voted==true)return;
    }


    /// Give a single vote to proposal $(proposal).
    function vote(uint _projet) 
    {
        Voter sender = voters[msg.sender];
        if (sender.voted) return;
        sender.voted = true;
        sender.vote = _projet;
        projets[_projet].voteCount += 1;
        if( _projet >= projets.length)
        vote_blanc += 1;
    }

    function winningProposal() constant returns (uint winningProposal) 
    {
        uint winningVoteCount = 0;
        for (uint projet = 0; projet < projets.length; projet++)
            if (projets[projet].voteCount > winningVoteCount) 
            {
                winningVoteCount = projets[projet].voteCount;
                winningProposal = projet;
            }
    }

    function kill()
    {
        if(msg.sender == chairperson)selfdestruct(chairperson);
    }
}