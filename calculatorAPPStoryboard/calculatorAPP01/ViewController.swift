import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }
    
    // 숫자 버튼 액션 메서드
    @IBAction func numberTapped(_ sender: UIButton) {
        if let str = display.text, let text = // let text가 operatorSymbol이 되야함
            sender.titleLabel?.text {
            if let num = Int(str), num == 0 {
                display.text = text
            } else {
                display.text = str + text
            }
        }
    }
 
    // 연산자 버튼 액션 메서드
    
    @IBAction func operatorTapped(_ sender: UIButton) {
        // 연산자 버튼을 눌렀을 때 실행되는 액션 메서드
        
        if let operatorSymbol = sender.titleLabel?.text, let displayText = display.text { // 옵셔널을 해제해주기 위해 let으로 변수 선언
            display.text = displayText + operatorSymbol
            
        }
        
    }
    // 등호 버튼 액션 메서드
    
    @IBAction func equalTapped(_ sender: UIButton) {
        
        // 등호(=) 버튼을 눌렀을 때 실행되는 액션 메서드
        if let displayText = display.text {
            
            let displayText2 = displayText.replacingOccurrences(of: "×", with: "*").replacingOccurrences(of: "÷", with: "/") // 곱하기 나누기를 with로 나온거로 바꿔줌
            
            let expression = NSExpression(format: displayText2)
            
            if let result = expression.expressionValue(with: nil, context: nil) as? Int {
                display.text = String(result)
            } else {
                display.text = "Error"
            }
        }
        
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        display.text = "0"
       
    }

}

