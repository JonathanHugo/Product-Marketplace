// swiftlint:disable all
import Amplify
import Foundation

public struct Records: Model {
  public let id: String
  public var recordName: String
  public var Artist: String
  public var releaseYear: Int?
  public var Length: Temporal.Time?
  public var songsCount: Int?
  public var price: Double?
  public var genre: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      recordName: String,
      Artist: String,
      releaseYear: Int? = nil,
      Length: Temporal.Time? = nil,
      songsCount: Int? = nil,
      price: Double? = nil,
      genre: String? = nil) {
    self.init(id: id,
      recordName: recordName,
      Artist: Artist,
      releaseYear: releaseYear,
      Length: Length,
      songsCount: songsCount,
      price: price,
      genre: genre,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      recordName: String,
      Artist: String,
      releaseYear: Int? = nil,
      Length: Temporal.Time? = nil,
      songsCount: Int? = nil,
      price: Double? = nil,
      genre: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.recordName = recordName
      self.Artist = Artist
      self.releaseYear = releaseYear
      self.Length = Length
      self.songsCount = songsCount
      self.price = price
      self.genre = genre
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}