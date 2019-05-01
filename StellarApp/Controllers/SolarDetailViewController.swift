import UIKit

class SolarDetailViewController: UIViewController {

    var planetType: PlanetType!

    private lazy var solarDetailView = SolarDetailView(planetType: planetType)
    private lazy var tapView: TapRecognizingView = {
        let tapView = TapRecognizingView()
        tapView.onTap = { [weak self] in self?.dismiss(animated: true, completion: nil)}
        tapView.translatesAutoresizingMaskIntoConstraints = false
        return tapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTapView()
        setUpSolarDetailView()
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

    private func setUpSolarDetailView() {
        solarDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(solarDetailView)
        NSLayoutConstraint.activate([
            solarDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            solarDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            solarDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            solarDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            ])
    }
    

}
