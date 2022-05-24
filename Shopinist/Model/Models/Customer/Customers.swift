// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let customers = try? newJSONDecoder().decode(Customers.self, from: jsonData)

import Foundation

// MARK: - Customers
struct Customers: Codable {
    var customers: [Customer]?
}
