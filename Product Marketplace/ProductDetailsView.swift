//
//  ProductDetailsView.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-13.
//

import AmplifyImage
import SwiftUI
import Amplify

struct ProductDetailsView: View {
    @EnvironmentObject var userState: UserState
    // 1
    @Environment(\.dismiss) var dismiss
    
    let product: Product
    
    var body: some View {
        ScrollView {
            // 2
            VStack {
                AmplifyImage(key: product.imageKey)
                    .scaleToFillWidth()
                
                Text("Price: $\(product.price)")
                    .font(.largeTitle)
                
                product.artist.flatMap{Text("Artist: \($0)")}
                
                Text("Record Name: \(product.name)")
                
                product.productDescription.flatMap{Text("Record Desctiption: \($0)")}
                
                product.genre.flatMap{Text("Record Genre: \($0)")}

                Text("Record Release Year: \(product.releaseYear ?? 0)")
                Text("Record Length: \(product.length ?? 0)")
                Text("Song Count: \(product.songsCount ?? 0)")
                
                
                // 3
                if userState.userId != product.userId {
                    Button("Chat", action: {})
                } else {
                    Button("Delete product") {
                        Task { await deleteProduct() }
                    }
                }
            }
            .navigationTitle(product.name)
        }
    }
    
    func deleteProduct() async {
        do {
            // 1
            try await Amplify.DataStore.delete(product)
            print("Deleted product \(product.id)")
            
            // 2
            let productImageKey = product.id + ".jpg"
            try await Amplify.Storage.remove(key: productImageKey)
            print("Deleted file: \(productImageKey)")
            
            dismiss.callAsFunction()
        } catch {
            print(error)
        }
    }
}

//#Preview {
//    ProductDetailsView()
//}
