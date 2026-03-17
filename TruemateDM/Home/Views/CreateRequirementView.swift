import SwiftUI
import SwiftData

struct CreateRequirementView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [User]

    // Flat Seeker fields
    @State private var preferredLocation: String = ""
    @State private var budget: String = ""
    @State private var moveInDate: Date = Date().addingTimeInterval(30 * 24 * 3600)
    @State private var details: String = ""

    // Flat Owner fields
    @State private var propertyName: String = ""
    @State private var propertyType: String = "apartment"
    @State private var roomType: String = "single"
    @State private var location: String = ""
    @State private var rent: String = ""
    @State private var genderPreference: String = "any"
    @State private var listingDescription: String = ""

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)
    private let propertyTypes = ["apartment", "villa", "pg", "shared"]
    private let roomTypes = ["single", "double", "triple"]
    private let genderOptions = ["any", "male", "female"]

    private var currentUser: User? { users.first }
    private var isFindingFlats: Bool {
        currentUser?.activeMode == .findFlats || currentUser?.activeMode == .both
    }

    var body: some View {
        Form {
            if isFindingFlats {
                flatSeekerForm
            } else {
                flatOwnerForm
            }
        }
        .navigationTitle(isFindingFlats ? "Find a Flat" : "List Your Space")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { saveRequirement() }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(accentColor)
            }
        }
    }

    // MARK: - Flat Seeker Form
    private var flatSeekerForm: some View {
        Group {
            Section("Where are you looking?") {
                TextField("Preferred Location", text: $preferredLocation)
                TextField("Budget (₹/month)", text: $budget)
                    .keyboardType(.numberPad)
                DatePicker("Move-in Date", selection: $moveInDate, displayedComponents: .date)
            }

            Section("Additional Details") {
                TextEditor(text: $details)
                    .frame(minHeight: 100)
            }
        }
    }

    // MARK: - Flat Owner Form
    private var flatOwnerForm: some View {
        Group {
            Section("Property Details") {
                TextField("Property Name", text: $propertyName)
                Picker("Property Type", selection: $propertyType) {
                    ForEach(propertyTypes, id: \.self) { Text($0.capitalized) }
                }
                Picker("Room Type", selection: $roomType) {
                    ForEach(roomTypes, id: \.self) { Text($0.capitalized) }
                }
            }

            Section("Location & Rent") {
                TextField("Location", text: $location)
                TextField("Rent (₹/month)", text: $rent)
                    .keyboardType(.numberPad)
            }

            Section("Preferences") {
                Picker("Gender Preference", selection: $genderPreference) {
                    ForEach(genderOptions, id: \.self) { Text($0.capitalized) }
                }
            }

            Section("Description") {
                TextEditor(text: $listingDescription)
                    .frame(minHeight: 100)
            }
        }
    }

    // MARK: - Save
    private func saveRequirement() {
        guard let user = currentUser else { return }

        if isFindingFlats {
            let post = FlatSeekerPost(
                userID: user.id,
                preferredLocation: preferredLocation,
                budget: Double(budget) ?? 0,
                moveInDate: moveInDate,
                details: details
            )
            modelContext.insert(post)
        } else {
            let listing = FlatmateListing(
                ownerID: user.id,
                propertyName: propertyName,
                propertyType: propertyType,
                roomType: roomType,
                location: location,
                rent: Double(rent) ?? 0,
                genderPreference: genderPreference,
                description: listingDescription
            )
            listing.suitabilityScore = Int.random(in: 50...95)
            modelContext.insert(listing)
        }

        try? modelContext.save()
        dismiss()
    }
}
