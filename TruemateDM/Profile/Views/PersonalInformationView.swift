import SwiftUI

struct PersonalInformationView: View {
    @Environment(\.dismiss) var dismiss

    @State private var locationSharing: Bool = true
    @State private var showEditName = false

    let name = "Varnika Singh"
    let email = "good@example.com"
    let phone = "+91 555 444 3333"
    let dob = "5 June 1999"

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                Text("Personal Information")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Circle()
                    .fill(Color.clear)
                    .frame(width: 36, height: 36)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))

            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 2)
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .foregroundColor(Color(.systemGray3))
                        }

                        Button(action: {}) {
                            Text("Change")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top, 16)

                    VStack(spacing: 0) {
                        InfoNavigationRow(label: "Name", value: name, action: { showEditName = true })
                        Divider().padding(.leading, 16)
                        InfoNavigationRow(label: "Email ID", value: email, action: {})
                        Divider().padding(.leading, 16)
                        InfoNavigationRow(label: "Phone Number", value: phone, action: {})
                        Divider().padding(.leading, 16)
                        InfoNavigationRow(label: "Date of birth", value: dob, action: {})
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    HStack {
                        Text("Current Location Sharing")
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        Spacer()
                        Toggle("", isOn: $locationSharing)
                            .labelsHidden()
                            .tint(.green)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    Spacer()
                }
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .sheet(isPresented: $showEditName) {
            EditNameView()
        }
    }
}

struct InfoNavigationRow: View {
    let label: String
    let value: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                Spacer()
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray3))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
        }
    }
}

#Preview {
    PersonalInformationView()
}
