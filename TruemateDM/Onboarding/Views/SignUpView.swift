import SwiftUI
import SwiftData

struct SignUpView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    @State private var name: String = ""
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var agreedToTerms: Bool = false
    @State private var errorMessage: String = ""

    var onSignUpSuccess: (() -> Void)? = nil
    var onSignInTap: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 80)

            Text("Sign Up")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color(red: 0.15, green: 0.30, blue: 0.95))
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

            TextField("Name", text: $name)
                .font(.system(size: 15))
                .foregroundColor(.black)
                .textInputAutocapitalization(.words)
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

            TextField("Email/Phone Number", text: $emailOrPhone)
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
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
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
            .padding(.bottom, 14)

            HStack(alignment: .top, spacing: 10) {
                Button(action: { agreedToTerms.toggle() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.systemGray3), lineWidth: 1.5)
                            .frame(width: 20, height: 20)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(agreedToTerms
                                          ? Color(red: 0.18, green: 0.32, blue: 0.95)
                                          : Color.white)
                            )
                        if agreedToTerms {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: 20, height: 20)
                .padding(.top, 1)

                Group {
                    Text("I agree to the ")
                        .foregroundColor(.black)
                    + Text("Terms of Service")
                        .foregroundColor(Color(red: 0.18, green: 0.32, blue: 0.95))
                    + Text(" and ")
                        .foregroundColor(.black)
                    + Text("Privacy Policy")
                        .foregroundColor(Color(red: 0.18, green: 0.32, blue: 0.95))
                }
                .font(.system(size: 13))
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundColor(.red)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
            }

            Button(action: signUp) {
                Text("Create Account")
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
                Text("Already an user?")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                Button(action: { onSignInTap?() }) {
                    Text("Sign In")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.18, green: 0.32, blue: 0.95))
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func signUp() {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let identifier = emailOrPhone.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanName.isEmpty else {
            errorMessage = "Please enter your name."
            return
        }

        guard !identifier.isEmpty else {
            errorMessage = "Please enter email or phone number."
            return
        }

        guard !pwd.isEmpty else {
            errorMessage = "Please enter password."
            return
        }

        guard agreedToTerms else {
            errorMessage = "Please agree to Terms and Privacy Policy."
            return
        }

        let alreadyExists = users.contains(where: {
            $0.email.caseInsensitiveCompare(identifier) == .orderedSame || $0.phoneNumber == identifier
        })

        guard !alreadyExists else {
            errorMessage = "Account already exists. Please sign in."
            return
        }

        let isEmail = identifier.contains("@")
        let newUser = User(
            fullName: cleanName,
            email: isEmail ? identifier : "",
            phoneNumber: isEmail ? "" : identifier,
            age: 25
        )
        newUser.activeMode = .both
        newUser.isOnboardingComplete = false

        modelContext.insert(newUser)

        do {
            try modelContext.save()
            errorMessage = ""
            onSignUpSuccess?()
        } catch {
            errorMessage = "Could not create account. Please try again."
        }
    }
}

#Preview {
    SignUpView()
}
