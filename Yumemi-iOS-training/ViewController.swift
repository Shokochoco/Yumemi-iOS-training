import UIKit

class ViewController: UIViewController {

    let imageView = UIImageView()
    let blueLabel = UILabel()
    let redLabel = UILabel()
    let closeButton = UIButton()
    let reloadButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false // AutoLayout 以前に使われていた「Autosizing」というレイアウトの仕組みを、AutoLayout に変換するかどうかを設定するフラグ。falseにしてないとコンフリクトする
        blueLabel.translatesAutoresizingMaskIntoConstraints = false
        redLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView) // 必ずviewに追加する
        view.addSubview(blueLabel)
        view.addSubview(redLabel)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)

        let width = NSLayoutConstraint(
            item: imageView, // 追加するview
            attribute: .width, // 追加するviewの設定部分
            relatedBy: .equal, // 追加するviewと基準viewの関係性
            toItem: view, // 基準
            attribute: .width, // 基準のどこを
            multiplier: 0.5, // 基準に対してかける数値
            constant: 0.0 // 制約で追加する数値
        )

        let height = NSLayoutConstraint(
            item: imageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0
        )

        let centerX = NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
        )

        let centerY = NSLayoutConstraint(
            item: imageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0
        )

        NSLayoutConstraint.activate([width, height, centerX, centerY])
        imageView.backgroundColor = .black

        blueLabel.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.5).isActive = true
        blueLabel.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 0.25).isActive = true
        blueLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        blueLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor).isActive = true
        blueLabel.backgroundColor = .blue

        redLabel.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.5).isActive = true
        redLabel.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 0.25).isActive = true
        redLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        redLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor).isActive = true
        redLabel.backgroundColor = .red

        closeButton.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.5).isActive = true
        closeButton.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 0.25).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 80).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: self.blueLabel.centerXAnchor).isActive = true
        closeButton.setTitle("Close", for: UIControl.State.normal)
        closeButton.setTitleColor(.tintColor, for: UIControl.State.normal)

        reloadButton.widthAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 0.5).isActive = true
        reloadButton.heightAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 0.25).isActive = true
        reloadButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 80).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: self.redLabel.centerXAnchor).isActive = true
        reloadButton.setTitle("Reload", for: UIControl.State.normal)
        reloadButton.setTitleColor(.tintColor, for: UIControl.State.normal)
    }
}

