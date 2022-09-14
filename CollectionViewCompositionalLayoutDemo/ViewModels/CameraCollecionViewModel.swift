//
//  CameraCollecionViewModel.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/2.
//

import Foundation
import UIKit


class CameraCollectionViewModel {
    let network = NetworkService.shared
    var presentCell: (() -> Void)? = nil
    var cellObjects = [CameraCollectionViewCell.Object]()
    var cellPhotoObjects = [CameraCollectionViewCell.PhotoObject]()
    
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
      
    func requestPhotos() {
        network.requestPhotos { [weak self] in
            switch $0 {
            case .success(let curatedPhoto):
                print("requestPhotos success: \(curatedPhoto)")
                self?.processCuratedPhotos(curatedPhoto: curatedPhoto)
            case .failure(let error):
                print("requestPhotos failure: \(error)")
            }
        }
    }
    
    func requestPhoto(perPage: Int) {
        network.requestPhotos(perPage: 1) { [weak self] in
            switch $0 {
            case .success(let curatedPhoto):
                print("requestPhotos success: \(curatedPhoto)")
                self?.processCuratedPhotos(curatedPhoto: curatedPhoto)
            case .failure(let error):
                print("requestPhotos failure: \(error)")
            }
        }
    }
    
}

extension CameraCollectionViewModel {
    private func processCellObject(featureCollection: FeaturedCollection) {
        var objects = [CameraCollectionViewCell.Object]()
        featureCollection.collections.forEach {
            let cellObject = CameraCollectionViewCell.Object(id: $0.id, title: $0.title)
            objects.append(cellObject)
        }
        
        self.cellObjects = objects
        self.presentCell?()
    }
    
    private func processCuratedPhotos(curatedPhoto: CuratedPhoto) {
        var objects = [CameraCollectionViewCell.PhotoObject]()
        curatedPhoto.photos.forEach {
            let photoUrl = $0.src.tiny
            let id = $0.id
            let cellObject = CameraCollectionViewCell.PhotoObject(id: id, url: photoUrl)
            objects.append(cellObject)
        }
        
        self.cellPhotoObjects = objects
        downloadPhotos()
    }
    
    
    private func downloadPhotos() {
        for i in 0..<self.cellPhotoObjects.count {
            network.downloadImage(url: cellPhotoObjects[i].url, completion: { [weak self] image in
                self?.cellPhotoObjects[i].image = image
                self?.presentCell?()
            })
        }
                                
    }
}
