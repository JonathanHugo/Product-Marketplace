// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "7246af3031a4b311f16b30633aa1d80c"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: ChatRoom.self)
    ModelRegistry.register(modelType: Message.self)
    ModelRegistry.register(modelType: Records.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Product.self)
  }
}