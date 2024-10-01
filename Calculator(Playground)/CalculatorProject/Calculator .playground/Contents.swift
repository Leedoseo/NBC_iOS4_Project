// import UIKit

//var greeting = "Hello, playground"

class Calculator {
    // Todo : 내부 구현하기
    
    func calculate(_ operatory: Character, _ firstNumber: Int, _ secondNumber: Int) -> Double {
        // Character를 Int로 변환
        
        switch operatory {
        case "+" : // 덧셈 연산
            return AddOperation().operate(firstNumber, secondNumber) 
            //()을 사용하면 기본 생성자를 통해서 AddOperation의 객체를 만들어줌
        case "-": // 뺄셈 연산
            return SubstractOperation().operate(firstNumber, secondNumber)
        case"×": // 곱셈 연산
            return MultiplyOperation().operate(firstNumber, secondNumber)
        case"÷": // 나눗셈 연산
            return DivideOperation().operate(firstNumber, secondNumber)
        case"%": // 나머지 연산
            return RemainderOperation().operate(firstNumber, secondNumber)
        
        default :
            return 0
        }
    }
}
// 위 사칙연산 기호를 입력시 아래위 class를 실행한다?
 
class AddOperation {
     func operate(_ firstNumber: Int, _ secondNumber: Int) -> Double {
        return Double(firstNumber + secondNumber)
    } // firstNumber, secondNumber 둘다 Int 정수로 받고 정수로 출력
} // AddOperation은 firstNumber + secondNumber로 덧셈
 // -> Int : 정수로 반환하겠다.

class SubstractOperation {
     func operate(_ firstNumber: Int, _ secondNumber: Int) -> Double {
        return Double(firstNumber - secondNumber)
    }
} // static이 왜 나왔지?
 // 타입 메서드로 선언하고 싶을 때 메서드를 선언할 때 static을 사용,
// static대신 위에 switch case 밑에있는 Operation옆에 ()을 붙임으로써 일회성 객체를 생성함, static을 지우고도 사용이 가능.

class MultiplyOperation {
     func operate(_ firstNumber: Int, _ secondNumber: Int) -> Double {
        return Double(firstNumber * secondNumber)
    }
}

class DivideOperation {
     func operate(_ firstNumber: Int, _ secondNumber: Int) -> Double {
         return Double(firstNumber) / Double(secondNumber)
    }
}

class RemainderOperation {
     func operate(_ firstNumber: Int, _ secondNumber: Int) -> Double {
        return Double(firstNumber % secondNumber)
    }
}

let calculator = Calculator()// calculator 초기화
// = Calcalator() << 생성자 라고함, 생성자의 특징은 클래스의 이름과 같다. func뒤에 오는 메서드는 소문자로 시작, class 뒤에오는 메서드는 첫글자는 대문자로 시작.
// Todo : calculator 변수를 활용하여 사칙연산을 진행

let addResult = calculator.calculate("+", 10, 3)// 덧셈 연산
let substractResult = calculator.calculate("-", 10, 3) // 뺄셈 연산
let multiplyResult = calculator.calculate("×", 10, 3)// 곱셈 연산
let divideResult = calculator.calculate("÷", 10, 3)// 나눗셈 연산
let remainderResult = calculator.calculate("%", 10, 3)// 나머지 연산
// class안에있는 함수는 메서드라 한다. () 안에있는건 파라미터 혹은 매개변수라고 함.



print("addResult : \(addResult)")
print("substractResult : \(substractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
print("remainderResult : \(remainderResult)")

