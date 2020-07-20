import FungibleToken1 from 0x01cf0e2f2f715450

transaction {
    let minterRef:&FungibleToken1.Minter
    let recipientRef: &{FungibleToken1.Receiver}

    prepare(acnt: AuthAccount) {
        self.minterRef = acnt.borrow<&FungibleToken1.Minter>(from:/storage/FTMinter) ??
            panic("There is no minter")

        self.recipientRef = getAccount(0x179b6b1cb6755e31).getCapability(/public/FTReceiver)!
            .borrow<&{FungibleToken1.Receiver}>() ??
            panic("Can't borrow the receiver ref")
    }
    execute {
        self.minterRef.mint(amount:UFix64(450), recipient: self.recipientRef)
    }
    
    
}
