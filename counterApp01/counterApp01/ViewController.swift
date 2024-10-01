import UIKit

class ViewController: UIViewController {
    
    private var number: Int = 0
    
    

    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        self.number -= 1
        label.text = "\(self.number)"
    }
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        self.number += 1
        label.text = "\(self.number)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

