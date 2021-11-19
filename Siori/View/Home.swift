import SwiftUI

struct Home: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            ForEach(books){book in
                Text(book.bookName)
                    .onTapGesture {
                        withAnimation{
                            viewModel.currentProduct = book
                            viewModel.showDetail = true
                        }
                    }
            }
        }.overlay(DatailView().environmentObject(viewModel))
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
