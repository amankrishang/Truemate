import Foundation

struct QuizOption: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

struct QuizQuestion: Identifiable, Hashable {
    let id: String
    let question: String
    let subtitle: String
    let options: [QuizOption]
}

