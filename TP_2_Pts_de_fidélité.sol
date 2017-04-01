pragma solidity ^0.4.0;
contract point_fidelite
    {
    struct Inscrit
    {
        string prenom;
        string nom;
        uint nb_pt;
        bool inscription;
        address delegate;
    }
    

    address chairperson;
    mapping(address =>Inscrit ) Inscrits;

        modifier ownerOnly(){
        if (msg.sender !=chairperson)throw;
        _;
    }

    
    function inscription(address Inscrit)
    {
        if (Inscrits[Inscrit].inscription== false)
        Inscrits[Inscrit].inscription=true;
    }

    ///Give point to a person
    function givePoint(address Inscrit, uint point) 
    {
        if (msg.sender != chairperson || Inscrits[Inscrit].inscription) return;
        Inscrits[Inscrit].nb_pt = point;
    }

    /// Delegate your points to fidel.
    function delegate(address to , uint point) 
    {
        Inscrit sender = Inscrits[msg.sender]; // assigns reference
        if (point>delegate.nb_pt)
        point=delegate.nb_pt;
        if (sender.inscription) return;
        while (Inscrits[to].delegate != address(0) && Inscrits[to].delegate != msg.sender)
            to = Inscrits[to].delegate;
        if (to == msg.sender) return;
        sender.inscription = true;
        sender.delegate = to;
        Inscrit delegate = Inscrits[to];
        if (delegate.inscription)
          delegate.nb_pt += sender.nb_pt;  
    }

    function kill()
    {
        if(msg.sender == chairperson)selfdestruct(chairperson);
    }

}