import SwiftUI

struct EditNameView: View {
    @Binding var isPresented: Bool

    @State private var firstName: String = ""
    @State private var lastName: String = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { isPresented = false }) {
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

                Text("Name")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Button(action: { handleSave() }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 36, height: 36)
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            VStack(spacing: 0) {
                HStack {
                    Text("First")
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    TextField("", text: $firstName)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    if !firstName.isEmpty {
                        Button(action: { firstName = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(.systemGray3))
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)

                Divider()
                    .padding(.leading, 16)

                HStack {
                    Text("Second")
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    TextField("", text: $lastName)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Color.clear.frame(width: 0, height: 0)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
            }
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.top, 20)

            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }

    private func handleSave() {
        isPresented = false
    }
}

#Preview {
    EditNameView(isPresented: .constant(true))
}
