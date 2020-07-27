import NonFungibleToken from 0x01cf0e2f2f715450
import ExampleNFT from 0x179b6b1cb6755e31

transaction {
    prepare (signer:AuthAccount) {
        signer.save<@NonFungibleToken.Collection>(<-ExampleNFT.createEmptyCollection(), to: /storage/NFTCollection)
        signer.link<&{NonFungibleToken.CollectionPublic}>(/public/NFTCollection, target: /storage/NFTCollection)
    }

}
