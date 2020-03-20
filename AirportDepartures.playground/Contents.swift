import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case enRoute = "En Route"
    case scheduled = "Scheduled"
    case canceled = "Canceled"
    case delayed = "Delayed"
    case boarding = "Boarding"
    case landed = "Landed"
}

struct Airport {
    let name: String
    let location: String
}

struct Flight {
    var departureTime: Date?
    var terminal: String?
    var destination: String
    var status: FlightStatus
}

class DepartureBoard {
    var flights: [Flight]
    
    init(flights: [Flight]) {
        self.flights = []
    }
    
    func add(flight: Flight) {
        flights.append(flight)
    }
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let PDXtoORD = Flight(departureTime: nil, terminal: "6", destination: "Chicago", status: .canceled)
let ORDtoNYC = Flight(departureTime: Date(), terminal: nil, destination: "New York City", status: .scheduled)
let NYCtoPDX = Flight(departureTime: Date(), terminal: "3", destination: "Portland", status: .scheduled)

let departures = DepartureBoard(flights: [])

departures.flights.append(PDXtoORD)
departures.flights.append(ORDtoNYC)
departures.flights.append(NYCtoPDX)

//departures.flights[0].status = .landed
//print(departures.flights[0].status)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    let array = departureBoard.flights
    
    for flight in array {
        print("Destination: \(flight.destination) Depature Time: \(String(describing: flight.departureTime)) Terminal: \(String(describing: flight.terminal)) Status: \(flight.status)")
    }
}

//printDepartures(departureBoard: departures)
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
//func printDepartures2(departureBoard: DepartureBoard) {
//    let array = departureBoard.flights
//
//    for flight in array {
//        if let timeOfDeparture = flight.departureTime {
//            if let terminalNumber = flight.terminal {
//                print("Destination: \(flight.destination) Departure Time: \(timeOfDeparture) Terminal: \(terminalNumber)) Status: \(flight.status)")
//            } else {
//                print("Destination: \(flight.destination) Departure Time: \(timeOfDeparture) Terminal: \(" ") Status: \(flight.status)")
//            }
//        } else {
//            if let terminalNumber = flight.terminal {
//                print("Destination: \(flight.destination) Departure Time: \(" ")) Terminal: \(terminalNumber) Status: \(flight.status)")
//            } else {
//                print("Destination: \(flight.destination) Departure Time: \(" ") Terminal: \(" ") Status: \(flight.status)")
//            }
//        }
//    }
//}

func printDepartures2(_ departureBoard: DepartureBoard) {
    let flights = departureBoard.flights
    
    for flight in flights {
        let destination = flight.destination
        let terminal = flight.terminal ?? " "
        let status = flight.status
        let departureTime = flight.departureTime?.description ?? " "
        
        print("Destination: \(destination) Departure Time: \(departureTime) Terminal: \(terminal) Status: \(status)")
    }
}

printDepartures2(departures)
//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
func alertPassengers() {
    for flight in departures {
        
        var timeString = "TBD"
        if let time = flight.departureTime {
            timeString = "\(time)"
        }
        
        var terminalString = "TBD"
        if let terminal = flight.terminal {
            terminalString = terminal
        }
    }
}


