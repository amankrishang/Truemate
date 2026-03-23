import Foundation

enum QuizData {
    static let questions: [QuizQuestion] = [
        QuizQuestion(
            id: "home_lifestyle",
            question: "What best describes your home lifestyle?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Mostly quiet + prefer personal space"),
                QuizOption(text: "Some noise is fine"),
                QuizOption(text: "I sleep anywhere"),
                QuizOption(text: "I use headphones while sleeping")
            ]
        ),
        QuizQuestion(
            id: "daily_routine",
            question: "What's your daily routine like?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Early bird"),
                QuizOption(text: "Mid-day schedule"),
                QuizOption(text: "Night owl"),
                QuizOption(text: "No fixed schedule")
            ]
        ),
        QuizQuestion(
            id: "cleanliness",
            question: "How clean and organized are you in shared spaces?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Very clean"),
                QuizOption(text: "Moderately clean"),
                QuizOption(text: "I clean when needed"),
                QuizOption(text: "Not strict")
            ]
        ),
        QuizQuestion(
            id: "guests_social",
            question: "What's your stance on guests and social activity at home?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Prefer no guests"),
                QuizOption(text: "Occasionally fine"),
                QuizOption(text: "Comfortable with guests on weekends"),
                QuizOption(text: "Frequently hosting is fine")
            ]
        ),
        QuizQuestion(
            id: "deal_breaker",
            question: "Which home habit is a deal-breaker for you?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Loud noise or late calls"),
                QuizOption(text: "Dirty / disorganized common areas"),
                QuizOption(text: "Borrowing items without asking"),
                QuizOption(text: "Frequent unexpected guests")
            ]
        ),
        QuizQuestion(
            id: "household_responsibilities",
            question: "How do you prefer handling household responsibilities?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Fixed schedule or rotation"),
                QuizOption(text: "Flexible sharing"),
                QuizOption(text: "Clean as you go"),
                QuizOption(text: "Prefer managing only my own space")
            ]
        ),
        QuizQuestion(
            id: "rent_split",
            question: "What's your financial & rent-splitting preference?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Equal split always"),
                QuizOption(text: "Based on room size"),
                QuizOption(text: "Based on usage/negotiation"),
                QuizOption(text: "Open to discussion case-by-case")
            ]
        ),
        QuizQuestion(
            id: "communication_style",
            question: "How do you prefer communicating with a roommate?",
            subtitle: "Select one",
            options: [
                QuizOption(text: "Clear rules set early"),
                QuizOption(text: "Calm conversations when needed"),
                QuizOption(text: "Direct, open communication"),
                QuizOption(text: "Minimal communication preferred")
            ]
        )
    ]
}

