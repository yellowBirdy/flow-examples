import FungibleToken1 from 0x01cf0e2f2f715450

transaction {
    prepare(acnt: AuthAccount) {
        var vault <- FungibleToken1.createEmptyVault()
        acnt.save<@FungibleToken1.Vault>(<-vault, to:/storage/FTVault)
        acnt.link<&FungibleToken1.Vault{FungibleToken1.Receiver, FungibleToken1.Balance}>(/public/FTReceiver, target:/storage/FTVault)

    }
    post {
        getAccount(0x179b6b1cb6755e31).getCapability(/public/FTReceiver)!
            .check<&FungibleToken1.Vault{FungibleToken1.Receiver, FungibleToken1.Balance}>():
            "Vault or ref not creaated correctly"
    }

}