import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    let numberOfCells: CGFloat = 1
    let cellSpacing: CGFloat = 10
    let numberOfSpaces: CGFloat = 2

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
        setupNewsView()
        newsView.newsCollectionView.delegate = self
        newsView.newsCollectionView.dataSource = self
        getArticles(keyword: "astronomy")
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
        let firstColor = UIColor.init(red: 236/255, green: 233/255, blue: 230/255, alpha: 1)
        let secondColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = self.newsView.newsCollectionView.bounds
        gradient.colors = [firstColor.cgColor,secondColor.cgColor]
        self.newsView.layer.insertSublayer(gradient, at: 0)
        newsView.newsCollectionView.delegate = self
    }
    private func getArticles(keyword: String) {
        ApiClient.getNews(query: keyword) { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.articles = data
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
        ImageHelper.fetchImageFromNetwork(urlString: thisArticle.urlToImage) { (error, data) in
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
