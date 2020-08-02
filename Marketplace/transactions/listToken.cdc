import NFTMarketplace from 0xf3fcd2c1a78f5eee

//import NonFungibleToken from 0x045a1763c93006ca
import ExampleNFT from 0x179b6b1cb6755e31

transaction {
    prepare (signer: AuthAccount) {
        let stand = signer.borrow<&NFTMarketplace.SaleCollection>(from: /storage/SaleCollection) ??
            panic("Can't borrow owners SaleCollection")
        
        let collection = signer.borrow<&ExampleNFT.Collection>(from: /storage/NFTCollection) ??
            panic("Can't borrow owners Collection")
        let nft <- collection.withdraw(withdrawID: UInt64(0)) as! @ExampleNFT.NFT 

        stand.listForSale(token: <- nft , price: UFix64(777))
    }
}