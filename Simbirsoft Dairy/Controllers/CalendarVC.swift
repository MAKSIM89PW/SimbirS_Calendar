import UIKit
import CalendarKit

class CalendarVC: DayViewController {

    var events = [EventModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar SimbirSoft"
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        button.accessibilityIdentifier = "addButtonCalendarVC"
        navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Проверка наличия обновлений
        events = DataManager.shared.events
        reloadData()
    }
    
    @objc func addEvent() {
        let atvc = AddTaskVC()
        navigationController?.pushViewController(atvc, animated: true)
    }
    
    // Загрузка events/tasks
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return events
    }

    // Обработка нажатия event/task
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        presentDetailViewForEvent(eventModel)
    }

    // Push detailed view controller
    private func presentDetailViewForEvent(_ event: EventModel) {
        let dvc = DetailVC()
        dvc.event = event
        navigationController?.pushViewController(dvc, animated: true)
    }
}
