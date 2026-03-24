import SwiftUI

struct CoLivingProfileSetupView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var age: String = ""

    var onContinue: (() -> Void)? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Profile Setup")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.blue)

                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color(.systemGray6))
                        .frame(height: 160)

                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray5))
                                .frame(width: 90, height: 90)

                            Image(systemName: "camera")
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                        }

                        Text("Add Profile Photo")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                }

                Text("Personal Information")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)

                VStack(spacing: 0) {
                    inputField("Full Name", text: $fullName, showClear: true)
                    divider()
                    inputField("Email", text: $email)
                    divider()
                    inputField("Phone Number", text: $phone)
                    divider()
                    inputField("Age", text: $age)
                }
                .background(Color(.systemGray6))
                .cornerRadius(18)

                HStack(spacing: 8) {
                    Image(systemName: "checkmark.shield")
                        .foregroundColor(.blue)

                    Text("Verify Aadhaar via DigiLocker")
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)

                Button(action: {
                    saveToModel()
                    onContinue?()
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(30)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 24)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    func inputField(_ placeholder: String, text: Binding<String>, showClear: Bool = false) -> some View {
        HStack {
            TextField(placeholder, text: text)
                .font(.system(size: 15))

            if showClear && !text.wrappedValue.isEmpty {
                Button {
                    text.wrappedValue = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }

    func divider() -> some View {
        Rectangle()
            .fill(Color(.systemGray4))
            .frame(height: 0.5)
            .padding(.leading)
    }

    func saveToModel() {
        guard let user = User.currentUser else { return }
        user.fullName = fullName
        user.email = email
        user.phoneNumber = phone
        user.age = Int(age) ?? 0
    }
}

#Preview {
    CoLivingProfileSetupView()
}
