// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that has been set up to receive tokens.
//
// The withdraw amount and the account from getAccount
// would be the parameters to the transaction

import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

transaction() {

    // The Vault resource that holds the tokens that are being transferred
    let sentVault: @FungibleToken.Vault

    prepare(signer: AuthAccount) {

        // Get a reference to the signer's stored vault
        let vaultRef = signer.borrow<&{FungibleToken.Provider}>(from: /storage/exampleTokenVault)
			?? panic("Could not borrow reference to the owner's Vault!")

        // Withdraw tokens from the signer's stored vault
        self.sentVault <- vaultRef.withdraw(amount: 1.0)
    }

    execute {

        // Get the recipient's public account object
        let recipient = getAccount(0x179b6b1cb6755e31)

        // Get a reference to the recipient's Receiver
        let receiverRef = recipient.getCapability(/public/exampleTokenReceiver)!.borrow<&{FungibleToken.Receiver}>()
			?? panic("Could not borrow receiver reference to the recipient's Vault")

        // Deposit the withdrawn tokens in the recipient's receiver
        receiverRef.deposit(from: <-self.sentVault)
    }
}
 