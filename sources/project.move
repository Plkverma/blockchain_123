module MyModule::CommunityVoting {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a voting proposal.
    struct Proposal has store, key {
        proposer: address,       // Address of the proposer
        description: vector<u8>, // Description of the proposal
        yes_votes: u64,          // Count of "yes" votes
        no_votes: u64,           // Count of "no" votes
    }

    /// Function to create a new proposal.
    public fun create_proposal(proposer: &signer, description: vector<u8>) {
        let proposal = Proposal {
            proposer: signer::address_of(proposer),
            description,
            yes_votes: 0,
            no_votes: 0,
        };
        move_to(proposer, proposal);
    }

    /// Function for a community member to vote on a proposal.
    public fun vote(proposer_address: address, vote_type: bool) acquires Proposal {
        let proposal = borrow_global_mut<Proposal>(proposer_address);

        // Increment the vote count based on the vote type
        if (vote_type) {
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            proposal.no_votes = proposal.no_votes + 1;
        }
    }
}
