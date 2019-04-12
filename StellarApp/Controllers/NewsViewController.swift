import UIKit

class NewsViewController: UIViewController {

    let newsView = NewsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newsView)
        newsView.NewsCollectionView.delegate = self
        newsView.NewsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .green
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: 200)
    }
}
