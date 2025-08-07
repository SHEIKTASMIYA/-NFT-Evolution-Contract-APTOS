module tasmiya_addr::NFTEvolution {
    use aptos_framework::signer;
    use aptos_framework::timestamp;
    
    /// Struct representing an evolving NFT.
    struct EvolvingNFT has store, key {
        evolution_level: u64,    // Current evolution level of the NFT
        last_interaction: u64,   // Timestamp of last interaction
        interaction_count: u64,  // Total number of interactions
    }
    
    /// Function to create a new evolving NFT.
    public fun create_nft(owner: &signer) {
        let nft = EvolvingNFT {
            evolution_level: 1,
            last_interaction: timestamp::now_seconds(),
            interaction_count: 0,
        };
        move_to(owner, nft);
    }
    
    /// Function to interact with NFT and trigger evolution.
    public fun interact_with_nft(owner: &signer) acquires EvolvingNFT {
        let nft = borrow_global_mut<EvolvingNFT>(signer::address_of(owner));
        let current_time = timestamp::now_seconds();
        
        // Update interaction data
        nft.interaction_count = nft.interaction_count + 1;
        nft.last_interaction = current_time;
        
        // Evolve NFT based on interactions (every 5 interactions)
        if (nft.interaction_count % 5 == 0) {
            nft.evolution_level = nft.evolution_level + 1;
        };
    }
}