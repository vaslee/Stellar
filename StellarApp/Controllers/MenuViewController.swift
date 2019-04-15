import UIKit

class MenuViewController: UIViewController {

    let menuView = MenuView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        view.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        view.addSubview(menuView)
        
        menuView.exitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        dismiss(animated: true, completion: nil)
    }

}
