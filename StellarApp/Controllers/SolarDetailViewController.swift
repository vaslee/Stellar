import UIKit

class SolarDetailViewController: UIViewController {

    private var planetInfo = [PlanetInfo]()

    private lazy var solarDetailView = SolarDetailView()
    private lazy var tapView: TapRecognizingView = {
        let tapView = TapRecognizingView()
        tapView.onTap = { [weak self] in self?.dismiss(animated: true, completion: nil)}
        tapView.translatesAutoresizingMaskIntoConstraints = false
        return tapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(solarDetailView)
        layoutTapView()
        getPlanetData()
        getUIData()
    }

    


    private func layoutTapView() {
        view.addSubview(tapView)
        NSLayoutConstraint.activate([
            tapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }

//    private func getUIData() {
//        solarDetailView.textView.text = planetInfo.first?.description
//        solarDetailView.imageView.image = UIImage(named: planetInfo.first?.planetDetailImage ?? "plimage")
//    }

    private func getPlanetData() {
        if let path = Bundle.main.path(forResource: "planet", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: url) {
                do {
                    _ = try JSONDecoder().decode(PlanetData.self, from: data)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }

}
