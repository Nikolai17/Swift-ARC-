
class User {
    let name: String
    var subscriptions: [CarrierSubscription] = []
    private(set) var phones: [Phone] = []

    func add(phone: Phone) {
        phones.append(phone)
        phone.owner = self
    }

    init(name: String) {
        self.name = name
        print("User \(name) was initialized")
    }

    deinit {
        print("Deallocating user named: \(name)")
    }
}

class Phone {
    let model: String
    weak var owner: User?
    var carrierSubscription: CarrierSubscription?

    func provision(carrierSubscription: CarrierSubscription) {
        self.carrierSubscription = carrierSubscription
    }

    func decommission() {
        carrierSubscription = nil
    }
    init(model: String) {
        self.model = model
        print("Phone \(model) was initialized")
    }

    deinit {
        print("Deallocating phone named: \(model)")
    }
}



class CarrierSubscription {
    let name: String
    let countryCode: String
    let number: String
    unowned let user: User

    init(name: String, countryCode: String, number: String, user: User) {
        self.name = name
        self.countryCode = countryCode
        self.number = number
        self.user = user
        user.subscriptions.append(self)
        print("CarrierSubscription \(name) is initialized")
    }

    deinit {
        print("Deallocating CarrierSubscription named: \(name)")
    }
}

func runScenario() {
    let user = User(name: "John")
    let iPhone = Phone(model: "iPhone Xs")
    user.add(phone: iPhone)

    let subscription = CarrierSubscription(
      name: "TelBel",
      countryCode: "0032",
      number: "31415926",
      user: user)
    iPhone.provision(carrierSubscription: subscription)
}

runScenario()
