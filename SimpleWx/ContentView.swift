import SwiftUI

// A View is one piece of the screen. This app has just one.
struct ContentView: View {

    // @State variables hold data that can change.
    // Whenever one changes, SwiftUI redraws the screen automatically.
    // The "?" means the value might be missing (nil) — here, until we "load" it.
    @State private var temperature: Double?

    // "body" describes what appears on screen.
    var body: some View {
        VStack {
            if let temperature {
                // We have a temperature: show it.
                // specifier: "%.1f" formats the number with 1 digit after the decimal point (74.23 → "74.2").
                Text("\(temperature, specifier: "%.1f") °F")
                    .font(.system(size: 72, weight: .thin))
            } else {
                // Still waiting: show a spinning loading indicator.
                ProgressView()
            }
        }
        // .task runs once when the view first appears on screen.
        .task {
            // Pretend to load: wait 2 seconds, then set a made-up temperature.
            // (We'll get a real one from the internet in the next step.)
            try? await Task.sleep(for: .seconds(2))
            temperature = 72.0
        }
    }
}

// Shows a live preview in Xcode's canvas while editing.
#Preview {
    ContentView()
}
