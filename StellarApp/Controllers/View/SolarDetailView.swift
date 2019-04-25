import UIKit

class SolarDetailView: UIView {

    public lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "stars")
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleToFill
        return backgroundImage
    }()

    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "phimage")
        return image
    }()

    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.delegate = self
        scrollView.backgroundColor = .gray
        return scrollView
    }()

    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.isEditable = false
//        textView.isSelectable  = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setbackgroundImage()
        setImageView()
        setScrollView()
        setTextView()
    }

    private func setbackgroundImage() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 100),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -365),
            backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80)
            ])
    }

    private func setImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 100),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -365),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80)
            ])
    }

    private func setTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8)
            ])
    }

    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(textView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 365),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -100),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80)
            ])
    }

}
