import SwiftUI

class ViewModel: ObservableObject {
    @Published var models:[Book] = []
    
    @Published var currentBook:Book?
    
    
    @Published var currentTab: Tab = .Home
    
//    @Published var createNew = false
    
    @Published var showingSeachView = false
    
    @Published var showingBookAddView = false
    
    @Published var fetchedCharacters: [Item]? = nil

    // Offset...
    @Published var offset: CGFloat = 0
    @Published var lastStoredOffset: CGFloat = 0
    
    let fileController = FileController()
    
    func countUp(){
        for i in 0...models.count-1{
            if models[i].id == currentBook?.id{
                models[i].nowPages += 1
            }
        }
        save()
    }
    
    func countDown(){
        for i in 0...models.count-1{
            if models[i].id == currentBook?.id{
                models[i].nowPages -= 1
            }
        }
        save()
    }
    
    init(){
        for ll in fileController.fileDataModel.constList{
            models.append(Book(title: ll.title, pages: ll.pages, nowPages: ll.nowPages,ThumbnailData: ll.ThumbnailData))
        }
    }

    
    func add(name:String,pages:Int,imageData:Data){
        models.append(Book(title: name, pages: pages, nowPages: 0,ThumbnailData: imageData))
        save()
    }
    
    func save(){
        var arr:[Book] = []
        for dd in models{
            arr.append(dd)
        }
        //保存
        fileController.setfiledata(arr: arr)
        fileController.saveDataModel()
        
        print("保存しました。")
    }
    
    func searchCharacter(q:String){
        let urlString: String = "https://www.googleapis.com/books/v1/volumes?q=\(q)"
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: encodeUrlString)!) { (data, _, err) in
            
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("no data found")
                return
            }
            
            do{
                
                // decoding API Data....
                
                let characters = try JSONDecoder().decode(TopTier.self, from: APIData)
                
                
                DispatchQueue.main.async {
                    self.fetchedCharacters = characters.items
                }
                
                for item in characters.items{
                    print(item.volumeInfo.title)
                    if item.volumeInfo.imageLinks != nil{
                        print(item.volumeInfo.imageLinks!.thumbnail!)
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    //行入れ替え処理
    func rowReplace(_ from: IndexSet, _ to: Int) {
        self.models.move(fromOffsets: from, toOffset: to)
        save()
    }
    //削除処理
    func delete(at offsets: IndexSet) {
        self.models.remove(atOffsets: offsets)
        save()
    }
}



// Enum Case for Tab Items...
enum Tab: String{
    case Home = "house"
    case Setting = "gearshape"
}



