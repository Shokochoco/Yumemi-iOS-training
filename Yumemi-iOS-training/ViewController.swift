import Foundation
import UIKit
import YumemiWeather

class ViewController: UIViewController {

    let stackViewV = UIStackView()
    let stackViewH = UIStackView()
    let imageView = UIImageView()
    let blueLabel = UILabel()
    let redLabel = UILabel()
    let closeButton = UIButton()
    let reloadButton = UIButton()
    let activityIndicatorView = UIActivityIndicatorView()

    var apiModel = APIModel()
    
    deinit {
        print("deinit呼ばれた")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        apiModel.delegate = self
        apiModel.indicatorDelegate = self

        layout()
        reloadButtonAction()
        closeButtonAction()
        NotificationCenter.default.addObserver(self, selector: #selector(foreground(notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        showIndicater()
    }

    func showIndicater() {
        activityIndicatorView.center = view.center
        activityIndicatorView.style = UIActivityIndicatorView.Style.large
        activityIndicatorView.color = .gray
        view.addSubview(activityIndicatorView)
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

    func reloadButtonAction() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [weak self] in

            let action = UIAction { [weak self] _ in
                self?.apiModel.getAPI() // これがないと呼び出せない
            }
            DispatchQueue.main.async {
                self?.reloadButton.addAction(action, for: .touchUpInside)
            }

        }
    }

    func alertAction(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)) // weakにする？
        present(alert, animated: true, completion: nil)
    }

    func closeButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        self.closeButton.addAction(action, for: .touchUpInside)
    }

    @objc func foreground(notification: Notification) {
        apiModel.getAPI()
    }

}

extension ViewController: IndicatorDelegate {

    func indicatorStart() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }

    func indicatorStop() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }

}

extension ViewController: WeatherDelegate {

    func appearWeather(weatherDecoded: Weather) {

        DispatchQueue.main.async {
            
            self.blueLabel.text = String(weatherDecoded.min_temp)
            self.redLabel.text = String(weatherDecoded.max_temp)

            switch weatherDecoded.weather {
            case "sunny":
                self.imageView.image = UIImage(named: weatherDecoded.weather )?.withRenderingMode(.alwaysTemplate)
                self.imageView.tintColor = .red
            case "cloudy":
                self.imageView.image = UIImage(named: weatherDecoded.weather )?.withRenderingMode(.alwaysTemplate)
                self.imageView.tintColor = .lightGray
            case "rainy":
                self.imageView.image = UIImage(named: weatherDecoded.weather )?.withRenderingMode(.alwaysTemplate)
                self.imageView.tintColor = .blue
            default:
                self.imageView.tintColor = .black
            }

        }
    }

    func failError(error: YumemiWeatherError) {
        DispatchQueue.main.async {
            if error  == YumemiWeatherError.unknownError {
                self.alertAction(message: "エラー1")

            } else if error  == YumemiWeatherError.invalidParameterError {
                self.alertAction(message: "エラー2")

            }
        }
    }
}
