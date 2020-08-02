import NFTMarketplace from 0xf3fcd2c1a78f5eee
import FungibleToken from 0xee82856bf20e2aa6


transaction {
    prepare(signer: AuthAccount) {

        let vaultRef = signer.borrow<&{FungibleToken.Receiver, FungibleToken.Balance}>(from: /storage/exampleTokenVault) ??
            panic("Can't borrow owners Vault")
        let stand <- NFTMarketplace.createSaleCollection(vaultRef: vaultRef)
        signer.save(<-stand, to: /storage/SaleCollection)
        signer.link<&{NFTMarketplace.SalePublic}>(/public/SaleCollection, target:/storage/SaleCollection)
    }
}
