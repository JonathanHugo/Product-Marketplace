// swiftlint:disable all
import Amplify
import Foundation

extension Records {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case recordName
    case Artist
    case releaseYear
    case Length
    case songsCount
    case price
    case genre
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let records = Records.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Records"
    model.syncPluralName = "Records"
    
    model.attributes(
      .primaryKey(fields: [records.id])
    )
    
    model.fields(
      .field(records.id, is: .required, ofType: .string),
      .field(records.recordName, is: .required, ofType: .string),
      .field(records.Artist, is: .required, ofType: .string),
      .field(records.releaseYear, is: .optional, ofType: .int),
      .field(records.Length, is: .optional, ofType: .time),
      .field(records.songsCount, is: .optional, ofType: .int),
      .field(records.price, is: .optional, ofType: .double),
      .field(records.genre, is: .optional, ofType: .string),
      .field(records.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(records.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Records: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}