//
//  SavedViewController.swift
//  Navigation
//
//  Created by M M on 2/25/23.
//

import Foundation
import UIKit
import SnapKit

final class SavedViewController: UIViewController {
    
    // MARK: - Values
    //var data source: [Post]

    // MARK: - View Elements

    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        return tableView
    } ()

    // MARK: - Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.getPost {
            table.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupView()
    }

    private func setupView() {
        view.addSubview(table)

        table.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
    }

    // MARK: - Observers

}

    // MARK: - Extensions

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath)
                as? PostTableViewCell else { return UITableViewCell() }
        cell.savedPostsVM = SavedPostsCellVM(post: CoreDataManager.shared.posts[indexPath.row])
        return cell
    }


    }
