import UIKit

class AddTaskVC: UIViewController {
    
    var addTaskView: AddTaskView!
    var event: EventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
        addTaskView.addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        // Коснитесь распознавателя, чтобы отключить клавиатуру при внешнем нажатии
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
    }
    
    @objc func addTask() {
        // Проверка вводимых пользователем данные
        guard let name = addTaskView.nameTextField.text, name != "" else { return }
        let start = addTaskView.startDatePicker.date
        var finish = addTaskView.finishDatePicker.date
        
        // неполная временная логика
        if finish.timeIntervalSince1970 < start.timeIntervalSince1970 + 1800 {
            finish = Date(timeIntervalSince1970: start.timeIntervalSince1970 + 1800)
        }
        
        // Создание нового экземпляра события
        let event = EventModel()
        //event.id = IDFabric.shared.getUniqueID()
        event.text = name
        event.description = addTaskView.descriptionTextField.text ?? ""
        event.dateInterval = DateInterval(start: start, end: finish)
        
        // Сохранение новых данных
        var events = DataManager.shared.events
        events.append(event)
        DataManager.shared.events = events
        
        // отключение VC
        navigationController?.popToRootViewController(animated: true)
    }
    
    // отключение клавиатуры
    @objc private func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func addView() {
        addTaskView = AddTaskView()
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
        addTaskView.accessibilityIdentifier = "addTaskView"
        view.addSubview(addTaskView)
        
        NSLayoutConstraint.activate([
            addTaskView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
