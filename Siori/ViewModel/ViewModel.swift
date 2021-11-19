import SwiftUI

class ViewModel: ObservableObject {
    @Published var currentProduct: BookModel?
    @Published var showDetail = false
}
