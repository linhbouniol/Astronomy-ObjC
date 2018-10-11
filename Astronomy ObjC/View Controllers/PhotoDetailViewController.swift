//
//  PhotoDetailViewController.swift
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController {
    
    var photo: LTBPhoto? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    @IBAction func save(_ sender: Any) {
        guard let image = photoView.image else { return }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { (success, error) in
            if let error = error {
                NSLog("Error saving photo: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.presentSuccessfulSaveAlert()
            }
        })
    }
    
    func presentSuccessfulSaveAlert() {
        let alert = UIAlertController(title: "Photo Saved!", message: "The photo has been saved to your Photo Library!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard let photo = photo, isViewLoaded else { return }
        
        do {
            let data = try Data(contentsOf: (photo.imageURL as NSURL).https)
            photoView.image = UIImage(data: data)
//            let dateString = dateFormatter.string(from: photo.earthDate)
            detailLabel.text = "Taken by \(photo.camera.roverId) on \(photo.earthDate) (Sol \(photo.sol))"
            cameraLabel.text = photo.camera.fullName
        } catch {
            NSLog("Error setting up views on detail view controller: \(error)")
        }
    }
}
