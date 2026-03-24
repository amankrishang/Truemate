import SwiftUI

struct CreatePostView: View {
    @Binding var isPresented: Bool
    var onPostCreated: (() -> Void)? = nil

    @State private var propertyType = "Apartment"
    @State private var roomType = "Single"
    @State private var furnishing = "Semi"

    @State private var state = ""
    @State private var city = ""

    @State private var gender = "Male"

    @State private var maxBudget = ""

    @State private var genderPreference = "Male"
    @State private var moveInDate = Date()

    let propertyTypeOptions = PostFormOptions.propertyTypes
    let roomTypeOptions = PostFormOptions.roomTypes
    let furnishingOptions = PostFormOptions.furnishingOptions
    let genderOptions = PostFormOptions.genderOptions

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        CreatePostSectionView(title: "Property Choice") {
                            VStack(spacing: 0) {
                                CreatePostPickerRow(label: "Property Type", selection: $propertyType, options: propertyTypeOptions)
                                Divider().padding(.leading, 16)
                                CreatePostPickerRow(label: "Room Type", selection: $roomType, options: roomTypeOptions)
                                Divider().padding(.leading, 16)
                                CreatePostPickerRow(label: "Furnishing", selection: $furnishing, options: furnishingOptions)
                            }
                        }

                        CreatePostSectionView(title: "Location") {
                            VStack(spacing: 0) {
                                CreatePostTextFieldRow(placeholder: "State", text: $state)
                                Divider().padding(.leading, 16)
                                CreatePostTextFieldRow(placeholder: "City", text: $city)
                            }
                        }

                        CreatePostSectionView(title: "You are") {
                            CreatePostPickerRow(label: "Gender", selection: $gender, options: genderOptions)
                        }

                        CreatePostSectionView(title: "Budget") {
                            CreatePostTextFieldRow(placeholder: "Maximum Monthly Budget", text: $maxBudget, keyboardType: .numberPad)
                        }

                        CreatePostSectionView(title: "Flatmate Preferences") {
                            VStack(spacing: 0) {
                                CreatePostPickerRow(label: "Gender Preferences", selection: $genderPreference, options: genderOptions)
                                Divider().padding(.leading, 16)
                                CreatePostDatePickerRow(label: "Move-in Date", date: $moveInDate)
                            }
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(Circle())
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { handleSubmit() }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }

    private func handleSubmit() {
        onPostCreated?()
        isPresented = false
    }
}

struct CreatePostSectionView<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.secondary)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                content
            }
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct CreatePostPickerRow: View {
    let label: String
    @Binding var selection: String
    let options: [String]

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.primary)

            Spacer()

            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) { selection = option }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(selection)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

struct CreatePostTextFieldRow: View {
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

struct CreatePostDatePickerRow: View {
    let label: String
    @Binding var date: Date

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.primary)

            Spacer()

            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.compact)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
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

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            Spacer()
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) { value = option }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(value)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
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
