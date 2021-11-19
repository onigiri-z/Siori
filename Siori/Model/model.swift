import Foundation


struct BookModel:Identifiable{
    var id = UUID().uuidString
    var bookName:String
    var ShouArr:[ShouModel]
}

struct ShouModel{
    var name:String = "未設定"
    var cheakBox = false
}

var books:[BookModel] = [BookModel(bookName: "数学I",
                                   ShouArr: [ShouModel(),
                                             ShouModel(),
                                             ShouModel(),
                                             ShouModel()]
                                  ),
                         BookModel(bookName: "国語の教科書",
                                   ShouArr: [ShouModel(),
                                             ShouModel(),
                                             ShouModel()]
                                  ),
                         BookModel(bookName: "ハリーポッター賢者の石",
                                   ShouArr: [ShouModel(),
                                             ShouModel(),
                                             ShouModel(),
                                             ShouModel(),
                                             ShouModel()]
                                  )]
