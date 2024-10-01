import UIKit


class ViewController: UIViewController {
    var display = UILabel()
    var verticalStackView = UIStackView()
    
    let buttons = [["7", "8", "9", "+"], ["4", "5", "6", "-"], ["1", "2", "3", "x"], ["AC", "0", "=", "÷"]]

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupTextLabel()
        setupVerticalStackView()
    }

    
    private func setupTextLabel() {
        display.text = "0"
        display.textColor = .white
        display.font = UIFont.boldSystemFont(ofSize: 60)
        display.textAlignment = .right
        view.addSubview(display)
        
        
        display.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            display.heightAnchor.constraint(equalToConstant: 100),
            display.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            display.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            display.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }

    
    private func setupVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        view.addSubview(verticalStackView)
        
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.widthAnchor.constraint(equalToConstant: 350),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.topAnchor.constraint(equalTo: display.bottomAnchor, constant: 60)
        ])

        
        for row in buttons {
            let horizontalStackView = createHorizontalStackView(row)
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                horizontalStackView.heightAnchor.constraint(equalToConstant: 80),
                horizontalStackView.widthAnchor.constraint(equalToConstant: 350),
                horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }

    
    private func createHorizontalStackView(_ buttons: [String]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        for buttonText in buttons {
            let button = createButton(buttonText)
            stackView.addArrangedSubview(button)
        }
        return stackView
    }

    
    private func createButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        if Int(text) != nil {
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.addTarget(self, action: #selector(didTapNumberButton(_:)), for: .touchUpInside)
        } else {
            button.backgroundColor = .orange
            button.addTarget(self, action: #selector(didTapOperateButton(_:)), for: .touchUpInside)
        }
        button.layer.cornerRadius = 40
        return button
    }

    
    @objc func didTapNumberButton(_ sender: UIButton) {
        if let currentText = display.text, let newText = sender.titleLabel?.text {
            
            if currentText == "0" {
                display.text = newText
            } else {
                
                display.text = removeLeadingZero(currentText + newText)
            }
        }
    }

    
    @objc func didTapOperateButton(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            switch buttonText {
            case "AC":
               
                display.text = "0"
            case "=":
                
                if let expression = display.text, let result = calculate(expression: expression) {
                    display.text = String(result)
                }
            default:
                
                if let currentText = display.text {
                    display.text = currentText + buttonText
                }
            }
        }
    }

    
    private func removeLeadingZero(_ input: String) -> String {
        var result = input
        if result.hasPrefix("0") && result.count > 1 {
            result.removeFirst()
        }
        return result
    }

    
    private func calculate(expression: String) -> Int? {
        
        
        let expressionWithOperators = expression.replacingOccurrences(of: "x", with: "*").replacingOccurrences(of: "÷", with: "/")
        
    
        let exp = NSExpression(format: expressionWithOperators)
        if let result = exp.expressionValue(with: nil, context: nil) as? Double {
          
            return Int(result)
        }
        return nil
    }
}
