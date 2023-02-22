import SwiftUI
import Combine

protocol ProfileContentProviderProtocol: ObservableObject {
    var privacyLevel: PrivacyLevel { get }
    var canSendMessage: Bool { get }
    var canStartVideoChat: Bool { get }
    var photosView: AnyView { get }
    var feedView: AnyView { get }
    var friendsView: AnyView { get }
}

final class ProfileContentProvider<Store>: ProfileContentProviderProtocol where Store: PreferencesStoreProtocol {
    let privacyLevel: PrivacyLevel
    private let user: User
    private var store: Store
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        // swiftlint:disable force_unwrapping
        privacyLevel: PrivacyLevel = DIContainer.shared.resolve(type: PrivacyLevel.self)!,
        user: User = DIContainer.shared.resolve(type: User.self)!,
        store: Store = DIContainer.shared.resolve(type: Store.self)!
        // swiftlint:enable force_unwrapping
    ) {
        self.privacyLevel = privacyLevel
        self.user = user
        self.store = store
        
        store.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &cancellables)
    }
    
    var canSendMessage: Bool {
        privacyLevel >= store.messagePreference
    }
    
    var canStartVideoChat: Bool {
        privacyLevel >= store.videoCallsPreference
    }
    
    var photosView: AnyView {
        privacyLevel >= store.photosPreference ? AnyView(PhotosView(photos: user.photos)) : AnyView(EmptyView())
    }
    
    var feedView: AnyView {
        privacyLevel >= store.feedPreference ? AnyView(HistoryFeedView(posts: user.historyFeed)) : AnyView(EmptyView())
    }
    
    var friendsView: AnyView {
        privacyLevel >= store.friendsListPreference ?
        AnyView(UsersView(title: "Friends", users: user.friends)) :
        AnyView(EmptyView())
    }
}
