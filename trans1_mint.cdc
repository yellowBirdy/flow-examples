import NonFungibleToken from 0x01cf0e2f2f715450

transaction {
    prepare(acnt:AuthAccount) {
        let minterRef = acnt.borrow<&NonFungibleToken.Minter>(from: /storage/NFT1Minter)!
        let receiverRef = acnt.getCapability<&{NonFungibleToken.Receiver}>(/public/NFT1Receiver)!.borrow()!
        minterRef.mint(recipient:receiverRef)
    }
}