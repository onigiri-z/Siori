//
//  DatailView.swift
//  Siori
//
//  Created by 入江健太 on 2021/11/19.
//

import SwiftUI

struct DatailView: View {
    @EnvironmentObject var viewModel:ViewModel
    
    var body: some View {
        if let product = viewModel.currentProduct,viewModel.showDetail{
            Text("Hello,DatailView!" + product.bookName)
        }
    }
}

struct DatailView_Previews: PreviewProvider {
    static var previews: some View {
        DatailView()
    }
}
