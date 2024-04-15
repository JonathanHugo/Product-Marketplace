//
//  AlbumListView.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-14.
//

import SwiftUI

struct AlbumListView: View {
    @State private var albums: [Album] = []
    let albumIds = "2up3OPMp9Tb4dAKM2erWXQ,382ObEPsp2rxGrnsizN5TX,1A2GTWGtFfWp7KSQTwWOyo,2noRn2Aes5aoNVsU6iWThc,3IBcauSj5M2A6lTeffJzdv"
    let apiKey = "1399a779admshb13fc4c2473a9a3p11f0d9jsn7256c2a5c5c9"

    var body: some View {
        VStack {
            if albums.isEmpty {
                ProgressView()
            } else {
                List(albums) { album in
                    VStack(alignment: .leading) {
                        if let imageURL = URL(string: album.imageAlbum?.first?.url ?? "") {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    case .failure(_):
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    case .empty:
                                        ProgressView()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                        Text(album.name)
                            .font(.headline)
                        if let artistName = album.artists?.first?.name {
                            Text(artistName)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchAlbums(ids: albumIds, apiKey: apiKey)
        }
    }

    func fetchAlbums(ids: String, apiKey: String) {
        guard let url = URL(string: "https://spotify23.p.rapidapi.com/albums/?ids=\(ids)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("spotify23.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(AlbumsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.albums = decodedResponse.albums
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
}


#Preview {
    AlbumListView()
}
