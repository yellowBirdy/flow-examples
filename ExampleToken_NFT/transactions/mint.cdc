import NonFungibleToken from 0x01cf0e2f2f715450
import ExampleNFT from 0x179b6b1cb6755e31

transaction {

    let minter: &ExampleNFT.NFTMinter
    prepare (signer: AuthAccount) {
        // check if admin account
        self.minter = signer.borrow<&ExampleNFT.NFTMinter>(from:/storage/NFTMinter) ?? 
            panic("Can't borrow minter, trying to mint from nonadmin account.")
    }

    execute {
        let target = getAccount(0x179b6b1cb6755e31).getCapability(/public/NFTCollection)!
            .borrow<&{NonFungibleToken.CollectionPublic}>()!

        self.minter.mintNFT(recipient: target)
    }

}