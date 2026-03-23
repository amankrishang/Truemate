import SwiftUI

struct TrueMateOnboardingView: View {
    var onGetStarted: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .ignoresSafeArea()

            VStack {
                TrueMateLogoView()
                    .padding(.top, 80)
                Spacer()
            }

            BottomCardView(
                onGetStarted: { onGetStarted?() }
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TrueMateLogoView: View {
    var body: some View {
        Image("Truemate logo")
            .resizable()
            .scaledToFit()
            .frame(width: 280, height: 165)
            .scaleEffect(1.4)
    }
}

struct PersonIconView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                Circle()
                    .frame(width: w * 0.45, height: w * 0.45)
                    .offset(x: 0, y: -h * 0.18)

                RoundedRectangle(cornerRadius: w * 0.25)
                    .frame(width: w * 0.75, height: h * 0.52)
                    .offset(x: 0, y: h * 0.2)
            }
            .frame(width: w, height: h)
            .position(x: w / 2, y: h / 2)
        }
    }
}

struct BottomCardView: View {
    var onGetStarted: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Tell me your vibe and I'll match the tone")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 36)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)

            Text("This short quiz helps us generate your suitability score and match you more accurately.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color.white.opacity(0.75))
                .lineSpacing(4)
                .padding(.horizontal, 24)

            Spacer()

            HStack {
                Spacer()

                Button(action: onGetStarted) {
                    Text("Get Started")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.55)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(red: 0.22, green: 0.42, blue: 0.98))
        )
    }
}

#Preview {
    TrueMateOnboardingView()
}
