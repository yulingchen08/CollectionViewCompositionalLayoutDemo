//
//  MoiveTableView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/28.
//

import UIKit

enum Section {
    case comdey
    case horror
    case action
}

struct Movie: Hashable {
    var name: String
    var actor: String
    var imageName: String
    var year: Int
}

class MovieTableView: UIViewController {
    lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), style: .insetGrouped)
        
        dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView) { tableView, indexPath, movie -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
            
            cell.updateFrame(movie: movie)
            return cell
        }
        
        tableView.dataSource = dataSource
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Movie>.init()
        snapShot.appendSections([.comdey, .horror, .action])
        //snapShot.appendItems(movies)
        snapShot.appendItems(comedyMovies, toSection: .comdey)
        snapShot.appendItems(horrorMovies, toSection: .horror)
        snapShot.appendItems(actionMoviews, toSection: .action)
        
        dataSource.apply(snapShot, animatingDifferences: true)
        
        tableView.backgroundColor = .gray
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableView.delegate = self
        return tableView
    }()
    
    var dataSource: UITableViewDiffableDataSource<Section, Movie>!
    
    let movies = [
      Movie(name: "蜘蛛人:返校日", actor: "湯姆", imageName: "ant", year: 2017),
      Movie(name: "蜘蛛人:驚奇再起", actor: "安德魯", imageName: "ant", year: 2012),
      Movie(name: "蜘蛛人", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    let comedyMovies = [
      Movie(name: "蜘蛛人:返校日", actor: "湯姆", imageName: "ant", year: 2017),
      Movie(name: "蜘蛛人:驚奇再起", actor: "安德魯", imageName: "ant", year: 2012),
      Movie(name: "蜘蛛人", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    let horrorMovies = [
        Movie(name: "恐怖故事", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "厲陰宅", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "孤兒院", actor: "陶比", imageName: "ant", year: 2002)
      ]
    
    let actionMoviews = [
        Movie(name: "玩命關頭", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "不可能的任務", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "第一滴血", actor: "陶比", imageName: "ant", year: 2002)
      ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataSource.itemIdentifier(for: <#T##IndexPath#>)
        self.view.addSubview(movieTableView)
    }
    
    
}


extension MovieTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select section: \(indexPath.section),  row: \(indexPath.row)")
    }

}
