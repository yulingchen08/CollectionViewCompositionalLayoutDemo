//
//  DogCollectionView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/29.
//

import UIKit

enum DogType: Int {
    case smallDog = 0
    case MediumDog
    case LargeDog
}

struct Dog: Hashable {
    var id: String
    var name: String
    var description: String
    var imageName: String
}

class DogCollectionView: UIViewController {
    let network = NetworkService()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        //layout.estimatedItemSize = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), collectionViewLayout: nestedGroupLayout)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(DogCollectionViewCell.self, forCellWithReuseIdentifier: "dogCell")
        return collectionView
    }()
    
    lazy var nestedLayout: UICollectionViewLayout = {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(120))
        let leftItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let rightSmallSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(40))
        let rightSmallItem = NSCollectionLayoutItem(layoutSize: rightSmallSize)
        
        let rightBigSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(40))
        let rightBigItem = NSCollectionLayoutItem(layoutSize: rightBigSize)
        
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(40))
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, subitems: [rightSmallItem, rightBigItem])
        rightGroup.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
        rightGroup.interItemSpacing = .fixed(10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leftItem, rightGroup])
        
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(20), top: nil, trailing: .fixed(10), bottom: nil)
                             
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection.init(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var nestedGroupLayout: UICollectionViewLayout = {
        
        
        let leftItemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(120))
        let leftItem = NSCollectionLayoutItem(layoutSize: leftItemSize)
        
        let rightSmallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(45))
        let rightSmallItem = NSCollectionLayoutItem(layoutSize: rightSmallItemSize)

        let rightLargeItemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(65))
        let rightLargeItem = NSCollectionLayoutItem(layoutSize: rightLargeItemSize)
        
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(120))
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, subitems: [rightSmallItem, rightLargeItem])
        
        rightGroup.interItemSpacing = .fixed(10)
                        
        // 包含一個左邊的 item 跟右邊的子 group 的大 group
        let bigGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(135), heightDimension: .absolute(120))
        let bigGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bigGroupSize, subitems: [leftItem, rightGroup])
        bigGroup.interItemSpacing = .fixed(5)
        bigGroup.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(20), top: nil, trailing: .fixed(10), bottom: nil)
                             
        let section = NSCollectionLayoutSection(group: bigGroup)
        //section.orthogonalScrollingBehavior = .continuous // 加上這行  badge會在item下面，是ios的bug
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    
    var smallDogs: [Dog] = [
        Dog(id: "1", name: "Pinky", description: "Cute dog", imageName: "ant"),
        Dog(id: "2", name: "Toro", description: "Smart dog", imageName: "ant"),
        Dog(id: "3", name: "Toro", description: "Smart dog", imageName: "ant"),
        Dog(id: "4", name: "Toro", description: "Smart dog", imageName: "ant")
    ]
    
    var mediumDogs: [Dog] = [
        Dog(id: "1", name: "Dumdum", description: "Stupid dog", imageName: "ant"),
        Dog(id: "2", name: "Mike", description: "Smart dog", imageName: "ant")
    ]
    
    var bigDogs: [Dog] = [
        Dog(id: "1", name: "Bruto", description: "Big dog", imageName: "ant"),
        Dog(id: "2", name: "Red", description: "Super Smart", imageName: "ant")
    ]
    
    
    var dataSource: UICollectionViewDiffableDataSource<DogType, Dog>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        applySnapShot()
    }
    
}

extension DogCollectionView {
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DogType, Dog>(collectionView: collectionView, cellProvider: { collectionView, indexPath, dog -> UICollectionViewCell in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as! DogCollectionViewCell
            cell.updateFrame(dog: dog)
            cell.backgroundColor = .green
            return cell
        })
        collectionView.dataSource = dataSource
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<DogType, Dog>()
        snapShot.appendSections([.smallDog, .MediumDog, .LargeDog])
        snapShot.appendItems(bigDogs, toSection: .LargeDog)
        snapShot.appendItems(mediumDogs, toSection: .MediumDog)
        snapShot.appendItems(smallDogs, toSection: .smallDog)
        dataSource.apply(snapShot)
    }
    
}

extension DogCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        switch indexPath.section {
        case DogType.smallDog.rawValue:
            self.smallDogs.remove(at: row)
        case DogType.MediumDog.rawValue:
            self.mediumDogs.remove(at: row)
        case DogType.LargeDog.rawValue:
            self.bigDogs.remove(at: row)
        default:
            break
        }
        applySnapShot()
    }
}
