//
//  PostProductView.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-13.
//

import SwiftUI
import Amplify
struct PostProductView: View {
    // 1
    @State var name: String = ""
    @State var price: String = ""
    @State var description: String = ""
    @State var artist: String = ""
    @State var releaseyear: String = ""
    @State var length: String = ""
    @State var songscount: String = ""
    @State var genre: String = ""
    // 2
    @State var image: UIImage?
    @State var shouldShowImagePicker: Bool = false
    // 3
    @State var postButtonIsDisabled: Bool = false
    @EnvironmentObject var userState: UserState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            // 4
            VStack {
                Button(action: { shouldShowImagePicker = true }) {
                    SelectImageView()
                }
                TextField("Record Name", text: $name)
                TextField("Record Price", text: $price)
                    .keyboardType(.numberPad)
                TextField("Record Description", text: $description, axis: .vertical)
                    .lineLimit(1...3)
                TextField("Record Artist", text: $artist)
                TextField("Record Release Year", text: $releaseyear)
                    .keyboardType(.numberPad)
                TextField("Song Length", text: $length)
                    .keyboardType(.numberPad)
                TextField("Song Count", text: $songscount)
                    .keyboardType(.numberPad)
                TextField("Genre", text: $genre)
                
                Button("Post") {
                    Task { await postProduct() }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("New Record")
        .sheet(isPresented: $shouldShowImagePicker) {
            ImagePickerView(image: $image)
        }
    }
    
    func postProduct() async {
        // 1
        guard
            let imageData = image.flatMap({ $0.jpegData(compressionQuality:1) }),
            let priceInt = Int(price)
        else { return }
        let productId = UUID().uuidString
        let productImageKey = productId + ".jpg"
        guard
        let releaseYearInt = Int(releaseyear)
        else {return}
        guard
        let lengthInt = Int(length)
        else {return}
        guard
        let songscountInt = Int(songscount)
        else{return}
        
        
        // 2
        postButtonIsDisabled = true
        
        do {
            // 3
            let key = try await Amplify.Storage.uploadData(
                key: productImageKey,
                data: imageData
            ).value
            
            // 4
            let newProduct = Product(
                id: productId,
                name: name,
                price: priceInt,
                imageKey: key,
                productDescription: description.isEmpty ? nil : description,
                userId: userState.userId,
                artist: artist,
                releaseYear: releaseYearInt,
                length: lengthInt,
                songsCount: songscountInt,
                genre: genre
            )
            let savedProduct = try await Amplify.DataStore.save(newProduct)
            print("Saved product: \(savedProduct)")
            
            // 5
            dismiss.callAsFunction()
        } catch {
            print(error)
            postButtonIsDisabled = false
        }
    }
    
    // 5
    @ViewBuilder
    func SelectImageView() -> some View {
        if let image = self.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .clipped()
        } else {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
        }
    }
}

#Preview {
    PostProductView()
}
