import UIKit

class ViewController: UIViewController {

    let stackViewV = UIStackView()
    let stackViewH = UIStackView()
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

        stackViewV.translatesAutoresizingMaskIntoConstraints = false // AutoLayout 以前に使われていた「Autosizing」というレイアウトの仕組みを、AutoLayout に変換するかどうかを設定するフラグ。falseにしてないとコンフリクトする
        stackViewH.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        blueLabel.translatesAutoresizingMaskIntoConstraints = false
        redLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackViewV) // 必ずviewに追加する
        view.addSubview(stackViewH)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)
        // stackView同士は入れ子にしない
        stackViewH.addArrangedSubview(blueLabel)
        stackViewH.addArrangedSubview(redLabel)
        stackViewV.addArrangedSubview(imageView)

        stackViewV.axis = .vertical
        stackViewH.axis = .horizontal

        stackViewV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true // width,height設定しないと表示されない
        stackViewV.heightAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: 1.25).isActive = true
        stackViewV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        imageView.widthAnchor.constraint(equalTo: stackViewV.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: stackViewV.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: stackViewV.topAnchor).isActive = true
        imageView.backgroundColor = .black

        stackViewH.widthAnchor.constraint(equalTo: stackViewV.widthAnchor).isActive = true
        stackViewH.heightAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: 0.25).isActive = true
        stackViewH.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        stackViewH.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true

        blueLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        blueLabel.heightAnchor.constraint(equalTo: stackViewH.heightAnchor).isActive = true
        blueLabel.text = "blue"
        blueLabel.textColor = .tintColor
        blueLabel.textAlignment = NSTextAlignment.center

        redLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        redLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.25).isActive = true
        redLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        redLabel.text = "Red"
        redLabel.textColor = .red
        redLabel.textAlignment = NSTextAlignment.center

        closeButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        closeButton.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.25).isActive = true
        closeButton.topAnchor.constraint(equalTo: stackViewH.bottomAnchor, constant: 80).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: blueLabel.centerXAnchor).isActive = true
        closeButton.setTitle("Close", for: UIControl.State.normal)
        closeButton.setTitleColor(.tintColor, for: UIControl.State.normal)

        reloadButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        reloadButton.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.25).isActive = true
        reloadButton.topAnchor.constraint(equalTo: stackViewH.bottomAnchor, constant: 80).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: redLabel.centerXAnchor).isActive = true
        reloadButton.setTitle("Reload", for: UIControl.State.normal)
        reloadButton.setTitleColor(.tintColor, for: UIControl.State.normal)

    }
}
