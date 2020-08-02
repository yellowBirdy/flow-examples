import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

import NonFungibleToken from 0x045a1763c93006ca
import ExampleNFT from 0x179b6b1cb6755e31

//0xf3fcd2c1a78f5eee
pub contract NFTMarketplace {

    //TODO: Events


    //PublicSale  res interface
          //purchase, showIds, priceOf
    pub resource interface SalePublic {
        pub fun getIds(): [UInt64]
        pub fun priceOf(id:UInt64): UFix64?
        pub fun purchase(id:UInt64, fee:@ExampleToken.Vault, recipient:&{NonFungibleToken.CollectionPublic})
    }
    pub resource SaleCollection: SalePublic {
        pub var tokens: @{UInt64: ExampleNFT.NFT}
        //pub var tokens: @{UInt64: NonFungibleToken.NFT}
    

        pub var prices: {UInt64: UFix64}
        access(account) let vaultRef: &{FungibleToken.Receiver, FungibleToken.Balance}

        pub fun listForSale(token: @ExampleNFT.NFT, price: UFix64) {
            let id = token.id
            let oldToken <- self.tokens[id] <- token
            destroy oldToken
            self.prices[id] = price
        }
        access(account) fun reprice(id:UInt64, price: UFix64) {
            self.prices[id] = price
        }

        pub fun getIds(): [UInt64] {
            return self.tokens.keys
        }
        pub fun priceOf(id:UInt64): UFix64? {
            return self.prices[id]
        }
        pub fun purchase(id:UInt64, fee: @ExampleToken.Vault, recipient:&{NonFungibleToken.CollectionPublic}) {
            pre {
                // fee is equal OR not smaller than the price
                fee.balance >= self.prices[id]!
            }

            let token <- self.tokens.remove(key:id)!
            recipient.deposit(token: <- token )
            self.vaultRef.deposit(from: <-fee)
        }

        init(vaultRef: &{FungibleToken.Receiver, FungibleToken.Balance}) {
            self.tokens <- {}
            self.prices = {}
            self.vaultRef = vaultRef
        }
        destroy() {
            destroy self.tokens
        }
    }

    pub fun createSaleCollection(vaultRef: &{FungibleToken.Receiver, FungibleToken.Balance}): @SaleCollection {
        return <- create SaleCollection(vaultRef:vaultRef)
    }
    //SaleCollection resource 
        // it is simmlare to the Collection res of NFT
        // + prices {}
        // list, delist, revaluate, purchase, showIds, priceOf

}
 