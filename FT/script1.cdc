import FungibleToken1 from 0x01cf0e2f2f715450

pub fun main() {
    let acc1 = getAccount(0x01cf0e2f2f715450)

    let ref1 = acc1.getCapability(/public/FTReceiver)!.borrow<&FungibleToken1.Vault{FungibleToken1.Balance}>()!    
    log("Stan konta 0x01")
    log(ref1.balance)

    let acc2 = getAccount(0x179b6b1cb6755e31)

    let cap2 = acc2.getCapability(/public/FTReceiver)!
    let ref2 = cap2.borrow<&{FungibleToken1.Balance}>()!
    log("Stan konta 0x17")
    log(ref2.balance)

}
