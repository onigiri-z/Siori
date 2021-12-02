import SwiftUI

struct BaseView: View {
    @StateObject var baseData = ViewModel()
    @State var showingDialog = false
    var bottomEdge: CGFloat
    var body: some View {
        TabView(selection: $baseData.currentTab) {
            Home()
                .environmentObject(baseData)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.05))
                .tag(Tab.Home)
            
            SettingView()
                .tag(Tab.Setting)
            
        }
            .overlay(
                //カスタムタブバー
                HStack(spacing: 0){
                    TabButton(Tab: .Home)
                    Button {
                        showingDialog.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)
                            .offset(x: -1)
                            .padding(18)
                            .background(Color("DarkBlue"))
                            .clipShape(Circle())
                        // shadows..
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                    }
                    .offset(y: -30)
                    
                    TabButton(Tab: .Setting)
                }
                    .background(
                        Color.white
                            .clipShape(CustomCurveShape())
                        // shadow...
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                ,alignment: .bottom
                
            )
            //.overlay(NewBookAlert().environmentObject(baseData))
            .sheet(isPresented: $baseData.showingSeachView) {
                SeachView().environmentObject(baseData)
            }
            .sheet(isPresented: $baseData.showingBookAddView) {
                BookAddView().environmentObject(baseData)
            }
            .confirmationDialog("本の追加方法", isPresented: $showingDialog, titleVisibility: .visible) {
                Button("本を検索する") {
                    print("本を検索する")
                    baseData.showingSeachView.toggle()
                }
                Button("本を手動で登録する") {
                    print("本を手動で登録する")
                    withAnimation{
                        baseData.showingBookAddView.toggle()
                    }
                }
            }
    }
    
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View{
        
        Button {
            withAnimation{
                baseData.currentTab = Tab
            }
        } label: {
            Image(systemName: Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(baseData.currentTab == Tab ? Color("DarkBlue") : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView(bottomEdge: 10)
    }
}


