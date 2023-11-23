import Foundation

struct Weather: Hashable {
    var date: String
    var dayOfWeek: String
    var statusImageName: String
    var degree: Int
    
    init() {
        self.date = ""
        self.dayOfWeek = ""
        self.statusImageName = ""
        self.degree = 0
    }
    
    init(date: String, hour: String, statusImageName: String, degree: Int) {
        self.date = date
        self.dayOfWeek = hour
        self.statusImageName = statusImageName
        self.degree = degree
    }
}
