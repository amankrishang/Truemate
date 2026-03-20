import SwiftUI
import SwiftData

struct SignInView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var errorMessage: String = ""

    var onSignInSuccess: (() -> Void)? = nil
    var onSignUpTap: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 80)

            Text("Sign In")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color(red: 0.15, green: 0.30, blue: 0.95))
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

            TextField("Phone or Email", text: $emailOrPhone)
                .font(.system(size: 15))
                .foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color(red: 0.95, green: 0.96, blue: 0.98))
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(red: 0.75, green: 0.80, blue: 0.95), lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 12)

            HStack {
                Group {
                    if showPassword {
                        TextField("Enter your password", text: $password)
                    } else {
                        SecureField("Enter your password", text: $password)
                    }
                }
                .font(.system(size: 15))
                .foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .font(.system(size: 16))
                        .foregroundColor(Color(.systemGray3))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.98))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(red: 0.75, green: 0.80, blue: 0.95), lineWidth: 1)
            )
            .padding(.horizontal, 24)

            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Forgot Password?")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 6)

            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Login using OTP?")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                Spacer()
            }
            .padding(.bottom, 16)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundColor(.red)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 10)
            }

            Button(action: signIn) {
                Text("Log In")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(Color(red: 0.18, green: 0.32, blue: 0.95))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 14)

            HStack(spacing: 4) {
                Text("New to our app?")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                Button(action: { onSignUpTap?() }) {
                    Text("Sign Up")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.18, green: 0.32, blue: 0.95))
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)

            HStack(spacing: 12) {
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(height: 0.8)
                Text("Or")
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(height: 0.8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)

            HStack(spacing: 12) {
                Button(action: {}) {
                    HStack(spacing: 10) {
                        GoogleIconView()
                        Text("Google")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }

                Button(action: {}) {
                    HStack(spacing: 10) {
                        Image(systemName: "apple.logo")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Apple")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.black)
                    .cornerRadius(14)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func signIn() {
        let identifier = emailOrPhone.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !identifier.isEmpty else {
            errorMessage = "Please enter phone or email."
            return
        }

        guard !pwd.isEmpty else {
            errorMessage = "Please enter password."
            return
        }

        if let existing = users.first(where: {
            $0.email.caseInsensitiveCompare(identifier) == .orderedSame || $0.phoneNumber == identifier
        }) {
            if existing.activeModeRaw.isEmpty {
                existing.activeMode = .both
            }
            existing.isOnboardingComplete = false
        } else {
            let isEmail = identifier.contains("@")
            let user = User(
                fullName: "",
                email: isEmail ? identifier : "",
                phoneNumber: isEmail ? "" : identifier,
                age: 25
            )
            user.activeMode = .both
            user.isOnboardingComplete = false
            modelContext.insert(user)
        }

        do {
            try modelContext.save()
            errorMessage = ""
            onSignInSuccess?()
        } catch {
            errorMessage = "Could not sign in. Please try again."
        }
    }
}

struct GoogleIconView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)

            Text("G")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .red, .yellow, .green],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

#Preview {
    SignInView()
}
