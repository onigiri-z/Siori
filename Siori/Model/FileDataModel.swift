import Foundation
import SwiftUI

struct FileDataModel:Codable{
    //継続物の配列
    var constList :[Book] = [Book(title: "星を継ぐもの", pages: 308, nowPages: 120,ThumbnailData: UIImage(named: "星を継ぐもの")?.pngData()),
                             Book(title: "陽だまりの彼女", pages: 342, nowPages: 20,ThumbnailData: UIImage(named: "陽だまりの彼女")?.pngData())]
}
