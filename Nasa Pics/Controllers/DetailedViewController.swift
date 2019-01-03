//
//  DetailedViewController.swift
//  Nasa Pics
//
//  Created by Olimpia on 1/3/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var currentPhoto: NasaPhotos.PhotosInfo!
    var currentNasaImage: UIImage!
   
    @IBOutlet weak var nasaPhotoImage: UIImageView!
  
    @IBOutlet weak var lable1: UILabel!
    
    @IBOutlet weak var lable2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       title = currentPhoto.camera.name
        lable1.text = currentPhoto.earth_date
        lable2.text = ("Sol \(currentPhoto.sol)")
        
nasaPhotoImage.image = currentNasaImage
        
        
    }
    

   

}
