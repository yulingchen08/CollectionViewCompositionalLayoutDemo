//
//  CameraCollecionViewModel.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/2.
//

import Foundation


class CameraCollectionViewModel {
    let network = NetworkService.shared
    var presentCell: (() -> Void)? = nil
    var cellObjects = [CameraCollectionViewCell.Object]()
    
    
    func requestCollections() {
        //network.login()
        network.requestCollections { [weak self] result in
            switch result {
            case .success(let featureCollection):
                print("Success: \(featureCollection)")
                self?.processCellObject(featureCollection: featureCollection)
            case .failure(let error):
                print("failure: \(error)")
            }
            
        }
    }
    
    private func processCellObject(featureCollection: FeaturedCollection) {
        var objects = [CameraCollectionViewCell.Object]()
        featureCollection.collections.forEach {
            let cellObject = CameraCollectionViewCell.Object(id: $0.id, title: $0.title)
            objects.append(cellObject)
        }
        
        self.cellObjects = objects
        self.presentCell?()
    }
    
    
}
