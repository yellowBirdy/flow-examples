pub contract NonFungibleToken {

    pub var count: UInt64

    pub resource NFT {
        pub let id:UInt64
        pub let meta: {String:String}
        init(id:UInt64) {
            self.id = id
            self.meta = {}
        }
    }
    pub resource interface Receiver {
        pub fun deposit(token: @NFT) 
        pub fun getIds(): [UInt64]
        pub fun hasId(id:UInt64): Bool
    }

    pub resource Collection:Receiver {
        pub var tokens: @{UInt64: NFT}

        pub fun withdraw(id:UInt64):@NFT {
            return <- self.tokens.remove(key:id)!
        }
        pub fun deposit(token:@NFT) {
            let old <- self.tokens[token.id] <- token
            destroy old
        }
        pub fun getIds():[UInt64] {
            return self.tokens.keys
        }
        pub fun hasId(id:UInt64):Bool {
            return self.tokens[id] != nil
        }
        init() {
            self.tokens <- {}
        }   
        destroy() {
            destroy self.tokens
        }
    }
    pub resource Minter {
        pub fun mint(recipient:&{Receiver}) {
            recipient.deposit(token: <-create NFT(id: NonFungibleToken.count))
            NonFungibleToken.count = NonFungibleToken.count + UInt64(1)
        }

    }
    pub fun createEmptyCollection():@Collection {
        return <- create Collection()
    }

    init() {
        self.count = UInt64(0)
        //create and save collection
        self.account.save<@NonFungibleToken.Collection>(<-self.createEmptyCollection(), to: /storage/NFT1Collection)
        //link collection receiver to public
        self.account.link<&{Receiver}>(/public/NFT1Receiver, target: /storage/NFT1Collection)
        //crete and save minter
        self.account.save<@NonFungibleToken.Minter>(<-create Minter(), to: /storage/NFT1Minter)

    }

}