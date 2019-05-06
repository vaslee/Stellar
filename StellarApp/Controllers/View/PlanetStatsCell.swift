import UIKit

class PlanetStatCell: UIView {

    private let statTitle: String
    private let statText: String
    private lazy var titleContainer = UIView()
    private lazy var descriptionContainer = UIView()

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
        layoutTitleContainer()
        layoutDescritptionContainer()
        layoutTitleLabel()
        layoutDescriptionLabel()
    }

    private func layoutTitleContainer() {
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleContainer)
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: topAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
    }

    private func layoutDescritptionContainer() {
        descriptionContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionContainer)
        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: topAnchor),
            descriptionContainer.leadingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }

    private func layoutTitleLabel() {
        statsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(statsTitleLabel)
        NSLayoutConstraint.activate([
            statsTitleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            statsTitleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -4),
            statsTitleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            statsTitleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor)
            ])
    }

    private func layoutDescriptionLabel() {
        statsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer.addSubview(statsDescriptionLabel)
        NSLayoutConstraint.activate([
            statsDescriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 4),
            statsDescriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            statsDescriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            statsDescriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor)
            ])
    }

}
