import Foundation


class gameProgress {
    
 
    func calculateStrikeAndBall(guess: String, answer: String) -> (strike: Int, ball: Int) {
        var strike = 0
        var ball = 0
        
        let guess = Array(guess)
        let answer = Array(answer)
        
        
        for i in 0..<guess.count {
            if guess[i] == answer[i] {
                strike += 1
            } else if answer.contains(guess[i]) {
                ball += 1
            } 
        }
        
        return (strike, ball)
    }
}

