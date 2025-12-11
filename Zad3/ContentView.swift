//
//  ContentView.swift
//  Zad3
//
//  Created by user279431 on 12/9/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    var body: some View {

        NavigationView{
            List {
                ForEach(products) {
                    product in HStack {
                        NavigationLink(product.name!, destination: ProductView(product: product))
                        //Text(product.name ?? "").font(.title)
                    }
                }
            }
            .navigationTitle("Products")
        }
        
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
