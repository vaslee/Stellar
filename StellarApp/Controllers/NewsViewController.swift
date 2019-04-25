import UIKit

class NewsViewController: UIViewController {

    private var articles = [ArticleWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.newsView.NewsCollectionView.reloadData()
            }
        }
    }
    
    
    let newsView = NewsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newsView)
        let firstColor = UIColor.init(red: 255/255, green: 0/255, blue: 204/255, alpha: 1)
        let secondColor = UIColor.init(red: 51/255, green: 51/255, blue: 153/255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = self.newsView.NewsCollectionView.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.newsView.layer.insertSublayer(gradient, at: 0)
        newsView.NewsCollectionView.delegate = self
        newsView.NewsCollectionView.dataSource = self
        getArticles(keyword: "planets")
        // Do any additional setup after loading the view.
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

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        let thisArticle = articles[indexPath.row]
        cell.articleLabel.text = "Title: \(thisArticle.title)"
        cell.articleDescription.text = "Description: \(thisArticle.description)"
        cell.backgroundColor = .clear
        let url = URL(fileURLWithPath: thisArticle.urlToImage)
        ImageHelper.fetchImageFromNetwork(urlString: thisArticle.urlToImage) { (error, data) in
            if let error = error {
                print(error.errorMessage())
        }  else if let data = data {
                cell.articleImage.layer.borderWidth = 5
                cell.articleImage.layer.borderColor = UIColor.white.cgColor
                cell.articleImage.layer.cornerRadius = 5
                cell.articleImage.image = data
            }
        }
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: 200)
    }
}
