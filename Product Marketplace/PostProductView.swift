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
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    @State private var artist: String = ""
    @State private var releaseYear: String = ""
    @State private var length: String = ""
    @State private var songsCount: String = ""
    @State private var genre: String = ""
    
    // 2
    @State private var image: UIImage?
    @State private var shouldShowImagePicker: Bool = false
    
    // 3
    @State private var postButtonIsDisabled: Bool = false
    @State private var errorMessage: String = ""
    
    @EnvironmentObject private var userState: UserState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: { shouldShowImagePicker = true }) {
                    SelectImageView()
                }
                TextField("Record Name", text: $name)
                TextField("Record Price", text: $price)
                    .keyboardType(.numberPad)
                TextField("Record Description", text: $description)
                    .lineLimit(3)
                TextField("Record Artist", text: $artist)
                TextField("Record Release Year", text: $releaseYear)
                    .keyboardType(.numberPad)
                TextField("Song Length", text: $length)
                    .keyboardType(.numberPad)
                TextField("Song Count", text: $songsCount)
                    .keyboardType(.numberPad)
                TextField("Genre", text: $genre)
                
                // 4
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.vertical)
                
                Button("Post") {
                    Task { await postProduct() }
                }
                .disabled(postButtonIsDisabled)
            }
        }
        .padding(.horizontal)
        .navigationTitle("New Record")
        .sheet(isPresented: $shouldShowImagePicker) {
            ImagePickerView(image: $image)
        }
    }
    
    private func postProduct() async {
        guard let imageData = image?.jpegData(compressionQuality: 1) else {
            errorMessage = "Please select an image"
            return
        }
        
        // Validate data types
        guard let priceInt = Int(price) else {
            errorMessage = "Invalid price"
            return
        }
        
        guard let releaseYearInt = Int(releaseYear) else {
            errorMessage = "Invalid release year"
            return
        }
        
        guard let lengthInt = Int(length) else {
            errorMessage = "Invalid song length"
            return
        }
        
        guard let songsCountInt = Int(songsCount) else {
            errorMessage = "Invalid song count"
            return
        }
        
        // Reset error message if all data is valid
        errorMessage = ""
        
        // Proceed with posting the product...
        let productId = UUID().uuidString
        let productImageKey = productId + ".jpg"
        
        postButtonIsDisabled = true
        
        do {
            let key = try await Amplify.Storage.uploadData(
                key: productImageKey,
                data: imageData
            ).value
            
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
                songsCount: songsCountInt,
                genre: genre
            )
            let savedProduct = try await Amplify.DataStore.save(newProduct)
            print("Saved product: \(savedProduct)")
            
            dismiss.callAsFunction()
        } catch {
            print(error)
            errorMessage = "Failed to post product"
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
