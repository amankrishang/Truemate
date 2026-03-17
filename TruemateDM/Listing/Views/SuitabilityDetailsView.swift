import SwiftUI

struct SuitabilityDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    var listing: FlatmateListing

    private let accentColor = Color(red: 0.34, green: 0.20, blue: 0.78)

    private var breakdownItems: [(String, String, Int, String)] {
        [
            ("sparkles", "Cleanliness", cleanlinessScore, "\(listing.cleanlinessLevel)/5"),
            ("moon.fill", "Sleep Schedule", sleepScore, listing.sleepSchedule.capitalized),
            ("nosign", "Smoking", smokingScore, listing.smokingPreference.capitalized),
            ("leaf.fill", "Food Preference", foodScore, listing.foodPreference.capitalized),
            ("person.2.fill", "Guest Frequency", guestScore, listing.guestFrequency.capitalized),
            ("speaker.wave.2.fill", "Noise Level", noiseScore, listing.noiseLevel.capitalized)
        ]
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Overall Score
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .stroke(Color(.systemGray5), lineWidth: 10)
                            .frame(width: 120, height: 120)
                        Circle()
                            .trim(from: 0, to: CGFloat(listing.suitabilityScore) / 100)
                            .stroke(suitabilityColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(-90))
                        VStack(spacing: 2) {
                            Text("\(listing.suitabilityScore)%")
                                .font(.system(size: 32, weight: .bold))
                            Text("Match")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                    }

                    Text("Suitability Score")
                        .font(.system(size: 18, weight: .semibold))
                    Text("Based on your lifestyle preferences")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 8)

                Divider()
                    .padding(.horizontal, 20)

                // Breakdown
                VStack(spacing: 16) {
                    ForEach(breakdownItems, id: \.0) { item in
                        breakdownRow(icon: item.0, title: item.1, score: item.2, detail: item.3)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
        }
        .navigationTitle("Suitability Breakdown")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
                    .foregroundColor(accentColor)
            }
        }
    }

    private func breakdownRow(icon: String, title: String, score: Int, detail: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(accentColor)
                .frame(width: 36, height: 36)
                .background(accentColor.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.system(size: 15, weight: .medium))
                    Spacer()
                    Text(detail)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemGray5))
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(barColor(for: score))
                            .frame(width: geometry.size.width * CGFloat(score) / 100, height: 6)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(14)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private func barColor(for score: Int) -> Color {
        if score >= 80 { return .green }
        if score >= 60 { return .orange }
        return .red
    }

    private var suitabilityColor: Color {
        if listing.suitabilityScore >= 80 { return Color.green }
        if listing.suitabilityScore >= 60 { return Color.orange }
        return Color.red
    }

    // Dummy scoring logic
    private var cleanlinessScore: Int { min(listing.cleanlinessLevel * 20, 100) }
    private var sleepScore: Int { listing.sleepSchedule == "moderate" ? 85 : 65 }
    private var smokingScore: Int { listing.smokingPreference == "no" ? 100 : 40 }
    private var foodScore: Int { listing.foodPreference == "any" ? 90 : 70 }
    private var guestScore: Int { listing.guestFrequency == "sometimes" ? 80 : 60 }
    private var noiseScore: Int { listing.noiseLevel == "quiet" ? 90 : listing.noiseLevel == "moderate" ? 70 : 50 }
}
