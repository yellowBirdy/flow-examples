import FungibleToken from 0xee82856bf20e2aa6
import ExampleToken from 0x01cf0e2f2f715450

transaction {
    let minter: @ExampleToken.Minter
    
    prepare (signer: AuthAccount){
        let adminRef = signer.borrow<&ExampleToken.Administrator>(from: /storage/exampleTokenAdmin) ??
            panic("Non admin accout trying to mint ExampleToken")
        self.minter <- adminRef.createNewMinter(allowedAmount:1000.0)
    }

    execute {
        let recipientCap = getAccount(0x179b6b1cb6755e31).getCapability(/public/exampleTokenReceiver) ??
        //   panic("Recipient does not have an ExampleToken Receiver capablility")
        //let recipientCap = getAccount(0x01cf0e2f2f715450).getCapability(/public/exampleTokenReceiver) ??
           panic("Recipient does not have an ExampleToken Receiver capablility")
        let recipientRef = recipientCap.borrow<&{FungibleToken.Receiver}>()!
        let tempVault <- self.minter.mintTokens(amount: 907.0)
        destroy self.minter
        
        recipientRef.deposit(from:<-tempVault)

    }


}
 