import NonFungibleToken from 0x01cf0e2f2f715450

pub fun main() {
    let acc1 = getAccount(0x01cf0e2f2f715450)

    let cap1 = acc1.getCapability(/public/NFT1Receiver)!
    let ref1 = cap1.borrow<&{NonFungibleToken.Receiver}>()!    
    log("Id'sy dla konta 0x01")
    log(ref1.getIds())

    let acc2 = getAccount(0x179b6b1cb6755e31)

    let ref2 = acc2.getCapability(/public/NFT1Receiver)!.borrow<&{NonFungibleToken.Receiver}>()
    if ref2 != nil {
        //let ref2 = cap2!.borrow<&{NonFungibleToken.Receiver}>()!
        //log("Id'sy dla konta 0x01")
        //log(ref1.getIds())
        log(ref2)
    } else {
        log("no cap2")

    }
}
 