// This script reads the total supply from the contract

//import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

pub fun main() {
    /* 
    let acct = getAccount(0x01cf0e2f2f715450)
    let vaultRef = acct.getCapability(/public/exampleTokenBalance)!.borrow<&ExampleToken.Vault{FungibleToken.Balance}>()
        ?? panic("Could not borrow Balance reference to the Vault")

    log(vaultRef.balance)
    */
    log(ExampleToken.totalSupply)
}
