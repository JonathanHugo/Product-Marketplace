import SwiftUI
import Amplify
import Combine

struct UserProfileView: View {
    // 1
    @EnvironmentObject var userState: UserState
    // 2
    let columns = Array(repeating: GridItem(.flexible(minimum: 150)), count: 2)
    
    // 1
    @State var isImagePickerVisible: Bool = false
    // 2
    @State var newAvatarImage: UIImage?
    // 3
    @State var products: [Product] = []
    @State var tokens: Set<AnyCancellable> = []
    
    var avatarState: AvatarState {
        newAvatarImage.flatMap({ AvatarState.local(image: $0) })
        ?? .remote(avatarKey: userState.userAvatarKey)
    }
    
    var body: some View {
        // 1
        NavigationStack {
            // 2
            VStack {
                Button(action: { isImagePickerVisible = true }) {
                    AvatarView(
                        state: avatarState,
                        fromMemoryCache: true
                    )
                    .frame(width: 75, height: 75)
                    .onChange(of: avatarState) { _ in
                        Task {
                            await uploadNewAvatar()
                        }
                    }
                }
                // 2
                Text(userState.username)
                    .font(.headline)
                // 3
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(products) { product in
                            ProductGridCell(product: product)
                        }
                        ForEach(0..<10) { i in
                            Color.red
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
            .navigationTitle("My Account")
            // 3
            .toolbar {
                ToolbarItem {
                    Button(
                        action: {
                            Task {
                                await signOut()
                            }
                        },
                        label: { Image(systemName: "rectangle.portrait.and.arrow.right") }
                    )
                }
            }
            .sheet(isPresented: $isImagePickerVisible) {
                ImagePickerView(image: $newAvatarImage)
            }
            .onAppear(perform: observeCurrentUsersProducts)
        }
    }
    
    func observeCurrentUsersProducts() {
        // 1
        Amplify.Publisher.create(
            // 2
            Amplify.DataStore.observeQuery(
                for: Product.self,
                where: Product.keys.userId == userState.userId
            )
        )
        // 3
        .map(\.items)
        // 4
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { print($0) },
            receiveValue: { products in
                print("Product count:", products.count)
                // 5
                self.products = products.sorted {
                    guard
                        let date1 = $0.createdAt,
                        let date2 = $1.createdAt
                    else { return false }
                    return date1 > date2
                }
            }
        )
        .store(in: &tokens)
    }
    
    func signOut() async {
        do {
            // 1
            _ = await Amplify.Auth.signOut()
            print("Signed out")
            // 2
            _ = try await Amplify.DataStore.clear()
        } catch {
            print(error)
        }
    }
    
    func uploadNewAvatar() async {
        // 1
        guard let avatarData = newAvatarImage?.jpegData(compressionQuality: 1) else { return }
        do {
            // 2
            let avatarKey = try await Amplify.Storage.uploadData(
                key: userState.userAvatarKey,
                data: avatarData
            ).value
            print("Finished uploading:", avatarKey)
        } catch {
            print(error)
        }
    }
    
    
    
}
