import SwiftUI

struct HomeLifestyleQuizView: View {
    @State private var currentIndex = 0
    @State private var selections: [String: String] = [:]

    var onNext: (() -> Void)? = nil
    var onBack: (() -> Void)? = nil

    private var mode: UserMode { User.currentUser?.activeMode ?? .findFlats }
    private var questions: [QuizQuestion] { QuizData.questions(for: mode) }
    private var totalQuestions: Int { questions.count }
    private var currentQuestion: QuizQuestion { questions[currentIndex] }
    private var progress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentIndex + 1) / Double(totalQuestions)
    }
    private var selectedAnswerForCurrent: String? { selections[currentQuestion.id] }
    private var isLastQuestion: Bool { currentIndex == totalQuestions - 1 }
    private var isFirstQuestion: Bool { currentIndex == 0 }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(white: 0.88))
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.22, green: 0.42, blue: 0.98))
                        .frame(width: geo.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 20)
            .padding(.top, 16)

            Text(currentQuestion.question)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(Color(red: 0.22, green: 0.42, blue: 0.98))
                .padding(.horizontal, 20)
                .padding(.top, 32)

            Text(currentQuestion.subtitle)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            VStack(spacing: 14) {
                ForEach(currentQuestion.options) { option in
                    Button(action: {
                        selections[currentQuestion.id] = option.text
                    }) {
                        Text(option.text)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        selectedAnswerForCurrent == option.text
                                            ? Color(red: 0.22, green: 0.42, blue: 0.98)
                                            : Color(red: 0.22, green: 0.42, blue: 0.98).opacity(0.4),
                                        lineWidth: selectedAnswerForCurrent == option.text ? 2 : 1
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)

            Spacer()

            HStack {
                Button(action: handlePrevious) {
                    Text(isFirstQuestion ? "Back" : "Previous")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(red: 0.22, green: 0.42, blue: 0.98))
                        .padding(.horizontal, 28)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .overlay(
                            Capsule()
                                .stroke(Color(red: 0.22, green: 0.42, blue: 0.98), lineWidth: 1)
                        )
                }

                Spacer()

                Button(action: handleNext) {
                    Text(isLastQuestion ? "Finish" : "Next")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color(red: 0.22, green: 0.42, blue: 0.98))
                        .clipShape(Capsule())
                }
                .disabled(selectedAnswerForCurrent == nil)
                .opacity(selectedAnswerForCurrent == nil ? 0.5 : 1)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            if currentIndex >= totalQuestions {
                currentIndex = 0
            }
        }
    }

    private func handleNext() {
        guard selectedAnswerForCurrent != nil else { return }

        if isLastQuestion {
            saveAnswers()
            onNext?()
            return
        }

        currentIndex += 1
    }

    private func handlePrevious() {
        if isFirstQuestion {
            onBack?()
            return
        }

        currentIndex -= 1
    }

    private func saveAnswers() {
        guard let user = User.currentUser else { return }
        QuizAnswerStore.answersByUser[user.id] = selections
    }
}

#Preview {
    HomeLifestyleQuizView()
}
