//ft1.cdc
// fungible token example, recreation from playground

access(all) contract FungibleToken1 {
    pub resource interface Provider {
        pub fun withdraw(amount: UFix64): @Vault {
            post {
                result.balance == UFix64(amount):
                    "Withdrawal amount must be the same as the balance of the withdrawn Vault"    
            }
        }
    }
    pub resource interface Receiver {
        pub fun deposit(from:@Vault) {
            pre {
                from.balance > UFix64(0):
                    "Deposit balance must be positive"
            }
        }
    }
    pub resource interface Balance {
        pub var balance: UFix64
    }

    pub var totalSupply: UFix64

    pub resource Vault: Provider, Receiver, Balance {
        pub var balance: UFix64 

        pub fun withdraw(amount: UFix64): @Vault {
            self.balance = self.balance - amount
            return <-create Vault(balance: amount)
        }
        pub fun deposit(from:@Vault) {
            self.balance = self.balance + from.balance
            destroy from
        }
        
        init(balance: UFix64) {
            self.balance = balance
        }
    }

    pub fun createEmptyVault():@Vault {
        return <-create Vault(balance: UFix64(0))
    }

    pub resource Minter {
        pub fun mint(amount : UFix64, recipient: &AnyResource{Receiver}) {
            FungibleToken1.totalSupply = FungibleToken1.totalSupply + amount
            recipient.deposit(from:<- create Vault(balance: amount))
        }
    }

    init() {
        self.totalSupply = UFix64(500)

        //create and save Vault
        self.account.save(<-create Vault(balance: self.totalSupply), to:/storage/mainVault)
        //create and save Minter
        self.account.save(<-create Minter(), to: /storage/mainMinter)
        //opt: expose Receiver of Vault 
        self.account.link<&FungibleToken1.Vault{Receiver,Balance}>(/public/mainReceiver, target: /storage/mainVault)

    }
    
}
 