import Foundation

class City {
    var id: Int
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var keywords = [String]()
    var locations = [Location]()
    
    
    init(id: Int, name: String, description: String, latitude: Double, longitude: Double, keywords: [String], locations: [Location]) {
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.keywords = keywords
        self.locations = locations
    }
}

class Location {
    var id: Int
    var type: String
    var name: String
    var rating: Int

    init(id: Int, type: String, name: String, rating: Int) {
        self.id = id
        self.type = type
        self.name = name
        self.rating = rating
    }
}

// Search

func searchCitiesByName(_ name: String) -> [City] {
    var foundCities = [City]()
    
    for city in cities {
        if city.name == name {
            foundCities.append(city)
        }
    }
    
    return foundCities
}

func searchCitiesByKeyword(_ keyword: String) -> [City] {
    var foundCities = [City]()
    
    for city in cities {
        for kw in city.keywords {
            if kw == keyword {
                foundCities.append(city)
                break
            }
        }
    }
    
    return foundCities
}

// Distance

func calculateDistance(_ city1: City, _ city2: City) -> Double {
    
    let R:Double = 6371
    let latitudeRad1 = city1.latitude * Double.pi / 180
    let latitudeRad2 = city2.latitude * Double.pi / 180
    let longitudeRad1 = city1.longitude * Double.pi / 180
    let longitudeRad2 = city2.longitude * Double.pi / 180
    
    let latitudeDifference = latitudeRad1 - latitudeRad2
    let longitudeDifference = longitudeRad1 - longitudeRad2
    
    var distance = pow(sin(latitudeDifference / 2), 2) + cos(latitudeRad1) * cos(latitudeRad2) * pow(sin(longitudeDifference / 2), 2)

    distance = 2 * asin(sqrt(distance))
    distance = distance * R
    
    return distance
}

func displayClosestAndFarthestCity(_ userLatitude: Double, _ userLongitude: Double) {
    let tmp = City(id: 0, name: "tmp", description: "", latitude: userLatitude, longitude: userLongitude, keywords: [], locations: [])
    var minDistance:Double = -1
    var maxDistance:Double = -1
    var closestCity:City = cities[0]
    var farthestCity:City = cities[0]
    
    for city in cities {
        let distance = calculateDistance(city, tmp)
        if distance > maxDistance || maxDistance == -1 {
            farthestCity = city
            maxDistance = distance
        }
        if distance < minDistance || minDistance == -1 {
            closestCity = city
            minDistance = distance
        }
    }
    
    print("The closest city is: " + closestCity.name)
    print("The farthest city is: " + farthestCity.name)
    
}

func displayTwoFarthestCities() {
    var maxDistance:Double = 0
    var farthestCity1 = cities[0]
    var farthestCity2 = cities[0]
    
    for city1 in cities {
        for city2 in cities {
            let distance = calculateDistance(city1, city2)
            
            if distance > maxDistance {
                farthestCity1 = city1
                farthestCity2 = city2
                maxDistance = distance
            }
        }
    }
    
    print("Two farthest cities are: " + farthestCity1.name + " and " + farthestCity2.name)
}


// Advance search

func displayCitiesWith5StarRatingRestaurants() {
    var foundCities = [String]()
    
    for city in cities {
        for location in city.locations {
            if location.type == "Restaurant" && location.rating == 5 {
                foundCities.append(city.name)
            }
        }
    }
    
    print("Cities with 5 star rating restaurants: \(foundCities)")

}

func getRelatedLocationsSortedByRating(_ city: City) -> Array<Location> {
    return city.locations.sorted(by: {$0.rating > $1.rating})
}

func displayCitiesAndLocationsWith5StarRating() {
    for city in cities {
        let locations5Star = city.locations.filter{$0.rating == 5}
        print("\(city.name) has \(locations5Star.count) locations with 5 star rating.")
        if locations5Star.count > 0 {
            print("\tThese locations are: \(locations5Star.map{$0.type + " `" + $0.name + "`"})")
        }
    }
}

var cities = [City]()
cities.append(City(id: 1, name: "Warsaw", description: "The city located in Poland", latitude: 52.23, longitude: 21.01, keywords: ["party", "sport"], locations: [Location(id: 1, type: "Restaurant", name: "Appetite", rating: 5), Location(id: 42, type: "Pub", name: "Anytime", rating: 4)]))
cities.append(City(id: 2, name: "New York", description: "The city located in United States", latitude: 40.71, longitude: -74.01, keywords: ["sport", "dance"], locations: [Location(id: 2, type: "Restaurant", name: "Grill", rating: 4)]))
cities.append(City(id: 3, name: "Tokyo", description: "The city located in Japan", latitude: 35.68, longitude: 139.76, keywords: ["dance"], locations: [Location(id: 3, type: "Museum", name: "Etnographic", rating: 5), Location(id: 4, type: "Restaurant", name: "Traditional", rating: 5)]))
cities.append(City(id: 4, name: "Mexico", description: "The city located in North America", latitude: 23.66, longitude: -102.01, keywords: ["party"], locations: [Location(id: 5, type: "Museum", name: "Regional", rating: 5), Location(id: 6, type: "Pub", name: "Rolls", rating: 4)]))
cities.append(City(id: 5, name: "Paris", description: "The city located in France", latitude: 48.86, longitude: 2.32, keywords: ["dance", "music"], locations: [Location(id: 7, type: "Pub", name: "Spicy", rating: 5), Location(id: 8, type: "Museum", name: "Historic", rating: 5), Location(id: 9, type: "Restaurant", name: "Dragon", rating: 5)]))
cities.append(City(id: 6, name: "Dubai", description: "The city located in United Arab Emirates", latitude: 25.27, longitude: 55.29, keywords: ["music", "seaside"], locations: [Location(id: 10, type: "Restaurant", name: "Sensation", rating: 4), Location(id: 11, type: "Museum", name: "Zoological", rating: 5)]))
cities.append(City(id: 7, name: "Singapore", description: "The city located in Singapore", latitude: 1.36, longitude: 103.82, keywords: ["music", "sport", "seaside"], locations: [Location(id: 12, type: "Pub", name: "Flavor", rating: 5), Location(id: 13, type: "Restaurant", name: "Fresh", rating: 4), Location(id: 14, type: "Cafe", name: "Drink", rating: 4)]))
cities.append(City(id: 8, name: "Rome", description: "The city located in Italy", latitude: 41.89, longitude: 12.48, keywords: ["party", "music"], locations: [Location(id: 15, type: "Cafe", name: "Warm", rating: 2), Location(id: 16, type: "Pub", name: "Classics", rating: 3), Location(id: 17, type: "Restaurant", name: "Tasty", rating: 3)]))
cities.append(City(id: 9, name: "Porto", description: "The city located in Portugal", latitude: 41.15, longitude: -8.61, keywords: ["party", "music"], locations: [Location(id: 18, type: "Museum", name: "National", rating: 4), Location(id: 43, type: "Restaurant", name: "Superior", rating: 4)]))
cities.append(City(id: 10, name: "Chicago", description: "The city located in United States", latitude: 41.88, longitude: -87.62, keywords: ["party"], locations: [Location(id: 19, type: "Museum", name: "Natural", rating: 3), Location(id: 20, type: "Cafe", name: "Morning", rating: 4), Location(id: 21, type: "Restaurant", name: "Hungry", rating: 2)]))
cities.append(City(id: 11, name: "Barcelona", description: "The city located in Spain", latitude: 41.38, longitude: 2.18, keywords: ["music", "sport", "dance"], locations: [Location(id: 22, type: "Pub", name: "Stack", rating: 3), Location(id: 23, type: "Museum", name: "Anthropology", rating: 5)]))
cities.append(City(id: 12, name: "Amsterdam", description: "The city located in Netherlands", latitude: 52.37, longitude: 4.89, keywords: ["party"], locations: [Location(id: 24, type: "Restaurant", name: "Red", rating: 2), Location(id: 25, type: "Museum", name: "Dinosaurs", rating: 5), Location(id: 26, type: "Pub", name: "After", rating: 2)]))
cities.append(City(id: 13, name: "Madrid", description: "The city located in Spain", latitude: 40.42, longitude: -3.7, keywords: ["sport", "seaside", "nature"], locations: [Location(id: 27, type: "Cafe", name: "Pause", rating: 5), Location(id: 28, type: "Museum", name: "Art", rating: 5)]))
cities.append(City(id: 14, name: "Sydney", description: "The city located in Australia", latitude: -33.85, longitude: 151.22, keywords: ["sport", "dance", "party"], locations: [Location(id: 29, type: "Pub", name: "Hot", rating: 4), Location(id: 45, type: "Cafe", name: "Aroma", rating: 5)]))
cities.append(City(id: 15, name: "Florence", description: "The city located in Italy", latitude: 43.77, longitude: 11.26, keywords: ["dance", "nature", "music"], locations: [Location(id: 30, type: "Cafe", name: "Essence", rating: 5), Location(id: 31, type: "Museum", name: "Military", rating: 1), Location(id: 32, type: "Restaurant", name: "Lion", rating: 3)]))
cities.append(City(id: 16, name: "Prague", description: "The city located in Czech Republic", latitude: 50.09, longitude: 14.42, keywords: ["music", "sport"], locations: [Location(id: 33, type: "Pub", name: "Smoke", rating: 2), Location(id: 44, type: "Cafe", name: "Chocolate", rating: 3)]))
cities.append(City(id: 17, name: "Athens", description: "The city located in Greece", latitude: 37.98, longitude: 23.73, keywords: ["dance", "music"], locations: [Location(id: 34, type: "Restaurant", name: "Crispy", rating: 4), Location(id: 35, type: "Pub", name: "Bang", rating: 5), Location(id: 36, type: "Cafe", name: "Snack", rating: 1)]))
cities.append(City(id: 18, name: "Venice", description: "The city located in Italy", latitude: 45.44, longitude: 12.33, keywords: ["seaside", "nature"], locations: [Location(id: 37, type: "Pub", name: "Fine", rating: 1), Location(id: 38, type: "Restaurant", name: "Yummy", rating: 1)]))
cities.append(City(id: 19, name: "Bangkok", description: "The city located in Thailand", latitude: 13.75, longitude: 100.49, keywords: ["music", "seaside"], locations: [Location(id: 39, type: "Restaurant", name: "Central", rating: 2)]))
cities.append(City(id: 20, name: "Istanbul", description: "The city located in Turkey", latitude: 41.01, longitude: 28.97, keywords: ["party", "music"], locations: [Location(id: 40, type: "Pub", name: "Fiesta", rating: 2), Location(id: 41, type: "Cafe", name: "Delicious", rating: 4)]))

// Tests
let byNameResult = searchCitiesByName("Tokyo")
print("Found \(byNameResult.count) city(ies) with name Tokyo:")
for city in byNameResult {
  print("\(city.name), description: \(city.description)")
}

let byKeywordResult = searchCitiesByKeyword("nature")
print("\nFound \(byKeywordResult.count) city(ies) with keyword nature:")
for city in byKeywordResult {
  print("\(city.name)")
}

print("\nDistance in kilometers between Paris and Barcelona:")
print(calculateDistance(searchCitiesByName("Paris")[0], searchCitiesByName("Barcelona")[0]))

print("\nClosest and farthest city from Gdansk(54.21, 18.38):")
displayClosestAndFarthestCity(54.21, 18.38)

print("\nTwo farthest cities from array:")
displayTwoFarthestCities()

print("\nList of cities which have restaurants with 5 star rating:")
displayCitiesWith5StarRatingRestaurants()

print("\nList of locations in Chicago sorted by rating:")
let sortedLocations = getRelatedLocationsSortedByRating(searchCitiesByName("Chicago")[0])
for location in sortedLocations {
  print("\(location.type) `\(location.name)`, rating: \(location.rating)")
}

print("\nAll cities from array with information how many location with 5 star rating they have:")
displayCitiesAndLocationsWith5StarRating()
