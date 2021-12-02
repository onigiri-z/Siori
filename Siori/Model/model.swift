import Foundation
import UIKit


struct Book:Identifiable,Codable{
    var id = UUID().uuidString
    var title:String
    var pages:Int
    var nowPages:Int
    var ThumbnailData: Data?
    
    //何%か
    func getPassedDays()->Double{
        return Double(Double(nowPages)/Double(pages))
    }
}
