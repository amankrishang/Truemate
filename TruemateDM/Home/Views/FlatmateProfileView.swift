import SwiftUI

struct FlatmateProfileView: View {
    let onClose: () -> Void

    @State private var showSuitabilityDetailsPage = false
    @State private var isSaved = false

    let profile: FlatmateProfile

    init(profile: FlatmateProfile, onClose: @escaping () -> Void) {
        self.profile = profile
        self.onClose = onClose
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Button(action: closeScreen) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 38, height: 38)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                    Spacer()
                    Button(action: { isSaved.toggle() }) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 42, height: 42)
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 20)

                ZStack {
                    Circle()
                        .fill(Color(red: 0.98, green: 0.92, blue: 0.84))
                        .frame(width: 110, height: 110)
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(.systemGray3))
                }
                .padding(.bottom, 14)

                HStack(spacing: 6) {
                    Text(profile.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.primary)
                    if profile.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 16)

                Button(action: {
                    NotificationCenter.default.post(
                        name: .didSendMessageRequest,
                        object: nil,
                        userInfo: ["name": profile.name]
                    )
                    closeScreen()
                }) {
                    Text("Send Message Request")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 18)

                VStack(alignment: .leading, spacing: 10) {
                    Text("These matches between you and \(profile.name.components(separatedBy: " ").first ?? profile.name)")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                        .padding(.horizontal, 16)

                    HStack(spacing: 10) {
                        ForEach(profile.matchTags) { tag in
                            HStack(spacing: 6) {
                                Image(systemName: tag.icon)
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)
                                Text(tag.label)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)

                Button(action: { showSuitabilityDetailsPage = true }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(profile.suitabilityPercent)%  Suitability")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.primary)
                            Text("Based on habits and preferences")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.systemGray))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(.systemGray))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(14)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Basic Info")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(.systemGray))
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)

                    VStack(spacing: 0) {
                        BasicInfoRow(label: "Gender", value: profile.gender)
                        Divider().padding(.horizontal, 16)
                        BasicInfoRow(label: "Flat Type", value: profile.flatType)
                        Divider().padding(.horizontal, 16)
                        BasicInfoRow(label: "Looking for", value: profile.lookingFor)
                        Divider().padding(.horizontal, 16)
                        BasicInfoRow(label: "Flat Rent", value: "₹\(profile.flatRent)/month")
                        Divider().padding(.horizontal, 16)
                        BasicInfoRow(label: "Age", value: "\(profile.age)")
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 32)
            }

        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showSuitabilityDetailsPage) {
            SuitabilityDetailsView(matchName: profile.name, useBackButton: true)
        }
        .onAppear {
            isSaved = profile.isSaved
        }
    }

    private func closeScreen() {
        onClose()
    }
}

struct BasicInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemGray))
            Spacer()
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
    }
}
