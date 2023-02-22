import Foundation

struct User: Hashable, Equatable {
    let name: String
    let imageURL: String
    let bio: String
    let area: String
    let friends: [User]
    let photos: [String]
    let historyFeed: [Post]
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name && lhs.imageURL == rhs.imageURL
    }
}

struct Post: Hashable {
    let pictureURL: String
    let message: String
    let likesCount: Int
    let commentsCount: Int
}
