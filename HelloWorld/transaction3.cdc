
import HelloWorld from 0x179b6b1cb6755e31
transaction {

    prepare (acct: AuthAccount) {
        let capability = acct.link<&HelloWorld.HelloAsset>(/public/Hello2, target:/storage/Hello) 

        let helloRef = capability!.borrow()

        log(helloRef?.hello())

    }
}
