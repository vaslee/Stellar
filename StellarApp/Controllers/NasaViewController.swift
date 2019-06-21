import UIKit
import WebKit


class NasaViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!

    var activityIndicator: UIActivityIndicatorView!
    
    private var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
     
        let myURL = URL(string:"https://www.nasa.gov/news/releases/latest/index.html")
        let myRequest = URLRequest(url: myURL!)
        
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        showActivityIndicator(show: true)
        webView.load(myRequest)


        backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack(_:)))
        navigationItem.leftBarButtonItem = backButton
       // self.navigationItem.setHidesBackButton(false, animated: false)

    }

    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
        if activityIndicator.isDescendant(of: view) {
            activityIndicator.removeFromSuperview()
            view = webView
        }
       // buttonAction()
        
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
        
       // buttonAction()
        
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
   
//    func buttonAction() {
//        if webView.canGoBack {
//            self.navigationItem.setHidesBackButton(false, animated: false)
//
//            //navigationItem.leftBarButtonItem?.isEnabled = true
//        } else {
//            self.navigationItem.setHidesBackButton(true, animated: false)
//
//            //navigationItem.leftBarButtonItem?.isEnabled = false
//        }
//    }
    
    @objc func goBack(_ sender:UIBarButtonItem!) {
       webView.goBack()
    }

}
    
    
    

   


