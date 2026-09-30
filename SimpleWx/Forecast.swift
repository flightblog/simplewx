import Foundation

// These structs describe the shape of the JSON the weather API sends back.
// "Decodable" lets Swift turn that JSON into these structs automatically.
// Each property name must match a key in the JSON exactly.
//
// The API's JSON looks like this (trimmed):
// {
//   "current_units": { "temperature_2m": "°F" },
//   "current":       { "temperature_2m": 74.2 }
// }

struct Forecast: Decodable {
    let current: Current
    let current_units: Units
}

struct Current: Decodable {
    let temperature_2m: Double   // a number, like 74.2
}

struct Units: Decodable {
    let temperature_2m: String   // a label, like "°F"
}
