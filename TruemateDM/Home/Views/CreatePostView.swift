import SwiftUI

struct CreatePostView: View {
    @Binding var isPresented: Bool
    var onPostCreated: (() -> Void)? = nil

    @State private var propertyType: String = "Apartment"
    @State private var roomType: String = "Single"
    @State private var propertyName: String = "2BHK fully furnished"

    @State private var description: String = "Hi there this my beautiful fla"

    @State private var state: String = ""
    @State private var city: String = ""

    @State private var gender: String = "Male"

    @State private var monthlyRent: String = ""

    let propertyTypes = PostFormOptions.propertyTypes
    let roomTypes = PostFormOptions.roomTypes
    let genderOptions = PostFormOptions.genderOptions

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { isPresented = false }) {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 36, height: 36)
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }

                Spacer()

                Text("Create Post")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Button(action: { handleSubmit() }) {
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
            .background(Color(.systemGray6))

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SectionHeader(title: "Property Choice")

                    VStack(spacing: 0) {
                        PickerRow(label: "Property Type", value: $propertyType, options: propertyTypes)
                        Divider().padding(.leading, 16)
                        PickerRow(label: "Room Type", value: $roomType, options: roomTypes)
                        Divider().padding(.leading, 16)
                        ClearableInputRow(placeholder: "Property name", text: $propertyName)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)

                    SectionHeader(title: "Add description")

                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $description)
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                            .frame(height: 100)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)

                        if description.isEmpty {
                            Text("Hi there this my beautiful flat...")
                                .font(.system(size: 15))
                                .foregroundColor(Color(.systemGray3))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 16)
                                .allowsHitTesting(false)
                        }

                        if !description.isEmpty {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: { description = "" }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color(.systemGray3))
                                            .font(.system(size: 16))
                                    }
                                    .padding(10)
                                }
                                Spacer()
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)

                    SectionHeader(title: "Location")

                    VStack(spacing: 0) {
                        PlainInputRow(placeholder: "State", text: $state)
                        Divider().padding(.leading, 16)
                        PlainInputRow(placeholder: "City", text: $city)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)

                    SectionHeader(title: "Looking for")

                    VStack(spacing: 0) {
                        PickerRow(label: "Gender", value: $gender, options: genderOptions)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)

                    SectionHeader(title: "Budget")

                    VStack(spacing: 0) {
                        PlainInputRow(placeholder: "Monthly Rent", text: $monthlyRent, keyboardType: .numberPad)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)

                    SectionHeader(title: "Photos")

                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            Text("Add Flat Photos")
                                .font(.system(size: 15))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(14)
                    }
                    .padding(.horizontal)

                    SectionHeader(title: "AR Model (Optional)")

                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "rotate.3d")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            Text("Add Flat AR model")
                                .font(.system(size: 15))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(14)
                    }
                    .padding(.horizontal)

                    Button(action: { handleSubmit() }) {
                        Text("Create Post")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                .padding(.top, 16)
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }

    private func handleSubmit() {
        onPostCreated?()
        isPresented = false
    }
}

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(Color(.systemGray))
            .padding(.horizontal, 20)
            .padding(.bottom, -8)
    }
}

struct PickerRow: View {
    let label: String
    @Binding var value: String
    let options: [String]
    @State private var showPicker = false

    var body: some View {
        Button(action: { showPicker = true }) {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                Spacer()
                Text(value)
                    .font(.system(size: 15))
                    .foregroundColor(Color(.systemGray))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 11))
                    .foregroundColor(Color(.systemGray))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .confirmationDialog("Select \(label)", isPresented: $showPicker, titleVisibility: .visible) {
            ForEach(options, id: \.self) { option in
                Button(option) { value = option }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct PlainInputRow: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 15))
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .keyboardType(keyboardType)
    }
}

struct ClearableInputRow: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text(placeholder)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            Spacer()
            TextField("", text: $text)
                .multilineTextAlignment(.trailing)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemGray))
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    CreatePostView(isPresented: .constant(true))
}
