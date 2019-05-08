import UIKit

class PlanetInfoView: UIView {

    private let planetInfo: PlanetInfo

    private lazy var planetNameLabel: UILabel = {
        let label = UILabel()
        label.text = planetInfo.name.capitalized
        label.textColor = .white
        return label
    }()

    private lazy var planetDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = planetInfo.description
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private lazy var planetStatsView = PlanetStatsView(planetInfo: planetInfo)

    init(planetInfo: PlanetInfo) {
        self.planetInfo = planetInfo
        super.init(frame: .zero)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutView() {
        setPlanetNameLabel()
        setPlanetDescriptionLabel()
        setPlanetStatsView()
    }

    private func setPlanetNameLabel() {
        addSubview(planetNameLabel)
        planetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetNameLabel.topAnchor.constraint(equalTo: topAnchor),
            planetNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
    }

    private func setPlanetDescriptionLabel() {
        addSubview(planetDescriptionLabel)
        planetDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetDescriptionLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor, constant: 16),
            planetDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            planetDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }

    private func setPlanetStatsView() {
        addSubview(planetStatsView)
        planetStatsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetStatsView.topAnchor.constraint(equalTo: planetDescriptionLabel.bottomAnchor, constant: 16),
            planetStatsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            planetStatsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            planetStatsView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}



