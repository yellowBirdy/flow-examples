 pub contract HelloWorld {

    pub resource HelloAsset {
        access(all) fun hello(): String {
            return "Hello There, World!"
        }
    }

    init() {
        let newHello <- create HelloAsset()

        log(newHello.hello())

        self.account.save(<- newHello, to: /storage/Hello)
    }
 }