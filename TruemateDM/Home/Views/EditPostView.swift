import SwiftUI

struct EditPostView: View {
    @Binding var isPresented: Bool

    @State private var propertyType = "Apartment"
    @State private var roomType = "Single"
    @State private var furnishing = "Semi"

    @State private var state = ""
    @State private var city = ""

    @State private var gender = "Male"

    @State private var maxBudget = ""

    @State private var genderPreference = "Male"
    @State private var occupation = "Student"
    @State private var moveInDate = Date()

    let propertyTypeOptions = PostFormOptions.propertyTypes
    let roomTypeOptions = PostFormOptions.roomTypes
    let furnishingOptions = PostFormOptions.furnishingOptions
    let genderOptions = PostFormOptions.genderOptions
    let occupationOptions = PostFormOptions.occupationOptions

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        FormSectionView(title: "Property Choice") {
                            VStack(spacing: 0) {
                                FormPickerRow(label: "Property Type", selection: $propertyType, options: propertyTypeOptions)
                                FormDividerView()
                                FormPickerRow(label: "Room Type", selection: $roomType, options: roomTypeOptions)
                                FormDividerView()
                                FormPickerRow(label: "Furnishing", selection: $furnishing, options: furnishingOptions)
                            }
                        }

                        FormSectionView(title: "Location") {
                            VStack(spacing: 0) {
                                FormTextFieldRow(placeholder: "State", text: $state)
                                FormDividerView()
                                FormTextFieldRow(placeholder: "City", text: $city)
                            }
                        }

                        FormSectionView(title: "Looking for") {
                            FormPickerRow(label: "Gender", selection: $gender, options: genderOptions)
                        }

                        FormSectionView(title: "Budget") {
                            FormTextFieldRow(placeholder: "Maximum Monthly Budget", text: $maxBudget, keyboardType: .numberPad)
                        }

                        FormSectionView(title: "Flatmate Preferences") {
                            VStack(spacing: 0) {
                                FormPickerRow(label: "Gender Preferences", selection: $genderPreference, options: genderOptions)
                                FormDividerView()
                                FormPickerRow(label: "Occupation", selection: $occupation, options: occupationOptions)
                                FormDividerView()
                                FormDateRow(label: "Move-in Date", date: $moveInDate)
                            }
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Edit Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemBackground))
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color(UIColor.systemGray5), lineWidth: 0.5)
                            )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct FormSectionView<Content: View>: View {
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

struct FormDividerView: View {
    var body: some View {
        Divider().padding(.horizontal, 16)
    }
}

struct FormPickerRow: View {
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
                HStack(spacing: 3) {
                    Text(selection)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

struct FormTextFieldRow: View {
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

struct FormDateRow: View {
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

#Preview {
    EditPostView(isPresented: .constant(true))
}
