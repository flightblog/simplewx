import SwiftUI

// A View is one piece of the screen. This app has just one.
struct ContentView: View {

    // "body" describes what appears on screen.
    var body: some View {
        // Text shows words on screen.
        // .font is a "modifier": it changes how the Text looks.
        Text("72.0 °F")
            .font(.system(size: 72, weight: .thin))
    }
}

// Shows a live preview in Xcode's canvas while editing.
#Preview {
    ContentView()
}
