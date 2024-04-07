//
//  Product_MarketplaceApp.swift
//  Product Marketplace
//
//  Created by Jonathan Hugo on 2024-04-07.
//

import SwiftUI
import Amplify
import AWSDataStorePlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@main
struct Product_MarketplaceApp: App {
    var body: some Scene {
        WindowGroup {
            SessionView()
        }
    }
    
    init() {
        configureAmplify()
    }
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Successfully configured Amplify")
            
        } catch {
            print("Failed to initialize Amplify", error)
        }
    }
    
}
