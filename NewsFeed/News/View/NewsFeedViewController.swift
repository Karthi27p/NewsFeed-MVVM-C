//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 02/02/22.
//

import UIKit
import Combine

class NewsFeedViewController: UIViewController {
    
    fileprivate enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, ArticleItem>!
    var articleViewModel: ArticleViewModel?
    private let kNewsCollectionViewCell = "NewsCollectionViewCell"
    
    var cancellable: AnyCancellable?
    
    //MARK: Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.initialSetup()
    }
    
    //MARK: Initial Setup
    private func initialSetup() {
        self.navigationItem.title = "Tesla News"
        collectionView.register(UINib(nibName: kNewsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: kNewsCollectionViewCell)
        collectionView.collectionViewLayout = createNestedLayout() //createTwoItemsWithequalWidthLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.setUpDataSource()
        articleViewModel?.getArticles()
        let cancellable = articleViewModel?.articles.receive(on: RunLoop.main).sink{ [weak self] articleItem in
            self?.createSnapShot(articleItem: articleItem)
        }
        self.cancellable = cancellable
    }
}

//MARK: Datasource setup
extension NewsFeedViewController {
    
    private func setUpDataSource() {
        
        let cellConfiguration = UICollectionView.CellRegistration<NewsCollectionViewCell, ArticleItem> {(cell, indexPath, articleItem) in
            cell.configure(articleItem: articleItem)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ArticleItem>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, articleItem) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellConfiguration, for: indexpath, item: articleItem)
        })
    }
    
    private func createSnapShot(articleItem: [ArticleItem]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, ArticleItem>()
        snapShot.appendSections([.main])
        snapShot.appendItems(articleItem)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension NewsFeedViewController {
    private func createTwoItemsWithequalWidthLayout() -> UICollectionViewLayout {
        let group = getGroupWithTwoItemsEquallySpaced()
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func getGroupWithTwoItemsEquallySpaced() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    }
    
    private func createNestedLayout() -> UICollectionViewLayout {
        let mainItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
        let mainItem = NSCollectionLayoutItem(layoutSize: mainItemSize)
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Item with trailing 2 items
        let leadingMainItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let leadingMainItem = NSCollectionLayoutItem(layoutSize: leadingMainItemSize)
        leadingMainItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(0.5))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let trailingGroupItem = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitem: trailingItem, count: 2)
    
        let itemWithMainAndTrailing = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [leadingMainItem, trailingGroupItem])
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let groupWithTwoItemsEquallySpaced = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(8/3)), subitems: [mainItem, itemWithMainAndTrailing, groupWithTwoItemsEquallySpaced])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout.init(section: section)
        return layout
    }
}

extension NewsFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        articleViewModel?.onArticleTap(indexPath: indexPath)
    }
}
