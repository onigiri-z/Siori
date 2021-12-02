//
//  SeachView.swift
//  Siori
//
//  Created by 入江健太 on 2021/11/26.
//

import SwiftUI

struct SeachView: View {
    @EnvironmentObject var baseData: ViewModel
    
    @State var searchQuery = ""
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        VStack(spacing:8){
            // Search Bar...
            HStack(spacing: 15){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(.gray)
                
                
                TextField("Seach", text: $searchQuery, onEditingChanged: { isBegin in
                    if isBegin {
                        print("入力中")
                    } else {
                        print("非入力中")
                    }
                }, onCommit: {
                    print("コミット")
                    //ここで検索して、結果を下に表示
                    if searchQuery != ""{
                        baseData.searchCharacter(q: searchQuery)
                    }
                })
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.05))
            .cornerRadius(8)
            .padding()
            
            Rectangle()
                .fill(Color.gray.opacity(0.6))
                .frame(height: 0.5)
                .padding(.leading,8)
                .padding(.trailing,8)
            Spacer()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                if baseData.fetchedCharacters != nil{
                    LazyVGrid(columns: columns,spacing: 18) {
                        ForEach(baseData.fetchedCharacters!){product in
                            VStack{
                                if let imagelink = product.volumeInfo.imageLinks{
                                    AsyncImage(url: URL(string: imagelink.smallThumbnail.replacingOccurrences(of: "http", with: "https"))) { phase in
                                        if let image = phase.image {
                                            image.resizable().scaledToFit()
                                        } else if let error = phase.error {
                                            Text(error.localizedDescription)
                                        } else {
                                            ProgressView()
                                        }
                                    }
                        
                                }else{
                                    Image("noimage").resizable().scaledToFit()
                                }
                                GeometryReader{proxy in
                                    Text(product.volumeInfo.title)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(width: proxy.size.width)
                                }
                            }
                            .padding()
                            .onTapGesture{
                                print(product.volumeInfo.title+"を選択しました。")
                                //URLのから画像データを取り出す
                                let session = URLSession(configuration: .default)
                                var idata:Data?
                                // セマフォ
                                let semaphore = DispatchSemaphore(value: 0)
                                if let imagelink = product.volumeInfo.imageLinks{
                                    let task = session.dataTask(with: URL(string: imagelink.smallThumbnail.replacingOccurrences(of: "http", with: "https"))!) { (data, _, _) in
                                        idata = data
                                        semaphore.signal()
                                    }
                                    task.resume()
                                }else{
                                    idata = UIImage(named: "noimage")?.pngData()
                                    semaphore.signal()
                                }
                                semaphore.wait()
                                if(product.volumeInfo.pageCount != nil){
                                    baseData.add(name: product.volumeInfo.title, pages: product.volumeInfo.pageCount!, imageData: idata!)
                                }
                                baseData.showingSeachView.toggle()
                            }
                        }
                        
                    }
                    
                }
            }
        }.padding(.top,10)
            .onAppear{baseData.fetchedCharacters = nil}
    }
}

struct SeachView_Previews: PreviewProvider {
    @StateObject static var baseData = ViewModel()
    static var previews: some View {
        SeachView().environmentObject(baseData)
    }
}


struct Product: Identifiable{
    var id = UUID().uuidString
    var productImage: String
    var productTitle: String
}

var products = [
    Product(productImage: "p1", productTitle: "Nike Air Max 20"),
    Product(productImage: "p2", productTitle: "Excee Sneakers"),
    Product(productImage: "p3", productTitle: "Air Max Motion 2"),
    Product(productImage: "p4", productTitle: "Leather Sneakers")
]
