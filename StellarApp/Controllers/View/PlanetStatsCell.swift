import UIKit

class PlanetStatCell: UIView {

    private let statTitle: String
    private let statText: String

    private lazy var statsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = statTitle
        label.font = UIFont(name: "Avenir-Heavy", size: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private lazy var statsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = statText
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    init(title: String, description: String) {
        self.statTitle = title
        self.statText = description
        super.init(frame: .zero)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutView() {
        layoutTitleLabel()
        layoutDescriptionLabel()
    }

    private func layoutTitleLabel() {
        statsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statsTitleLabel)
        NSLayoutConstraint.activate([
            statsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            statsTitleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -4),
            statsTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            statsTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func layoutDescriptionLabel() {
        statsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statsDescriptionLabel)
        NSLayoutConstraint.activate([
            statsDescriptionLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 4),
            statsDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            statsDescriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            statsDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}
