# Teaching SimpleWx: one-session class outline

A ~75-minute session (fits 60–90) for students with **no Swift or SwiftUI experience**. You build the app up in four steps. Each step is a git tag, so you (or students) can jump straight to it and press Run.

| Time | Tag | Stage | New ideas | On screen |
| --- | --- | --- | --- | --- |
| 5 min | `main` | Intro | app, API, JSON | Finished app + raw JSON in a browser |
| 10 min | `step-1` | Hello, SwiftUI | `struct`, `View`, `body`, modifiers, `#Preview`, `@main` | A fixed "72.0 °F" |
| 15 min | `step-2` | State & loading | `@State`, optionals `?`, `if let`, `VStack`, `.task`, `specifier:` | Spinner, then a made-up 72.0 °F |
| 20 min | `step-3` | Real weather data | `URL` + `!`, `async`/`await`, `try`, `do`/`catch`, `Decodable` | The real current temperature |
| 15 min | `step-4` | When things go wrong | status codes, `as?`, showing errors | Red error message for bad input |
| 10–15 min | `step-4` | Hands-on | — | Students' own changes |

## Before class

- Open `SimpleWx.xcodeproj`, pick an iPhone simulator, and run the app once. The first build and simulator start are slow, so don't do them live.
- Open this in a browser tab, ready to show:
  https://api.open-meteo.com/v1/forecast?latitude=35.7915&longitude=-78.7811&current=temperature_2m&temperature_unit=fahrenheit
- In Xcode, turn on **Editor → Canvas** so the live preview is visible next to the code.

## Switching between steps

In Terminal, inside the project folder:

```
git checkout step-2      # jump to a step; then press Run (⌘R) in Xcode
git checkout main        # back to the finished app
```

Xcode reloads the files automatically. If git refuses because files were edited, `git checkout -f step-2` jumps anyway and **throws away those edits**.

No git? Students can download any step as a ZIP from https://github.com/flightblog/simplewx/tags.

---

## Intro (5 min) · `main`

- Run the finished app: "By the end of today, you'll understand every line that makes this work."
- Show the JSON in the browser. Point out `current` → `temperature_2m`: "This is all the app really does: ask a website for this text and show one number from it."
- Vocabulary: **app** (runs on the phone), **API** (a website made for programs, not people), **JSON** (the text format the API answers in).

## Step 1: Hello, SwiftUI (10 min) · `step-1`

Files: `SimpleWxApp.swift`, `ContentView.swift`

- `SimpleWxApp.swift`: `@main` is where the app starts, and it shows `ContentView`. Students rarely need to touch this file.
- `ContentView.swift`: a `struct` is a bundle of code with a name. `ContentView: View` means "this is a piece of screen".
- `body` is *what the screen looks like*. You describe it, and SwiftUI draws it.
- `.font(...)` is a **modifier**: it takes a view and returns a changed one.
- **Live demo:** in the canvas, change the text, size (`72`), or weight (`.thin` → `.bold`) and watch the preview update.
- Ask: *"How would we make the text red?"* (`.foregroundStyle(.red)`; they'll see it again in step 4.)

## Step 2: State & loading (15 min) · `step-2`

- The problem: a real app doesn't know the temperature when it opens. It has to *wait* for it.
- `@State var temperature: Double?`:
  - `@State` means "this value can change, and when it does, redraw the screen".
  - `?` means it might be **nil** (nothing yet). This is an *optional*.
- `if let temperature { … } else { … }`: "if we have a value, show it; otherwise show a spinner (`ProgressView`)."
- `VStack` stacks views vertically. Here it's the container for the if/else.
- `.task { … }` runs code when the view appears. It waits 2 seconds, then sets `temperature = 72.0`, and the screen updates by itself.
- `specifier: "%.1f"` means one decimal place.
- Ask: *"What happens if we change 72.0 to 50?"* Then *"What if we delete the `temperature = 72.0` line?"* (spinner forever).

## Step 3: Real weather data (20 min) · `step-3`

Files: new `Forecast.swift`; `ContentView.swift` changes

- **`Forecast.swift`**: put it side by side with the JSON in the browser. Each `struct` matches a `{ … }` in the JSON, and each property name matches a key *exactly*. That's why the names look odd (`temperature_2m`): they're the API's names.
- `Decodable` means "Swift can fill this in from JSON automatically."
- In `ContentView.swift`:
  - The state is now `forecast: Forecast?` instead of `temperature`, because real data has more than one field (the number *and* its unit).
  - `URL(string: "…")!`: the `!` says "I promise this is a valid address." Explain briefly that a wrong promise crashes the app.
  - `loadForecast()` is `async`: it can **wait** (`await`) for the network without freezing the app.
  - `try` marks lines that can fail. `do { … } catch { … }` means "try these steps; if any fails, jump to catch."
  - Walk through steps **1** (download) and **2** (decode JSON → `Forecast`) in the comments.
- Point out: when it fails, it only `print`s to Xcode's console and the spinner keeps spinning. "That's bad for users. Next step fixes it."

## Step 4: When things go wrong (15 min) · `step-4`

- New state: `errorMessage: String?`, and a third branch in `body` that shows it in red.
- **Status codes**: 200 means OK. Anything else means the server is telling us something went wrong. Mention 404 as a familiar one.
- `response as? HTTPURLResponse`: `as?` means "try to treat this as an HTTP response; if that doesn't work, skip."
- `APIError` in `Forecast.swift`: the API sends *different* JSON on errors (`"reason": …`). Show it in the browser by changing `latitude=` to `999` in the URL.
- **Live demo:** change `latitude=35.7915` to `latitude=999` in `ContentView.swift`, run, and the red message appears. Change it back.

## Hands-on (10–15 min) · `step-4` or `main`

Suggestions (also in the README under "Things to try"):

1. Show the temperature for your city (search "<city> latitude longitude").
2. Switch to Celsius: remove `&temperature_unit=fahrenheit`.
3. Style it: color, size, weight, or add a second `Text("Raleigh, NC")` inside the `VStack`.
4. Stretch: show wind speed too. In the URL, change `current=temperature_2m` to `current=temperature_2m,wind_speed_10m`. Then add `let wind_speed_10m: Double` to `Current` and show it with another `Text`. (To show its unit, add the same property to `Units` as a `String`.)

## If something goes wrong in class

- **API down or no Wi-Fi:** use `step-2`, which works offline with made-up data. At `step-4`, the failure itself becomes the demo: the app shows the reason, e.g. "The service is overloaded" (this happened while the app was being built).
- **Simulator stuck on a black screen:** it's still starting; wait a few seconds and press Run again.
- **Build errors after student edits:** `git checkout -f step-N` resets to a known-good step.
