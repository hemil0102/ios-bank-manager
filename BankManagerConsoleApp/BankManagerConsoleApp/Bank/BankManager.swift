final class BankManager {
    private let bank: Bank
    
    init(bank: Bank) {
        self.bank = bank
    }
    
    func openBank() {
        while true {
            print("1 : 은행개점\n2 : 종료\n입력 :", terminator: " ")
            guard let choice = getUserInput() else {
                print(BankManagerError.invalidInput.message)
                continue
            }
            switch choice {
            case "1":
                bank.openBank()
            case "2":
                return
            default:
                print(BankManagerError.invalidInput.message)
            }
        }
    }
    
    private func getUserInput() -> String? {
        do {
            guard let userInput = readLine() else {
                throw BankManagerError.invalidInput
            }
            return userInput
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
