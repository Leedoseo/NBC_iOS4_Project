import Foundation


class RandomNumberGenerator {
    
    
    func generateRandomNumber() -> String {
        var randomnumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        randomnumbers.shuffle()
        
        var result = ""
        for i in 0..<3 {
            result.append(String(describing: randomnumbers[i]))
        }
        return result
    }
}

