import Foundation

class DataManager {

    static let shared = DataManager()
    private let adapter = Adapter() // [TaskModel] <=> [EventModel]
    
    private init() { }
    
    // Тип файлов задач в формате JSON
    private var tasks: [TaskModel] {
        get {
            guard let data = try? Data(contentsOf: .tasks) else { return [] }
            return (try? JSONDecoder().decode([TaskModel].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .tasks)
        }
    }
    
    // CalendarKit эвенты
    var events: [EventModel] {
        get {
            adapter.getEvents(from: tasks)
        }
        set {
            tasks = adapter.getTasks(from: newValue)
        }
    }
}
