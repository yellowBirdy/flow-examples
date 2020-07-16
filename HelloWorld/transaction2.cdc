import HelloWorld from 0x179b6b1cb6755e31

transaction {
    prepare (acnt: AuthAccount) {
        let hello <- acnt.load<@HelloWorld.HelloAsset>(from: /storage/Hello)
        log(hello?.hello())

        acnt.save(<-hello!, to: /storage/Hello)
    }
}