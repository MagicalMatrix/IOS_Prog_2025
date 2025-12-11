//
//  ProductView.swift
//  Zad3
//
//  Created by user279431 on 12/11/25.
//

import SwiftUI
import CoreData

struct ProductView: View {
    var product: Product
    
    var body: some View {
        VStack {
            Text("Name: \(product.name ?? "")").padding()
            Text("Category: \(product.category?.name ?? "")").padding()
            Text("Price: $\(product.price)").padding()
            Text("Description:").padding()
            Text(product.desc ?? "").padding()
        }
    }
}
