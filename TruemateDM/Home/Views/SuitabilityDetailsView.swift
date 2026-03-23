import SwiftUI

struct SuitabilityDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    var onBack: (() -> Void)? = nil
    var useBackButton: Bool = false

    let matchName: String = "Abhishek"

    let potentialMatches = SuitabilityDetailsData.potentialMatches
    let potentialMismatches = SuitabilityDetailsData.potentialMismatches

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGray6)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Button(action: { closeScreen() }) {
                                ZStack {
                                    Circle()
                                        .fill(Color(.systemGray5))
                                        .frame(width: 36, height: 36)
                                    Image(systemName: useBackButton ? "chevron.left" : "xmark")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.primary)
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)

                        VStack(spacing: 8) {
                            Text("Suitability Details")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)

                            Text("How well you and \(matchName) aligns as flatmates")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.systemGray))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)

                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.green)
                            Text("Potential Matches")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                        VStack(spacing: 0) {
                            ForEach(potentialMatches.indices, id: \.self) { index in
                                let item = potentialMatches[index]
                                Text(item)
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 18)

                                if index < potentialMatches.count - 1 {
                                    Divider()
                                        .padding(.horizontal, 18)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 28)

                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.orange)
                            Text("Potential Mismatches")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.orange)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                        VStack(spacing: 0) {
                            ForEach(potentialMismatches.indices, id: \.self) { index in
                                let item = potentialMismatches[index]
                                Text(item)
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 18)

                                if index < potentialMismatches.count - 1 {
                                    Divider()
                                        .padding(.horizontal, 18)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(24)
                    .padding(.top, 16)
                }
                .padding(.horizontal, 0)
            }
        }
        .navigationBarHidden(true)
    }

    private func closeScreen() {
        if let onBack {
            onBack()
        } else {
            dismiss()
        }
    }
}

#Preview {
    SuitabilityDetailsView()
}
