import SwiftUI

struct Home: View {
    @EnvironmentObject var baseData: ViewModel
    
    var body: some View {
        VStack(spacing:0){
            HStack{
                Spacer()
                EditButton()
            }
            .overlay(Text("Siori").font(.title3).fontWeight(.bold))
            .frame(height:40)
            .padding(.horizontal).padding(.top)
            List{
                ForEach(0..<baseData.models.count, id: \.self) { index in
                    VStack(alignment:.center,spacing:8){
                        HStack{
                            Image(uiImage: UIImage(data: baseData.models[index].ThumbnailData!)!)
                                .resizable().scaledToFit().frame(width:100)
                            Spacer()
                            VStack{
                                Text(baseData.models[index].title)
                                Text("\(baseData.models[index].nowPages)/\(baseData.models[index].pages)")
                                
                                HStack{
                                    Button {
                                        baseData.currentBook = baseData.models[index]
                                        baseData.countDown()
                                    } label: {
                                        Image(systemName: "minus")
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(.white)
                                            .offset(x: -1)
                                            .padding(18)
                                            .background(Color("DarkBlue"))
                                            .clipShape(Circle())
                                        // shadows..
                                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                    Button {
                                        baseData.currentBook = baseData.models[index]
                                        baseData.countUp()
                                    } label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(.white)
                                            .offset(x: -1)
                                            .padding(18)
                                            .background(Color("DarkBlue"))
                                            .clipShape(Circle())
                                        // shadows..
                                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                }
                            }
                            Spacer()
                        }
                        
                        
                        GraphView(book:$baseData.models[index])
                    }.frame(maxWidth: .infinity,maxHeight: 120)
                }.onMove(perform: baseData.rowReplace).onDelete(perform: baseData.delete)
            }
        }.padding(.bottom, 15.0)//.padding()
        
        
    }
}

struct Home_Previews: PreviewProvider {
    @StateObject static var baseData = ViewModel()
    static var previews: some View {
        Home().environmentObject(baseData)
    }
}

struct GraphView: View {
    
    @Binding var book:Book
    
    var body: some View {
        GeometryReader{proxy in
            ZStack(alignment:.leading){
                Capsule()
                    .fill(Color("BG"))
                    .frame(width: proxy.size.width)
                
                Capsule()
                    .fill(Color("Pink"))
                    .frame(width: proxy.size.width*book.getPassedDays())
            }.frame(height: 8)
        }.frame(width:300,height: 8)
    }
}
