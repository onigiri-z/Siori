
import Foundation
//ファイルのコントローラ
class FileController {
    //保存するデータ
    var fileDataModel = FileDataModel()

    //データを保存するURL
    private var saveURL: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("save1130")
    }
    //初期化
    init() {
        loadDataModel()
    }
    
    //ロード時
    private func loadDataModel() {
        //データをURLから取り出す
        let url = saveURL
        let dataModel:FileDataModel
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: saveURL)
                dataModel = try decoder.decode(FileDataModel.self, from: data)
                print("ロード成功")
                
            } catch {
                dataModel = FileDataModel()
                print("ロード失敗１")
            }
        } else {
            dataModel = FileDataModel()
            print("ロード失敗２")
        }
        self.fileDataModel = dataModel
    }
    

    func setfiledata(arr:[Book]){
        fileDataModel.constList = arr
    }
    //URLにデータを書き込む
    func saveDataModel(){
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(fileDataModel)
            try data.write(to: saveURL)
        } catch {
            print("saveDataModel error")
        }
    }
}





