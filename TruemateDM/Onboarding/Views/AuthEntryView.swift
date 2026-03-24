import SwiftUI

enum AuthScreen {
    case signIn
    case signUp
    case intro
    case lookingFor
    case lifestyleQuiz
    case profileSetup
    case notifications
    case location
    case home
    case homeCreatePost
}

struct AuthEntryView: View {
    @State private var screen: AuthScreen = .signIn

    var body: some View {
        Group {
            switch screen {
            case .signIn:
                SignInView(
                    onSignInSuccess: {
                        screen = .intro
                    },
                    onSignUpTap: {
                        screen = .signUp
                    }
                )
            case .signUp:
                SignUpView(
                    onSignUpSuccess: {
                        screen = .intro
                    },
                    onSignInTap: {
                        screen = .signIn
                    }
                )
            case .intro:
                TrueMateOnboardingView(
                    onGetStarted: {
                        screen = .lookingFor
                    }
                )
            case .lookingFor:
                LookingForView(
                    onNext: {
                        screen = .lifestyleQuiz
                    }
                )
            case .lifestyleQuiz:
                HomeLifestyleQuizView(
                    onNext: {
                        if User.currentUser?.activeMode == .findFlatmates {
                            screen = .homeCreatePost
                        } else {
                            screen = .profileSetup
                        }
                    }
                )
            case .profileSetup:
                ProfileSetupView(
                    onContinue: {
                        screen = .notifications
                    }
                )
            case .notifications:
                NotificationsPermissionView(
                    onAllow: {
                        screen = .location
                    },
                    onNotNow: {
                        screen = .location
                    }
                )
            case .location:
                LocationPermissionView(
                    onEnable: {
                        screen = .home
                    },
                    onNotNow: {
                    }
                )
            case .home:
                BaseMatchView()
            case .homeCreatePost:
                BaseMatchView(openFlatmatesCreateOnAppear: true)
            }
        }
    }
}

#Preview {
    AuthEntryView()
}
