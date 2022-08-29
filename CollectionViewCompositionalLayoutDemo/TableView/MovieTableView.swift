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
        
        tableView.backgroundColor = .gray
        //old way to register cell
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableView.delegate = self
        return tableView
    }()
    
    //    lazy var movieTableViewiOS14: UITableView = {
    //        let tableView = UITableView(
    //            frame: CGRect(
    //                x: 0,
    //                y: 0,
    //                width: Screen.width,
    //                height: Screen.height
    //            ),
    //            style: .insetGrouped)
    //
    //        dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView, cellProvider: { tableView, indexPath, movie -> UITableViewCell in
    //
    //        })
    //        return tableView
    //    }()
    //
    //    func makeDataSourece() -> UITableViewDiffableDataSource<Section, Movie> {
    //        let parentRegistration = UITableView.CellRegistration<UITableViewCell, Movie> { cell, indexPath, movie in
    //
    //        }
    //
    //    }
    
    
    var dataSource: UITableViewDiffableDataSource<Section, Movie>!
    
    let movies = [
        Movie(name: "蜘蛛人:返校日", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "蜘蛛人:驚奇再起", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "蜘蛛人", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    var comedyMovies = [
        Movie(name: "蜘蛛人:返校日", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "蜘蛛人:驚奇再起", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "蜘蛛人", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    var horrorMovies = [
        Movie(name: "恐怖故事", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "厲陰宅", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "孤兒院", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    var actionMoviews = [
        Movie(name: "玩命關頭", actor: "湯姆", imageName: "ant", year: 2017),
        Movie(name: "不可能的任務", actor: "安德魯", imageName: "ant", year: 2012),
        Movie(name: "第一滴血", actor: "陶比", imageName: "ant", year: 2002)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        applySnapShot()
    }
    
}

extension MovieTableView {
    
    private func setupTableView() {
        //dataSource.itemIdentifier(for: <#T##IndexPath#>)
        self.view.addSubview(movieTableView)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: movieTableView) { tableView, indexPath, movie -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
            
            cell.updateFrame(movie: movie)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        movieTableView.dataSource = dataSource
    }
    
    
    func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Movie>.init()
        snapShot.appendSections([.comdey, .horror, .action])
        //snapShot.appendItems(movies)
        snapShot.appendItems(comedyMovies, toSection: .comdey)
        snapShot.appendItems(horrorMovies, toSection: .horror)
        snapShot.appendItems(actionMoviews, toSection: .action)
        
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    
}


extension MovieTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select section: \(indexPath.section),  row: \(indexPath.row)")
                
        let index = indexPath.row
        
        switch indexPath.section {
        case 0:
            self.comedyMovies.remove(at: index)
        case 1:
            self.horrorMovies.remove(at: index)
        case 2:
            self.actionMoviews.remove(at: index)
        default:
            break
        }
        applySnapShot()
    }
    
}
