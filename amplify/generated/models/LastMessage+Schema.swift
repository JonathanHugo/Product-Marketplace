// swiftlint:disable all
import Amplify
import Foundation

extension LastMessage {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case body
    case dateTime
    case productId
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let lastMessage = LastMessage.keys
    
    model.listPluralName = "LastMessages"
    model.syncPluralName = "LastMessages"
    
    model.fields(
      .field(lastMessage.body, is: .optional, ofType: .string),
      .field(lastMessage.dateTime, is: .optional, ofType: .dateTime),
      .field(lastMessage.productId, is: .optional, ofType: .string)
    )
    }
}