

import Foundation
struct TopTier : Codable {
    var kind: String
    var totalItems: Int
    var items: [Item]
}
struct Item: Codable,Identifiable{
    var kind: String
    var id: String
    var etag: String
    var selfLink: String
    var volumeInfo: VolumeInfo
}
struct VolumeInfo: Codable {
    var title: String
    var subtitle: String?
    var imageLinks: ImageLinks?
    var pageCount:Int?
}

struct ImageLinks: Codable {
    var smallThumbnail: String
    var thumbnail: String?
}
