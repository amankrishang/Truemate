import Foundation

struct QuizAnswer {
    let userID: UUID
    let questionID: String
    var answerText: String
}

enum QuizAnswerStore {
    static var answersByUser: [UUID: [String: String]] = [:]
}
