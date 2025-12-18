//
//  Zad3App.swift
//  Zad3
//
//  Created by user279431 on 12/9/25.
//

import SwiftUI
import CoreData

@main
struct Zad3App: App {
    let persistenceController = PersistenceController.shared
    
    init ()
    {
        //check categories
        checkWebData(URLString: "http://127.0.0.1:5000/categories", DataToGather: CategoryJson(id: 1, name: ""))
        //check products
        checkWebData(URLString: "http://127.0.0.1:5000/products", DataToGather: ProductsJson(id: 1, name: "", price: 0, desc: "", category_id: 1))
        //loadData()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct CategoryJson: Decodable {
    let id: Int
    let name: String
}

struct ProductsJson: Decodable {
    let id: Int
    let name: String
    let price: Float
    let desc: String
    let category_id: Int
}

extension Zad3App
{
    func checkWebData<DType: Decodable>(URLString: String, DataToGather: DType)
    {
        let url = URL(string: URLString)!
        

        //*
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //print("whatever1.5")
            let decoder = JSONDecoder()
            if let data = data {
                
                do {
                    let dataContent = try decoder.decode([DType].self, from: data)
                    print(dataContent)
                }
                catch
                {
                    print("error")
                }
            }
        }
        //*/
        task.resume()
    }
    
    /*
    func loadData() {
        let context = persistenceController.container.viewContext
        
        
        //check if data already exists
        print(dataExists())
        if dataExists() == false {
            let fixedData: [[String: Any]] = [
                ["category": ["name": "nabial"],
                 "products": [["name": "maslo klarowane", "price": 28.99, "desc": "najlepsze do smarowania"], ["name": "mleko UHT", "price": 4.59, "desc": "kazdy pije mleko z kawa"]]],
                
                ["category": ["name": "owoce"],
                 "products": [["name": "banany kisc", "price": 6.99, "desc": "dla wszystkich, szczegolnie dla siebie"]]]
            ]
            
            for data in fixedData {
                if let categoryData = data["category"] as? [String: String],
                   let categoryName = categoryData["name"] {
                    
                    let addedCategory = Category(context: context)
                    addedCategory.name = categoryName
                    
                    if let productsData = data["products"] as? [[String: Any]] {
                        for product in productsData {
                            
                            if let productName = product["name"] as? String,
                               let productPrice = product["price"] as? Double,
                               let productDesc = product["desc"] as? String {
                                
                                let addedProduct = Product(context: context)
                                addedProduct.name = productName
                                addedProduct.price = productPrice
                                addedProduct.desc = productDesc
                                addedProduct.category = addedCategory
                            }
                        }
                    }
                }
            }
            
            do {
                try context.save()
            } catch {
                print ("eror initializing data")
            }
        }
    }
    
    func dataExists() -> Bool {
        let context = persistenceController.container.viewContext
        
        do {
            //only need to check if categories exist as both are created at the same time
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            let categories = try context.fetch(request)
            return !categories.isEmpty
        }
        catch {
            return false
        }
    }
     */
}
