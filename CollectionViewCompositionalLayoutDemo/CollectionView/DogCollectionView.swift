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
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        //layout.estimatedItemSize = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(DogCollectionViewCell.self, forCellWithReuseIdentifier: "dogCell")
        return collectionView
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
