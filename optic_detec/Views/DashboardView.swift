import SwiftUI

// improvised with GPT


struct DashboardView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .font(.system(size: 48))
                .foregroundStyle(.blue)
            Text("Dashboard / Cámara")
                .font(.title2)
                .bold()
            Text("Esta es una vista temporal. Reemplázala con tu implementación de cámara o panel.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationTitle("Conducción")
    }
}

#Preview {
    NavigationStack { DashboardView() }
}
