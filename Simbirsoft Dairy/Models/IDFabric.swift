import Foundation

// ID Fabric. Создает уникальный идентификатор для пользовательских задач/событий
class IDFabric {

    static let shared = IDFabric()
    private var id: Int {
        get {
           UserDefaults.standard.integer(forKey: "uniqueID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "uniqueID")
        }
    }
    
//    private let modificator: Int = 10000
//    // неполная временная логика для разделения идентификатора сгенерированной пользователем задачи и идентификатора задачи в формате JSON путем добавления 10000 к уникальному идентификатору
//    
//    private init() { }
//    
//    public func getUniqueID() -> Int {
//        id += 1
//        return id + modificator
//    }
}
