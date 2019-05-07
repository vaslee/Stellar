import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    let numberOfCells: CGFloat = 1
    let cellSpacing: CGFloat = 10
    let numberOfSpaces: CGFloat = 2
    let keyword = "solar%20system"
    var pageNumber = 1
    

    private var articles = [ArticleWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.newsView.newsCollectionView.reloadData()
            }
        }
    }
    
    let newsView = NewsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newsView)
        self.title = "News"
        setupNewsView()
        newsView.newsCollectionView.delegate = self
        newsView.newsCollectionView.dataSource = self
        getArticles(keyword: keyword, pageNumber: pageNumber)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = false

        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = true
        
    }
    
    override func viewDidLayoutSubviews() {
        setGradient()
    }
    
    private func setupNewsView() {
        newsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
    }
    private func setGradient() {
        let firstColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let secondColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = self.newsView.newsCollectionView.bounds
        gradient.colors = [firstColor.cgColor,secondColor.cgColor]
        self.newsView.layer.insertSublayer(gradient, at: 0)
        newsView.newsCollectionView.delegate = self
    }
    private func getArticles(keyword: String, pageNumber: Int) {
        ApiClient.getNews(query: keyword, page: pageNumber) { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                if self.articles.isEmpty {
                self.articles = data
                } else {
                    self.articles = (self.articles + data)
                }
            }
        }
    }
}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        let thisArticle = articles[indexPath.row]
        cell.articleLabel.text = thisArticle.source.name
        cell.articleDescription.text = thisArticle.title
        
        if (indexPath.row == articles.count - 1) {
            collectionView.performBatchUpdates({
                pageNumber += 1
               getArticles(keyword: keyword, pageNumber: pageNumber)
            }, completion: nil)
        }
        
        ImageHelper.fetchImageFromNetwork(urlString: thisArticle.urlToImage ?? "") { (error, data) in
            if let error = error {
                print(error.errorMessage())
        }  else if let data = data {
                cell.articleImage.image = data
            
            }
        }
        return cell
    }
   
}
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard  let url = URL(string: articles[indexPath.row].url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let width = (screenWidth - (self.cellSpacing * self.numberOfSpaces)) / self.numberOfCells
        let height = (screenHeight / screenWidth) * (width / 2.2)

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
