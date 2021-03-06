// This transaction is a template for a transaction that
// could be used by the admin account to burn tokens
// from their stored Vault
//
// The burning amount would be a parameter to the transaction

import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

transaction() {

    // Vault resource that holds the tokens that are being burned
    let vault: @FungibleToken.Vault

    let admin: &ExampleToken.Administrator

    prepare(signer: AuthAccount) {

        // Withdraw 77 tokens from the admin vault in storage
        self.vault <- signer.borrow<&ExampleToken.Vault>(from: /storage/exampleTokenVault)!
            .withdraw(amount: 77.0)

        // Create a reference to the admin admin resource in storage
        self.admin = signer.borrow<&ExampleToken.Administrator>(from: /storage/exampleTokenAdmin)
            ?? panic("Could not borrow a reference to the admin resource")
    }

    execute {
        let burner <- self.admin.createNewBurner()
        
        burner.burnTokens(from: <-self.vault)

        destroy burner
    }
}
 