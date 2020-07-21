// This script reads the balance field of an account's FlowToken Balance

import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

pub fun main() {
    
    let acct = getAccount(0x01cf0e2f2f715450)
    let vaultRef = acct.getCapability(/public/exampleTokenBalance)!.borrow<&ExampleToken.Vault{FungibleToken.Balance}>()
        ?? panic("Could not borrow Balance reference to the Vault")

    log(vaultRef.balance)

    let acct2 = getAccount(0x179b6b1cb6755e31)
    let vaultRef2 = acct2.getCapability(/public/exampleTokenBalance)!.borrow<&ExampleToken.Vault{FungibleToken.Balance}>()
        ?? panic("Could not borrow Balance reference to the Vault")

    log(vaultRef2.balance)

    let acct3 = getAccount(0xf3fcd2c1a78f5eee)
    let vaultRef3 = acct3.getCapability(/public/exampleTokenBalance)!.borrow<&ExampleToken.Vault{FungibleToken.Balance}>()
        ?? panic("Could not borrow Balance reference to the Vault")

    log(vaultRef3.balance)
}
