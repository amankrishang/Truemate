import SwiftUI

struct PreferencesView: View {
    @Binding var isPresented: Bool

    enum LookingForTab: String, CaseIterable {
        case room = "Room"
        case roommate = "Roommate"
        case both = "Both"
    }
    @State private var lookingFor: LookingForTab = .room

    @State private var preferredState: String = "Uttar Pradesh"
    @State private var preferredCity: String = "Greater Noida"

    @State private var searchRadius: Double = 8

    @State private var budget: String = "₹8000-₹12000"
    @State private var ageRange: String = "21-35"
    @State private var moveInDate: String = "Anytime"
    @State private var stayDuration: String = "6 Months"

    @State private var smoking: String = "Yes"
    @State private var cleaningHabits: String = "Moderate"
    @State private var guestVisits: String = "Frequently"
    @State private var morningHabits: String = "Early Bird"
    @State private var homeLifestyle: String = "Quiet"
    @State private var dealBreaker: String = "Disorganized"
    @State private var householdResponsibilities: String = "Flexible"
    @State private var rentSplitting: String = "Fixed"

    let stateOptions = ["Uttar Pradesh", "Delhi", "Maharashtra", "Karnataka"]
    let cityOptions = ["Greater Noida", "Noida", "Gurgaon", "Mumbai"]
    let budgetOptions = ["₹5000-₹8000", "₹8000-₹12000", "₹12000-₹20000", "₹20000+"]
    let ageOptions = ["18-25", "21-35", "25-40", "30-50"]
    let moveInOptions = ["Anytime", "This Month", "Next Month", "In 3 Months"]
    let stayOptions = ["3 Months", "6 Months", "1 Year", "2+ Years"]
    let smokingOptions = ["Yes", "No", "Occasionally"]
    let cleaningOptions = ["Neat Freak", "Moderate", "Relaxed"]
    let guestOptions = ["Never", "Rarely", "Occasionally", "Frequently"]
    let morningOptions = ["Early Bird", "Night Owl", "Flexible"]
    let lifestyleOptions = ["Quiet", "Active", "Social"]
    let dealBreakerOptions = ["Smoking", "Pets", "Disorganized", "Loud Music"]
    let householdOptions = ["Strict Rota", "Flexible", "Minimal"]
    let rentOptions = ["Fixed", "Split by Usage", "Negotiable"]

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
                Text("Preferences")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Circle().fill(Color.clear).frame(width: 36, height: 36)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    PrefSectionLabel(title: "Looking for")

                    HStack(spacing: 0) {
                        ForEach(LookingForTab.allCases, id: \.self) { tab in
                            Button(action: { lookingFor = tab }) {
                                Text(tab.rawValue)
                                    .font(.system(size: 14, weight: lookingFor == tab ? .semibold : .regular))
                                    .foregroundColor(lookingFor == tab ? .white : Color(.systemGray))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(lookingFor == tab ? Color.blue : Color.clear)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(3)
                    .background(Color(.systemGray5))
                    .cornerRadius(22)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    PrefSectionLabel(title: "Location Preferences")

                    VStack(spacing: 0) {
                        PrefPickerRow(label: "Preferred State", value: $preferredState, options: stateOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Preferred City", value: $preferredCity, options: cityOptions)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    PrefSectionLabel(title: "Search radius")

                    VStack(spacing: 8) {
                        Slider(value: $searchRadius, in: 0...20, step: 1)
                            .tint(.blue)
                            .padding(.horizontal, 4)

                        HStack {
                            ForEach(["5km", "10km", "20km", "25km", "30km"], id: \.self) { label in
                                Text(label)
                                    .font(.system(size: 11))
                                    .foregroundColor(Color(.systemGray))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    PrefSectionLabel(title: "Match Preferences")

                    VStack(spacing: 0) {
                        PrefPickerRow(label: "Budget", value: $budget, options: budgetOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Age Range", value: $ageRange, options: ageOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Move-in Date", value: $moveInDate, options: moveInOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Stay Duration", value: $stayDuration, options: stayOptions)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    PrefSectionLabel(title: "Your Quiz Data")

                    VStack(spacing: 0) {
                        PrefPickerRow(label: "Smoking", value: $smoking, options: smokingOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Cleaning Habits", value: $cleaningHabits, options: cleaningOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Guest Visits", value: $guestVisits, options: guestOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Morning Habits", value: $morningHabits, options: morningOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Home Lifestyle", value: $homeLifestyle, options: lifestyleOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Deal Breaker", value: $dealBreaker, options: dealBreakerOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Household Responsibilities", value: $householdResponsibilities, options: householdOptions)
                        Divider().padding(.leading, 16)
                        PrefPickerRow(label: "Rent Splitting", value: $rentSplitting, options: rentOptions)
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
                .padding(.top, 8)
            }
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }
}

struct PrefSectionLabel: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 13))
            .foregroundColor(Color(.systemGray))
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
    }
}

struct PrefPickerRow: View {
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
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 11))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .confirmationDialog("Select \(label)", isPresented: $showPicker, titleVisibility: .visible) {
            ForEach(options, id: \.self) { opt in
                Button(opt) { value = opt }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    PreferencesView(isPresented: .constant(true))
}
