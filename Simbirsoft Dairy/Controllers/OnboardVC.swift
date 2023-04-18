import UIKit
import SwiftyOnboard

class OnboardVC: UIViewController {
    
    let onboardTitleArray: [String] = ["Сохрани задачи", "Добавь задания", "Делитесь с друзьями"]
    let onboardSubTitleArray: [String] = ["Прокрутка дат", "Ничего не забывай", "Создано @wittenbm в качестве тестового задания SimbirSoft"]

    var swiftyOnboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .white
        }
        
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }

    @objc func handleSkip() {
        goToCalendar()
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        if index == 2 {
            goToCalendar()
        } else {
            print("Next")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
    }
    
    func goToCalendar() {
        let nc = UINavigationController(rootViewController: CalendarVC())
        nc.navigationBar.backgroundColor = .systemBackground
        nc.modalPresentationStyle = .overFullScreen
        present(nc, animated: true, completion: nil)
    }
}

//MARK: - SwiftyOnboard protocols

extension OnboardVC: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    
    // Настройка страницы для входа в систему
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        onboardTitleArray.count
    }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        page.title.text = onboardTitleArray[index]
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 32)

        page.subTitle.text = onboardSubTitleArray[index]
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 20)
        
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .white
        }

        page.imageView.image = UIImage(named: "\(index).jpeg")
        
        return page
    }
    
    // Настройка встроенного наложения
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        overlay.skipButton.accessibilityIdentifier = "закрыть"
        
        return overlay
    }
   
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("далее", for: .normal)
            overlay.skipButton.setTitle("закрыть", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Начинаем!", for: .normal)
        }
    }
}
