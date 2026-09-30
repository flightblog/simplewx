import SwiftUI

// A View is one piece of the screen. This app has just one.
struct ContentView: View {

    // @State variables hold data that can change.
    // Whenever one changes, SwiftUI redraws the screen automatically.
    // The "?" means the value might be missing (nil) — e.g. before the download finishes.
    @State private var forecast: Forecast?

    // The web address we ask for weather. Try changing the latitude/longitude!
    // URL(string:) returns an optional, because not every string is a valid address.
    // The "!" at the end says "I'm sure this is valid — unwrap it." (If it weren't, the app would crash.)
    let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=35.7915&longitude=-78.7811&current=temperature_2m&temperature_unit=fahrenheit")!

    // "body" describes what appears on screen.
    var body: some View {
        VStack {
            if let forecast {
                // We have the weather: show the temperature and its unit.
                let temperature = forecast.current.temperature_2m
                let unit = forecast.current_units.temperature_2m
                // specifier: "%.1f" formats the number with 1 digit after the decimal point (74.23 → "74.2").
                Text("\(temperature, specifier: "%.1f") \(unit)")
                    .font(.system(size: 72, weight: .thin))
            } else {
                // Still waiting: show a spinning loading indicator.
                ProgressView()
            }
        }
        // .task runs once when the view first appears on screen.
        .task {
            await loadForecast()
        }
    }

    // Downloads the weather from the internet.
    // "async" means it can wait for the network without freezing the app.
    func loadForecast() async {
        do {
            // 1. Ask the server for the data and wait ("await") for the reply.
            let (data, _) = try await URLSession.shared.data(from: url)

            // 2. Turn the JSON into our Forecast struct. Setting it redraws the screen.
            forecast = try JSONDecoder().decode(Forecast.self, from: data)
        } catch {
            // Any "try" above that fails jumps here (for example: no internet).
            // For now we only print the error to Xcode's console — the screen keeps spinning.
            print(error)
        }
    }
}

// Shows a live preview in Xcode's canvas while editing.
#Preview {
    ContentView()
}
