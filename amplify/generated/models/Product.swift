// swiftlint:disable all
import Amplify
import Foundation

public struct Product: Model {
  public let id: String
  public var name: String
  public var price: Int
  public var imageKey: String
  public var productDescription: String?
  public var userId: String
  public var artist: String?
  public var releaseYear: Int?
  public var length: Int?
  public var songsCount: Int?
  public var genre: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      price: Int,
      imageKey: String,
      productDescription: String? = nil,
      userId: String,
      artist: String? = nil,
      releaseYear: Int? = nil,
      length: Int? = nil,
      songsCount: Int? = nil,
      genre: String? = nil) {
    self.init(id: id,
      name: name,
      price: price,
      imageKey: imageKey,
      productDescription: productDescription,
      userId: userId,
      artist: artist,
      releaseYear: releaseYear,
      length: length,
      songsCount: songsCount,
      genre: genre,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      price: Int,
      imageKey: String,
      productDescription: String? = nil,
      userId: String,
      artist: String? = nil,
      releaseYear: Int? = nil,
      length: Int? = nil,
      songsCount: Int? = nil,
      genre: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.price = price
      self.imageKey = imageKey
      self.productDescription = productDescription
      self.userId = userId
      self.artist = artist
      self.releaseYear = releaseYear
      self.length = length
      self.songsCount = songsCount
      self.genre = genre
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}