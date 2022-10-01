//
//  CameraTestCollectionView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/14.
//

import UIKit

class CameraTestCollectionView: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<CameraSection, CameraTestCollectionViewCell.PhotoObject>!
    let viewModel = CameraCollectionTestViewModel()
    
    enum CameraSection {
        case collection
    }
    
    var nestedLayout: UICollectionViewCompositionalLayout = {
        let leftItemLayout = NSCollectionLayoutSize.init(widthDimension: .absolute(65), heightDimension: .absolute(120))
        let leftItem = NSCollectionLayoutItem.init(layoutSize: leftItemLayout)
        //leftItem.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: , top: 0, trailing: 0, bottom: 0)
        
        let rightTopItemLayout = NSCollectionLayoutSize.init(widthDimension: .absolute(65), heightDimension: .absolute(60))
        let rightTopItem = NSCollectionLayoutItem.init(layoutSize: rightTopItemLayout)
        
        let rightBottomItemLayout = NSCollectionLayoutSize.init(widthDimension: .absolute(65), heightDimension: .absolute(60))
        let rightBottomItem = NSCollectionLayoutItem.init(layoutSize: rightBottomItemLayout)
        
        
        let rightGroupLayout = NSCollectionLayoutSize.init(widthDimension: .absolute(65), heightDimension: .absolute(150))
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupLayout, subitems: [rightTopItem, rightBottomItem]) //here
        rightGroup.interItemSpacing = .fixed(10)
    
        
        let groupSize = NSCollectionLayoutSize.init(widthDimension: .absolute(150), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [leftItem, rightGroup])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection.init(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 2, bottom: 0, trailing: 2)
        let layout = UICollectionViewCompositionalLayout.init(section: section)
        
        return layout
    }()
    
    
    var nestedVerticalLayout: UICollectionViewCompositionalLayout = {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let layoutSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item2 = NSCollectionLayoutItem(layoutSize: layoutSize2)
        let layoutSize3 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item3 = NSCollectionLayoutItem(layoutSize: layoutSize3)

        // 右邊的子 group
        let subGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let subGroup = NSCollectionLayoutGroup.vertical(layoutSize: subGroupSize, subitems: [item2, item3])
        subGroup.interItemSpacing = .fixed(0)

        // 包含一個左邊的 item 跟右邊的子 group 的大 group
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))

        // 同時在 group 裡面放 group 跟 item 兩種 layout 物件
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item, subGroup])

        group.interItemSpacing = .fixed(0)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
        
        
        let vGroupLayoutSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: vGroupLayoutSize, subitems: [group])
        vGroup.interItemSpacing = .fixed(0)

        let section = NSCollectionLayoutSection(group: vGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
//        let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(120))
//        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
//
//        let layoutSize2 = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(55))
//        let item2 = NSCollectionLayoutItem(layoutSize: layoutSize2)
//        let layoutSize3 = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(65))
//        let item3 = NSCollectionLayoutItem(layoutSize: layoutSize3)
//
//        // 右邊的子 group
//        let subGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(120))
//        let subGroup = NSCollectionLayoutGroup.vertical(layoutSize: subGroupSize, subitems: [item2, item3])
//        subGroup.interItemSpacing = .fixed(0)
//
//        // 包含一個左邊的 item 跟右邊的子 group 的大 group
//        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(120))
//
//        // 同時在 group 裡面放 group 跟 item 兩種 layout 物件
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item, subGroup])
//
//        group.interItemSpacing = .fixed(0)
//        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
        setupDataSource()
        applySnapShot()
        viewModel.requestPhotos()
    }
}

extension CameraTestCollectionView {
    private func setupUI() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (width - 8)/3, height:(width - 8)/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0 // 左右
        layout.minimumLineSpacing = 4//上下
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(CameraTestCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CameraSection, CameraTestCollectionViewCell.PhotoObject>(collectionView: collectionView) { [weak self] collectionView, indexPath, object in
            guard let self = self else { return CameraTestCollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraTestCollectionViewCell
            
            cell.updateFrame(object: self.viewModel.cellPhotoObjects[indexPath.row])
            
            return cell
        }
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<CameraSection, CameraTestCollectionViewCell.PhotoObject>()
        snapShot.appendSections([.collection])
        snapShot.appendItems(viewModel.cellPhotoObjects)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
 
    private func bindViewModel() {
        viewModel.presentCell = { [weak self] in
            DispatchQueue.main.async {
                print("invoke presentCell")
                self?.applySnapShot()
            }
        }
    }
}


extension CameraTestCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select row: \(indexPath.row)")
    }
}

