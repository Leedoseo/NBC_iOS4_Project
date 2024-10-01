import Foundation


func playGame() -> (result: String, attempts: Int) {
    let randomNumberGenerator = RandomNumberGenerator()
    let gameLogic = gameProgress()
    let inputManager = userInput()
    
    let answer = randomNumberGenerator.generateRandomNumber()
    var attempts = 0
    let maxAttempts = 9
    
    print("게임을 시작합니다. 세 자리 숫자를 맞춰보세요.")
    
    while attempts < maxAttempts {
            
            if let input = inputManager.getUserInput(), input.count == 3, let _ = Int(input) {
                attempts += 1
                let (strike, ball) = gameLogic.calculateStrikeAndBall(guess: input, answer: answer)
                
               
                if strike == 0 && ball == 0 {
                    print("\(attempts)회차: Out")
                } else {
                    print("\(attempts)회차: \(strike) 스트라이크, \(ball) 볼")
                }
                
                
                if strike == 3 {
                    print("성공. \(attempts)번 만에 맞추셨습니다.")
                    return ("정답: \(answer)", attempts)
                }
            } else {
                print("잘못된 입력입니다. 세 자리 숫자를 입력하세요.")
            }
        }
        
        
        print("실패. 최대 시도 횟수를 초과하였습니다. 정답은 \(answer)입니다.")
        return ("정답: \(answer)", maxAttempts)
    }

    
    var gameRecords: [(result: String, attempts: Int)] = []

 
    func mainMenu() {
        while true {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            if let choice = readLine(), let option = Int(choice) {
                switch option {
                case 1:
                    let (result, attempts) = playGame()
                    gameRecords.append((result, attempts))
                case 2:
                    print("게임 기록:")
                    for (index, record) in gameRecords.enumerated() {
                        print("\(index + 1)회차: \(record.result), 시도 횟수: \(record.attempts)회")
                    }
                case 3:
                    print("게임을 종료합니다.")
                    return
                default:
                    print("잘못된 선택입니다. 다시 입력해주세요.")
                }
            } else {
                print("잘못된 입력입니다. 숫자를 입력해주세요.")
            }
        }
    }

    mainMenu()
