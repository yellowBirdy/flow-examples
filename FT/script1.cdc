import FungibleToken1 from 0x01cf0e2f2f715450

pub fun main() {
    let acc1 = getAccount(0x01cf0e2f2f715450)

    let ref = acc1.getCapability(/public/mainReceiver)!.borrow<&FungibleToken1.Vault{FungibleToken1.Balance}>()!    
    log("Tu ma byc stan konta")
    log(ref.balance)
}