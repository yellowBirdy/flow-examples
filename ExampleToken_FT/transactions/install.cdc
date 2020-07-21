import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

transaction {

    prepare(signer: AuthAccount) {

        if signer.borrow<&ExampleToken.Vault>(from: /storage/exampleTokenVault) == nil {
            // Create a new exampleToken Vault and put it in storage
            signer.save(<-ExampleToken.createEmptyVault(), to: /storage/exampleTokenVault)

            // Create a public capability to the Vault that only exposes
            // the deposit function through the Receiver interface
            signer.link<&ExampleToken.Vault{FungibleToken.Receiver}>(
                /public/exampleTokenReceiver,
                target: /storage/exampleTokenVault
            )

            // Create a public capability to the Vault that only exposes
            // the balance field through the Balance interface
            signer.link<&ExampleToken.Vault{FungibleToken.Balance}>(
                /public/exampleTokenBalance,
                target: /storage/exampleTokenVault
            )
        }
    }
}
