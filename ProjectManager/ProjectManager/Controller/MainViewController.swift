//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    typealias SectionType = Section
    typealias ItemType = Project

    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>! = nil
    private var projectCollectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureDataSource()
    }
}

extension MainViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

extension MainViewController {
    private func configureHierarchy() {
        projectCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(projectCollectionView)
    }
}
extension MainViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ItemType> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }

            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>(collectionView: projectCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ItemType) -> UICollectionViewCell? in

            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}
