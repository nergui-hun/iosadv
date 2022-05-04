//
//  ProfileViewController.swift
//  Navigation
//
//  Created by M M on 4/29/22.
//

import UIKit

class ProfileViewController: UIViewController {

    //===================PROPERTIES=====================//
    var dataSource: [Post] = []

    let profileHeaderView: ProfileHeaderView = {
        let phView = ProfileHeaderView()
        phView.translatesAutoresizingMaskIntoConstraints = false
        return phView
    }()

    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.tableHeaderView = profileHeaderView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()



    //==========================METHODS=========================//
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.navigationController?.navigationBar.isHidden = true

        configureTableView()
        dataSource = fetchData()
    }


    private func configureTableView() {
        view.addSubview(postTableView)
        postTableView.pin(to: view)
        setConstraints()
        self.postTableView.tableHeaderView?.layoutIfNeeded()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: self.postTableView.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.centerXAnchor.constraint(equalTo: self.postTableView.centerXAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.postTableView.topAnchor)
        ])
    }
}



//=========================EXTENSIONS===========================//
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell
        }
        let post = self.dataSource[indexPath.row]
        cell.set(post: post)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ProfileViewController {

    func fetchData() -> [Post] {
        let post1 = Post(author: "Нетология. Меряем карьеру через образование.", description: "От 'Hello, World' до первого сложного iOS-приложения - всего один курс. Если чувствуете в себе силу для покорения топов AppStore - пора начинать действовать! Профессия «iOS-разработчик» - тот самый путь, по которому стоит пройти по самого конца. Вы научитесь создавать приложения на языке Swift с нуля: от начинки до интерфейса. Чтобы закрепить знания на практике, каждый студент подготовит дипломную работу - VK-like приложение с возможностью публиковать фотографии, использовать фильтры, ставить лайки и подписываться на других пользователей.", image: "camel", likes: 766, views: 893)

        let post2 = Post(author: "Cats TV", description: "Bald cats are very cute", image: "bald", likes: 233, views: 234)
        let post3 = Post(author: "Mongolia TV", description: "Mongolian house", image: "ger", likes: 34, views: 354)
        let post4 = Post(author: "Rock TV", description: "The HU", image: "hu", likes: 33, views: 45)

        return [post1, post2, post3, post4]
    }
}
