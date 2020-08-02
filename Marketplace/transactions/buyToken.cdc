import ExampleToken from 0x01cf0e2f2f715450
import FungibleToken from 0xee82856bf20e2aa6

import NonFungibleToken from 0x045a1763c93006ca
import ExampleNFT from 0x179b6b1cb6755e31

import NFTMarketplace from 0xf3fcd2c1a78f5eee



transaction {
    let fee: @ExampleToken.Vault
    let collection: &ExampleNFT.Collection{NonFungibleToken.CollectionPublic}
    prepare (signer: AuthAccount) {
        let vaultRef = signer.borrow<&{FungibleToken.Provider}>(from: /storage/exampleTokenVault) ??
            panic("Cant't borrow owners vault.")
        self.fee <- vaultRef.withdraw(amount: 777.0) as! @ExampleToken.Vault

        self.collection = signer.borrow<&ExampleNFT.Collection{NonFungibleToken.CollectionPublic}>(from: /storage/NFTCollection) ??
            panic("Can'b borrow buyers collection")
    }

    execute {
        let stand = getAccount(0x01cf0e2f2f715450).getCapability(/public/SaleCollection)!
            .borrow<&{NFTMarketplace.SalePublic}>() ??
                panic("can't borrow the sellers stand (SalesCollection)")
        
        stand.purchase(id: UInt64(0), fee: <-self.fee, recipient: self.collection)
    }
}
