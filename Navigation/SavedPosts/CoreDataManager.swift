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

    private var persistentStoreURL: NSURL {
        let storeName = "PostModel.sqlite"
        let fileManager = FileManager.default
        let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryURL.appendingPathComponent(storeName) as NSURL
    }




    //!!!!!!!!!!!!!!
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        })
            return container
    } ()

    //MARK: - Core Data Saving support


    /*func getPost(callback: () -> ()) {
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
    }*/

    func saveContext() {
        let context = persistentContainer.viewContext

        
        if context.hasChanges {
            do {
                try context.save()
                print("save")
            } catch {
                let nserror = error as NSError
                fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getContext(callback: () -> ()) {
        let context = persistentContainer.viewContext
    }
}
