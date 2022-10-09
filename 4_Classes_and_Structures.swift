import Foundation

enum Reaction: String {
    case 👍 = "Like"
    case 💗 = "Love"
    case 😆 = "Haha"
    case 😮 = "Wow"
    case 😢 = "Sad"
    case 😡 = "Angry"
}

class Post {
    var id: Int
    var type: String{"Post"}
    var description: String
    var dateOfPublication: String
    var statistics: Statistics
    var reactions = [Reaction: Int]()
    
    init (id: Int, description: String, dateOfPublication: String, statistics: Statistics, reactions: [Reaction: Int]) {
        self.id = id
        self.description = description
        self.dateOfPublication = dateOfPublication
        self.statistics = statistics
        self.reactions = reactions
    }
}

class Image: Post {
    override var type: String{"Image"}
    var width: Double
    var height: Double
    var location: String
    
    init (id: Int, description: String, dateOfPublication: String, statistics: Statistics, reactions: [Reaction: Int], width: Double, height: Double, location: String) {
        self.width = width
        self.height = height
        self.location = location
        super.init (id: id, description: description, dateOfPublication: dateOfPublication, statistics: statistics, reactions: reactions)
    }
    
}

class Video: Post {
    override var type: String{"Video"}
    var length: Double
    var numberOfViews: Int
        
    init (id: Int, description: String, dateOfPublication: String, statistics: Statistics, reactions: [Reaction: Int], length: Double, numberOfViews: Int) {
        self.length = length
        self.numberOfViews = numberOfViews
        super.init (id: id, description: description, dateOfPublication: dateOfPublication, statistics: statistics, reactions: reactions)
    }
}

struct Statistics {
    var numberOfReactions = 0
    var numberOfComments = 0
    var numberOfShares = 0
}

struct Profile {
    var profileName: String
    var post: Post
    init (profileName: String, post: Post) {
        self.profileName = profileName
        self.post = post
    }
}


func printData(_ profile: Profile) {
    var numberOfReactions = Double(profile.post.statistics.numberOfReactions)
    var shortNumberOfReactions:String = String(numberOfReactions)
    if numberOfReactions > 1000 {
        numberOfReactions /= 1000.0
        shortNumberOfReactions = String(numberOfReactions) + "k"
    }
    
    print("Profile name: \(profile.profileName)")
    print("\t| Media type: \(profile.post.type)")
    print("\t| Description: \(profile.post.description)")
    print("\t| Date of publication: \(profile.post.dateOfPublication)")
    print("\t| Number of reactions: \(shortNumberOfReactions)")
    for (key, value) in profile.post.reactions {
        print("\t\t\(key): \(value)")
    }
    print("\t| Number of comments: \(profile.post.statistics.numberOfComments)")
    print("\t| Number of shares: \(profile.post.statistics.numberOfShares)")

    print()
}


var profiles = [Profile]()

profiles.append(Profile(profileName: "Politechnika Gdańska", post: Image(id: 1, description: "Na terenie uczelni pilotażowo zostały zainstalowane dwa zbiorniki do gromadzenia deszczówki...", dateOfPublication: "14.04.2022", statistics: Statistics(numberOfReactions: 172, numberOfComments: 23, numberOfShares: 2), reactions: [Reaction.👍: 120, Reaction.💗: 52], width: 1200.0, height: 800.0, location: "Gdańsk")))

profiles.append(Profile(profileName: "Jan", post: Video(id: 1, description: "My first video", dateOfPublication: "18.03.2022", statistics: Statistics(numberOfReactions: 2500, numberOfComments: 100, numberOfShares: 30), reactions: [Reaction.👍: 1000, Reaction.💗: 500, Reaction.😆: 50, Reaction.😮: 400, Reaction.😢: 40, Reaction.😡: 10], length: 15.5, numberOfViews: 1200)))

profiles.append(Profile(profileName: "Bartek", post: Image(id: 2, description: "My first image", dateOfPublication: "24.04.2022", statistics: Statistics(numberOfReactions: 5300, numberOfComments: 5, numberOfShares: 10), reactions: [Reaction.👍: 2000, Reaction.😮: 300, Reaction.💗: 3000], width: 800.0, height: 600.0, location: "Warsaw")))

for profile in profiles {
    printData(profile)
}
