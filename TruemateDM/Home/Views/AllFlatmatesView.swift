import SwiftUI

struct AllFlatmatesView: View {
    @Binding var isPresented: Bool
    @State private var selectedTab: FlatmateTab = .recommended
    @State private var selectedProfile: FlatmateProfile? = nil
    @State private var showProfilePage = false
    @State private var showFilterOptions = false
    @State private var selectedSort: FlatmateSortOption = .highestBudget

    @State private var flatmates = Flatmate.sample

    enum FlatmateTab { case recommended, saved }

    var displayedFlatmates: [Flatmate] {
        if selectedTab == .recommended {
            return flatmates
        } else {
            return flatmates.filter { $0.isSaved }
        }
    }

     

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    HStack {
                    Button(action: { isPresented = false }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 38, height: 38)
                                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                    }

                        Spacer()

                        Text("All flatmates")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)

                        Spacer()

                        Button(action: { showFilterOptions = true }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 38, height: 38)
                                    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                                Image(systemName: "line.3.horizontal")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    HStack(spacing: 0) {
                        SegmentButton(title: "Recommended flatmates", isSelected: selectedTab == .recommended) {
                            selectedTab = .recommended
                        }
                        SegmentButton(title: "Saved flatmates", isSelected: selectedTab == .saved) {
                            selectedTab = .saved
                        }
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(30)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(displayedFlatmates, id: \.id) { flatmate in
                                FlatmateDetailCard(
                                flatmate: flatmate,
                                onTapCard: {
                                    selectedProfile = FlatmateProfile.from(name: flatmate.name)
                                    showProfilePage = true
                                },
                                onToggleSave: {
                                    if let i = flatmates.firstIndex(where: { $0.id == flatmate.id }) {
                                            flatmates[i].isSaved.toggle()
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }

                }
                .background(Color(.systemGray6))
                
                if let profile = selectedProfile {
                    NavigationLink(
                        destination: FlatmateProfileView(
                            profile: profile,
                            useBackButton: true
                        ),
                        isActive: $showProfilePage
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }

                if showFilterOptions {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture { showFilterOptions = false }

                    VStack(spacing: 0) {
                        ForEach(FlatmateSortOption.allCases.indices, id: \.self) { index in
                            let option = FlatmateSortOption.allCases[index]
                            filterRow(option)
                            if index < FlatmateSortOption.allCases.count - 1 {
                                Divider().padding(.leading, 56)
                            }
                        }
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(Color.white.opacity(0.45), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.12), radius: 14, x: 0, y: 8)
                    .frame(width: 290)
                    .padding(.top, 72)
                    .padding(.trailing, 18)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func filterRow(_ option: FlatmateSortOption) -> some View {
        Button {
            selectedSort = option
            showFilterOptions = false
        } label: {
            HStack(spacing: 12) {
                Image(systemName: selectedSort == option ? "checkmark" : "")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 20)
                Text(option.title)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct SegmentButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : Color(.systemGray))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(30)
        }
    }
}

struct FlatmateDetailCard: View {
    let flatmate: Flatmate
    let onTapCard: () -> Void
    let onToggleSave: () -> Void

    var matchColor: Color {
        flatmate.matchPercent >= 70 ? Color.green : Color(.systemGray)
    }
    var matchBgColor: Color {
        flatmate.matchPercent >= 70 ? Color.green.opacity(0.12) : Color(.systemGray5)
    }

    var body: some View {
        Button(action: onTapCard) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray5))
                            .frame(width: 80, height: 88)
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(.systemGray3))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Text(flatmate.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                            if flatmate.isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                            }
                        }

                        Text(flatmate.lookingFor)
                            .font(.system(size: 13))
                            .foregroundColor(Color(.systemGray))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 8) {
                        Text("\(flatmate.matchPercent)% Match")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(matchColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(matchBgColor)
                            .cornerRadius(20)

                        Button(action: onToggleSave) {
                            ZStack {
                                Circle()
                                    .fill(flatmate.isSaved ? Color.red.opacity(0.15) : Color(.systemGray5))
                                    .frame(width: 32, height: 32)
                                Image(systemName: flatmate.isSaved ? "heart.fill" : "heart")
                                    .font(.system(size: 14))
                                    .foregroundColor(flatmate.isSaved ? .red : Color(.systemGray))
                            }
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 12)

                Divider()
                    .padding(.horizontal, 14)

                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 11))
                            .foregroundColor(Color(.systemGray))
                        Text(flatmate.location)
                            .font(.system(size: 13))
                            .foregroundColor(Color(.systemGray))
                    }
                    Spacer()
                    Text("₹\(flatmate.pricePerMonth)/month")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
            .background(Color.white)
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AllFlatmatesView(isPresented: .constant(true))
}
