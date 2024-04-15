//
//  AlbumModel.swift
//  Product Marketplace
//
//  Created by Yusuf Sheikhali on 2024-04-14.
//

import Foundation

struct AlbumsResponse: Decodable {
    let albums: [Album]
}

struct Album: Decodable, Identifiable {
    let id: String
    let name: String
    let artists: [Artist]?
    let imageAlbum: [ImageAlbum]?
    let label: String?
    let releaseDate: String?
    let totalTracks: Int?
    let popularity: Int?
    let uri: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case imageAlbum = "images"
        case label
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
        case popularity
        case uri
    }
    
    struct Artist: Decodable {
        let name: String
    }
    
    struct ImageAlbum: Decodable {
        let url: String
        let height: Int
        let width: Int
    }
    
}


