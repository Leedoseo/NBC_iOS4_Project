import Foundation


class userInput {
    
    
    func getUserInput() -> String? {
        print("세 자리 숫자를 입력하세요: ", terminator: "")
        return readLine()
    }
}
