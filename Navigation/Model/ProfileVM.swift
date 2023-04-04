//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by M M on 3/5/23.
//

import Foundation
import UIKit
import StorageService

protocol ProfileVMProtocol {
    func numberOfRows() throws -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableVM
    var posts: [Post] { get set }
}

final class ProfileVM: ProfileVMProtocol {
    var posts: [Post] = [
                Post(author: "Нетология. Меряем карьеру через образование.", postText: "От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия «iOS-разработчик» - тот самый путь, по которому стоит пройти по самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложение с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей.", image: "camel", likes: 766, views: 893),

                Post(author: "Cats TV", postText: "Bald cats are very cute", image: "bald", likes: 233, views: 234),
                Post(author: "Mongolia TV", postText: "Mongolian house", image: "ger", likes: 34, views: 354),
                Post(author: "Rock TV", postText: "The HU", image: "hu", likes: 33, views: 45)


]

    func numberOfRows() throws -> Int {
        if posts.count != 0 {
            return posts.count
        } else {
            print("Profile VM \(posts.count)")
            return 2
        }
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableVM {
        let post = posts[indexPath.row]
        return PostTableVM(post: post)
    }


}
