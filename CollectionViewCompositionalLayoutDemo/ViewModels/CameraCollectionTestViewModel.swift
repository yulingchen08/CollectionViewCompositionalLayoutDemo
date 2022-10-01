//
//  CameraCollectionTestViewModel.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/18.
//

import Foundation

class CameraCollectionTestViewModel {
    let network = NetworkService()
    var cellPhotoObjects = [CameraTestCollectionViewCell.PhotoObject]()
    var presentCell: (() -> Void)? = nil
    
    
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
}


extension CameraCollectionTestViewModel {
    private func processCuratedPhotos(curatedPhoto: CuratedPhoto) {
        var objects = [CameraTestCollectionViewCell.PhotoObject]()
        curatedPhoto.photos.forEach {
            let photoUrl = $0.src.tiny
            let id = $0.id
            let cellObject = CameraTestCollectionViewCell.PhotoObject(id: id, url: photoUrl)
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
