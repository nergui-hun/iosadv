//
//  PhotosViewController.swift
//  Navigation
//
//  Created by M M on 5/5/22.
//

import Foundation
import UIKit
import SnapKit

final class PhotosViewController: UIViewController {

    // MARK: - Values

    private var dataSource: [String] = []

    // MARK: - View Elements

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        return collection
    }()

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    } ()


    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "photoGallery-localizable")
        self.navigationController?.navigationBar.topItem?.backButtonTitle = String(localized: "back-localizable")
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationController?.navigationBar.isHidden = false

        setupView()
        dataSource = fetchData()
    }

    private func setupView() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalTo(view).inset(8)
        }
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / 3)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}


// MARK: - Extensions

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            return cell
        }
        let photo = self.dataSource[indexPath.row]
        cell.setup(with: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func fetchData() -> [String] {
        (1...20).map { String($0)}
    }
}
