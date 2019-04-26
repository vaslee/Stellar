import UIKit

class TapRecognizingView: UIView {

    var onTap: (() -> Void)?

    var ignoreTaps = false

    init() {
        super.init(frame: CGRect.zero)
        addGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        addGestureRecognizer(tapGesture)
    }

    @objc private func didTap(sender: UITapGestureRecognizer) {
        guard sender.view == self && !ignoreTaps else { return }
        onTap?()
    }
}

class DismissalView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
}
