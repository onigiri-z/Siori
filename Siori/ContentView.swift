import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{proxy in
            BaseView(bottomEdge: proxy.safeAreaInsets.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
