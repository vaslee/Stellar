import UIKit

class ContainerViewController: UIViewController {

    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func configureSolarView() {
        let solarView = SolarViewController()
        
    
    }
    

}
