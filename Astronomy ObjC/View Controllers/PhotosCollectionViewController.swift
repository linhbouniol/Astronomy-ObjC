//
//  PhotosCollectionViewController.swift
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    let solLabel = UILabel()
    
    private let marsController = LTBMarsController()
    private let cache = LTBCache<NSNumber, UIImage>()
    private let fetchPhotoQueue = OperationQueue()
    private var operations = [Int : Operation]()
    
    private var roverInfo: LTBRover? {
        didSet {
            solDescription = roverInfo?.solDescriptions.first // if empty it wont crash (first instead of [0])
        }
    }

    private var solDescription: LTBSolDescription? {
        didSet {
            if let rover = roverInfo,
                let sol = solDescription?.sol {
                photoReferences = []
                
                marsController.fetchPhotos(from: rover, onSol: sol) { (photos, error) in
                    if let error = error {
                        NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(error)")
                        return
                    }
                    self.photoReferences = photos ?? []
                    self.updateViews()
                }
            }
        }
    }
    
    private var photoReferences = [LTBPhoto]() {
        didSet {
            cache.clear()
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        marsController.fetchRover(withName: "curiosity") { (rover, error) in
            if let error = error {
                NSLog("Error fetching info for curiosity: \(error)")
                return
            }
            self.roverInfo = rover
        }
        
        configureTitleView()
        updateViews()
    }
    
    private func configureTitleView() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]
        
        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(solDescription?.sol ?? 0)"
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.index(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.index(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDescription = solDescriptions[index+1]
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! LTBPhotoCollectionViewCell
        
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }

    private func loadImage(forCell cell: LTBPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoReference = photoReferences[indexPath.item]
        
        if let cachedImage = cache.value(forKey: photoReference.photoId as NSNumber) {
            cell.photoView?.image = cachedImage
            return
        }
        
        // Start an operation to fetch image data
        let fetchOperation = LTBFetchPhotoOperation(photo: photoReference)
        let cacheOperation = BlockOperation {
            if let image = fetchOperation.image {
                self.cache.cache(withValue: image, key: photoReference.photoId as NSNumber)
            }
        }
        let completionOperation = BlockOperation {
            defer { self.operations.removeValue(forKey: photoReference.photoId) }
            
            if let currentIndexPath = self.collectionView?.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            
            if let image = fetchOperation.image {
                cell.photoView?.image = image
            }
        }
        
        cacheOperation.addDependency(fetchOperation)
        completionOperation.addDependency(fetchOperation)
        
        fetchPhotoQueue.addOperation(fetchOperation)
        fetchPhotoQueue.addOperation(cacheOperation)
        OperationQueue.main.addOperation(completionOperation)
        
        operations[photoReference.photoId] = fetchOperation
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PhotoDetailViewController
            detailVC.photo = photoReferences[indexPath.item]
        }
    }
}
