import UIKit
import WebKit

class NasaViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://www.nasa.gov/news/releases/latest/index.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack(_:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
   
    @objc func goBack(_ sender:UIBarButtonItem!) {
       webView.goBack()
    }
    
}
    
    
    

   


