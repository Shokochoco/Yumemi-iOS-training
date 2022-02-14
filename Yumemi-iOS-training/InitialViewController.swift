import Foundation
import UIKit

class InitialViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        moveToViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        moveToViewController()
    }

    func moveToViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
