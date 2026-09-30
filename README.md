# SimpleWx

A tiny iPhone app that shows the current temperature. It's built with Swift and SwiftUI and is meant as a first look at iOS development — no prior Swift experience needed.

When the app opens, it downloads the current temperature for Raleigh, NC from the free [Open-Meteo](https://open-meteo.com/) weather API and shows it in big numbers on the screen.

## What you need

- A Mac with **Xcode 16 or later** (free from the Mac App Store)
- No accounts or API keys: Open-Meteo is free to use

## Run it

1. Download the code:

   ```
   git clone https://github.com/flightblog/simplewx.git
   ```

   (Or click the green **Code** button on GitHub → **Download ZIP**.)

2. Open `SimpleWx.xcodeproj` in Xcode (double-click it).
3. At the top of the Xcode window, pick any iPhone simulator from the device menu.
4. Press the **▶ Run** button (or ⌘R).

The simulator starts, a loading spinner appears for a moment, and then the temperature shows up.

## How the code is organized

All the code is in the `SimpleWx` folder, and every file has comments explaining each step.

| File | What it does |
| --- | --- |
| `SimpleWxApp.swift` | Where the app starts. Opens a window that shows `ContentView`. |
| `ContentView.swift` | The screen. Downloads the weather and shows the temperature, a loading spinner, or an error message. |
| `Forecast.swift` | Describes the shape of the weather data (JSON) so Swift can read it. |

Start with `ContentView.swift`; it's where most of the action is.

## Things to try

- **Your own city:** in `ContentView.swift`, change `latitude=` and `longitude=` in the URL. You can find a city's coordinates by searching "<city name> latitude longitude".
- **Celsius:** remove `&temperature_unit=fahrenheit` from the URL.
- **Bigger or bolder text:** change `size: 72` or `weight: .thin` (try `.bold`).
- **See an error:** set `latitude=999` and run the app. The API rejects the invalid latitude, and the app shows its message in red.
- **Live preview:** in Xcode, open `ContentView.swift` and choose **Editor → Canvas** to see the screen update as you type.

## For maintainers

The Xcode project is generated from `project.yml` with [XcodeGen](https://github.com/yonaskolb/XcodeGen). After adding or removing files, run `xcodegen generate`. The generated project is committed so students don't need XcodeGen installed.
