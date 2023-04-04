//
//  CoreDataManager.swift
//  Navigation
//
//  Created by M M on 2/25/23.
//

import Foundation
import StorageService
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    // MARK: - Values

    var posts: [SavedPosts] = []

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "PostModel", withExtension: "momd") else { fatalError() }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else { fatalError() }
        return managedObjectModel
    } ()

    private var persistentStoreURL: NSURL {
        let storeName = "PostModel.sqlite"
        let fileManager = FileManager.default
        let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryURL.appendingPathComponent(storeName) as NSURL
    }

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true , NSInferMappingModelAutomaticallyOption: true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.persistentStoreURL
            as URL, options: options)
        } catch {
            print(error.localizedDescription)
        }
        return persistentStoreCoordinator
    } ()

    private lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    } ()


    //MARK: - Core Data Saving support

    func savePost(index: Int, post: [Post]) {
        guard let savedPost = NSEntityDescription.insertNewObject(forEntityName: "PostCoreDataModel", into: self.mainManagedObjectContext)
                as? PostCoreDataModel else { return }

                savedPost.author = post[index].author
                savedPost.postText = post[index].postText
                savedPost.image = post[index].image
                savedPost.likes = Int16(post[index].likes)
                savedPost.views = Int16(post[index].views)

                do {
                    try mainManagedObjectContext.save()
                } catch {
                    print(error.localizedDescription)
                }
    }

    func getPost(callback: () -> ()) {
        CoreDataManager.shared.posts.removeAll()
        let fetchRequest = PostCoreDataModel.fetchRequest()

        do {
            let allPosts = try mainManagedObjectContext.fetch(fetchRequest)

            for currentPost in allPosts {
                let tempPost = SavedPosts(author: currentPost.author ?? "",
                                          postText: currentPost.postText ?? "",
                                          image: currentPost.image ?? "",
                                          likes: Int(currentPost.likes),
                                          views: Int(currentPost.views))
                CoreDataManager.shared.posts.append(tempPost)
            }
            
        } catch {
            print(error.localizedDescription)
            fatalError()
        }

        callback()
    }
}
