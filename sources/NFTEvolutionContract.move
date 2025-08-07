module tasmiya_addr::NFTEvolution {
    use aptos_framework::signer;
    use aptos_framework::timestamp;
    struct EvolvingNFT has store, key {
        evolution_level: u64,
        last_interaction: u64,
        interaction_count: u64,
    }
    public fun create_nft(owner: &signer) {
        let nft = EvolvingNFT {
            evolution_level: 1,
            last_interaction: timestamp::now_seconds(),
            interaction_count: 0,
        };
        move_to(owner, nft);
    }
    public fun interact_with_nft(owner: &signer) acquires EvolvingNFT {
        let nft = borrow_global_mut<EvolvingNFT>(signer::address_of(owner));
        let current_time = timestamp::now_seconds();
        nft.interaction_count = nft.interaction_count + 1;
        nft.last_interaction = current_time;
        if (nft.interaction_count % 5 == 0) {
            nft.evolution_level = nft.evolution_level + 1;
        };
    }
}
