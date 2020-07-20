import FungibleToken1 from 0x01cf0e2f2f715450

transaction {

    let tempVault: @FungibleToken1.Vault
    prepare(acnt:AuthAccount) {
        let fromRef = acnt.borrow<&FungibleToken1.Vault>(from: /storage/FTVault)!

        self.tempVault <- fromRef.withdraw(amount: UFix64(133))

    }

    execute {
        let toRef = getAccount(0x179b6b1cb6755e31).getCapability(/public/FTReceiver)!
            .borrow<&{FungibleToken1.Receiver}>()!

        toRef.deposit(from: <-self.tempVault)
    }
}
 