//
//  CameraCollectionView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/17.
//

import UIKit

class CameraCollectionView: UIViewController {
    var collectionView: UICollectionView!
    
    let viewModel = CameraCollectionViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Section, CameraCollectionViewCell.PhotoObject>!
    let cameras: [CameraDTO] = [CameraDTO(id: 1, name: "Cannon"),
                                CameraDTO(id: 2, name: "Cannon"),
                                CameraDTO(id: 3, name: "Cannon"),
                                CameraDTO(id: 4, name: "Cannon"),
                                CameraDTO(id: 5, name: "Cannon"),
                                CameraDTO(id: 6, name: "Cannon"),
                                CameraDTO(id: 7, name: "Cannon"),
                                CameraDTO(id: 8, name: "Cannon"),
                                CameraDTO(id: 9, name: "Cannon"),
                                CameraDTO(id: 10, name: "Cannon"),
                                CameraDTO(id: 11, name: "Cannon"),
                                CameraDTO(id: 12, name: "Cannon"),
                                CameraDTO(id: 13, name: "Cannon"),
                                CameraDTO(id: 14, name: "Cannon"),
                                CameraDTO(id: 15, name: "Cannon"),
                    ]
    
    lazy var horizontalOneRowLayout: UICollectionViewLayout = {
        /// 4
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .absolute(120)
        )

        // 3 group 的功用，就是把一個或多個 item 圈在一起，利用這個特性，我們就可以做出許許多多的變化
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        //the amount of the sapce between the items in the group
        //item中間的空格大小
        //group.interItemSpacing = .fixed(8)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: nil,
            trailing: .fixed(8),
            bottom: nil
        )

        /// 2
        let section = NSCollectionLayoutSection(group: group)
        //一旦被設定， CollectionView 的 section 實作會變成一個特別的橫向 scroll view
        //要讓這個 section 可以與 CollectionView 滾動的 90 度方向滾動
        section.orthogonalScrollingBehavior = .continuous
        //增加section的邊緣空間
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        /// 1
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var multiItemSizeLayout: UICollectionViewLayout = {
        
        //header
        // 設定 header 的大小
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))

        // 負責描述 supplementary item 的物件
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: -5)
        )
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom,
            absoluteOffset: CGPoint(x: 0, y: -5)
        )
        
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(45))
        let mediumItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(65))
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(85))
        
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        let mediumItem = NSCollectionLayoutItem(layoutSize: mediumItemSize)
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        // 給剛好大小的 group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(205))
        // 用 .vertical 指明我們的 group 是垂直排列的
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [smallItem, mediumItem, largeItem])
        // 這裡指的是垂直的間距了，此為item和item之間的距離
        group.interItemSpacing = .fixed(5)
        //group和 group之間的距離
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        section.boundarySupplementaryItems = [headerItem, footerItem]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var nestedGroupLayout: UICollectionViewLayout = {
        
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(30), heightDimension: .absolute(30))
        let badgeContainerAnchor = NSCollectionLayoutAnchor(edges: [.top, .leading], absoluteOffset: CGPoint(x: 10, y: 10))
        let badgeItemAnchor = NSCollectionLayoutAnchor(edges: [.bottom, .trailing], absoluteOffset: CGPoint(x: 0, y: 0))

        let badgeItem = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: BadgeView.reuseIdentifier, containerAnchor: badgeContainerAnchor, itemAnchor: badgeItemAnchor)
        
        
        let leftItemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(120))
        let leftItem = NSCollectionLayoutItem(layoutSize: leftItemSize, supplementaryItems: [badgeItem])
        
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
    
    lazy var decorationGroupLayout: UICollectionViewLayout = {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top, absoluteOffset: CGPoint(x: 0, y: 0))
        
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgorundDecorationView.elementKind)
        decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 10, bottom: 10, trailing: 10)
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.05))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(5), top: .fixed(5), trailing: .flexible(5), bottom: nil)
        //用edgeSpacing，可以調整item是否置中的問題，左右邊都用.flexbile(5)，就是會>= 5，看可利用空間，有可能結果會比5大，有點像是swiftUI的spacer()
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(20)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(15), top: .flexible(40), trailing: .flexible(5), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.decorationItems = [decorationItem]
        section.boundarySupplementaryItems = [header]
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(SectionBackgorundDecorationView.self, forDecorationViewOfKind: SectionBackgorundDecorationView.elementKind)
        return layout
    }()
    
    
    lazy var customLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let height: CGFloat = 120.0
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height)) //這邊給gourp的傯width和height，下面在用這個height去除，比例分配給小group
        let group = NSCollectionLayoutGroup.custom(
            layoutSize: groupLayoutSize,
            itemProvider: { env -> [NSCollectionLayoutGroupCustomItem] in
                let size = env.container.contentSize
                let spacing: CGFloat = 8.0
                let itemWidth = (size.width-spacing*4)/3.0
                
                return [NSCollectionLayoutGroupCustomItem(frame: CGRect(x: 0, y: 0, width: itemWidth, height: height/3.0)),
                        NSCollectionLayoutGroupCustomItem(frame: CGRect(x: itemWidth+spacing, y: height/3.0, width: itemWidth, height: height/3.0)),
                        NSCollectionLayoutGroupCustomItem(frame: CGRect(x: (itemWidth+spacing)*2, y: height*2/3.0, width: itemWidth, height: height/3.0))
               ]
        })
                
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        //從原本輸入一個靜態的 section 元件，改成輸入一個 closure，這個 closure 負責接收 section 的 index 跟容器的 environment，回傳對應的 section layout 元件。使用上會長這個樣子：
        //這個程式會根據不同的 section，回傳組好的 section layout 元件。有了這個 section provider 之後，我們就可以不用在創造 CollectionView 的時候決定好所有的 layout，某些設計的變化可以透過 section provider 在下一個 collection layout 循環時再提供就 ok 了。
        let layout2 = UICollectionViewCompositionalLayout.init(sectionProvider: {
            (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return section
            default:
                return section
            }
            
        })
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Doing setupUI")
        setupUI()
        setupdataSource()
        bindViewModel()
        viewModel.requestCollections()
        viewModel.requestPhotos()
    }
}

//private
extension CameraCollectionView {
    
    
    enum Section {
        case collection
    }
    
    private func setupUI() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (width - 30) / 2  , height: 120)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 2)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        
        collectionView.register(BadgeView.self, forSupplementaryViewOfKind: BadgeView.reuseIdentifier, withReuseIdentifier: "badge")
        self.view.addSubview(collectionView)
        
    }
    
    
    private func bindViewModel() {
        viewModel.presentCell = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                //self.collectionView.reloadData()
                self.applySnapChat()
            }
        }
    }
    
    private func setupdataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CameraCollectionViewCell.PhotoObject>(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, object -> CameraCollectionViewCell in
            guard let self = self else { return CameraCollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraCollectionViewCell
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
            //cell.updateFrame(object: self.viewModel.cellObjects[indexPath.row])
            cell.updatePhotoFrame(object: self.viewModel.cellPhotoObjects[indexPath.row])
            return cell
        })
    }
    
    private func applySnapChat() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, CameraCollectionViewCell.PhotoObject>()
        snapShot.appendSections([.collection])
        //snapShot.appendItems(viewModel.cellObjects, toSection: .collection)
        snapShot.appendItems(viewModel.cellPhotoObjects, toSection: .collection)
        dataSource.apply(snapShot, animatingDifferences: true)
        
    }
}


extension CameraCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select row: \(indexPath.row)")
    }
}

/*
extension CameraCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraCollectionViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        cell.updateFrame(object: viewModel.cellObjects[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //Create UICollectionReusableView
        var reusableView = UICollectionReusableView()
        
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 60,
                                          height: 40))
        label.textAlignment = .center
        
        if kind == UICollectionView.elementKindSectionHeader {
            // header
            reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "Header",
                for: indexPath
            )
            //header content
            reusableView.backgroundColor = UIColor.black
            label.text = "Header";
            label.textColor = UIColor.white
        } else if kind == UICollectionView.elementKindSectionFooter {
            // footer
            reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "Footer",
                for: indexPath)
            //footer content
            reusableView.backgroundColor = UIColor.cyan
            label.text = "Footer";
            label.textColor = UIColor.black
        } else if kind == BadgeView.reuseIdentifier {
            let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: BadgeView.reuseIdentifier, withReuseIdentifier: "badge", for: indexPath) as! BadgeView
           
            badgeView.backgroundColor = .blue
            return badgeView
        }
        reusableView.addSubview(label)
        return reusableView
    }
}

*/
//要當header或footer的圖片都繼承UICollectionReusableView去做
class BadgeView: UICollectionReusableView {
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.text = String(Int.random(in: 1...9))
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed

        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
    }
}



extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
}



class SectionBackgorundDecorationView: UICollectionReusableView {
    static var elementKind: String {
        String(describing: Self.self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
