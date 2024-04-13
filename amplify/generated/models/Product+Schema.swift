// swiftlint:disable all
import Amplify
import Foundation

extension Product {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case price
    case imageKey
    case productDescription
    case userId
    case artist
    case releaseYear
    case length
    case songsCount
    case genre
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let product = Product.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Products"
    model.syncPluralName = "Products"
    
    model.attributes(
      .primaryKey(fields: [product.id])
    )
    
    model.fields(
      .field(product.id, is: .required, ofType: .string),
      .field(product.name, is: .required, ofType: .string),
      .field(product.price, is: .required, ofType: .int),
      .field(product.imageKey, is: .required, ofType: .string),
      .field(product.productDescription, is: .optional, ofType: .string),
      .field(product.userId, is: .required, ofType: .string),
      .field(product.artist, is: .optional, ofType: .string),
      .field(product.releaseYear, is: .optional, ofType: .int),
      .field(product.length, is: .optional, ofType: .int),
      .field(product.songsCount, is: .optional, ofType: .int),
      .field(product.genre, is: .optional, ofType: .string),
      .field(product.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(product.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Product: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}