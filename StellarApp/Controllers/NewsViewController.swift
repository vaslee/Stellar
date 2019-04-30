import UIKit
import SafariServices

class NewsViewController: UIViewController {

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
        newsView.newsCollectionView.delegate = self
        newsView.newsCollectionView.dataSource = self
        getArticles(keyword: "astronomy")
    }
    
    
    override func viewDidLayoutSubviews() {
        setGradient()
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
        cell.backgroundColor = .clear
        let url = URL(fileURLWithPath: thisArticle.urlToImage)
        ImageHelper.fetchImageFromNetwork(urlString: thisArticle.urlToImage) { (error, data) in
            if let error = error {
                print(error.errorMessage())
        }  else if let data = data {
                cell.articleImage.layer.cornerRadius = 5
                cell.articleImage.image = data
            
            }
        }
        cell.backgroundColor = .lightGray
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
        return CGSize(width: view.bounds.width - 32, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}
