//
//  ViewController.swift
//  Nasa Pics
//
//  Created by Olimpia on 12/30/18.
//  Copyright © 2018 Olimpia. All rights reserved.
//

import UIKit

class PicturesViewController: UIViewController {
    
   
    private var resultPicture = [NasaPhotos.PhotosInfo]()
    
    
private var pictures = [UIImage](){
    didSet {
        DispatchQueue.main.async {
            self.myTableView.reloadData() 
            
        }
        
    }
    }


    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giveUsTheData()
        myTableView.dataSource = self
        title = "NASA Images"
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //create an ok action
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        
        //present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    private func giveUsTheData(){
        NasaAPIClient.getPhoto { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else  if let  data = data {
                self.resultPicture = data.photos
                
                for i in self.resultPicture {
                ImageHelper.thePicture(stringUrl: i.img_src) { (error, onLineImage) in
                    if let onLineImage = onLineImage {
                    self.pictures.append(onLineImage)
                    }
                    }
                }
        }
    }

}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailedViewController else { return }
        let storedInfo = resultPicture[myTableView.indexPathForSelectedRow!.row]
        destination.currentPhoto = storedInfo
        guard let photoDestination = segue.destination as? DetailedViewController else { return }
        let storedPicture = pictures[myTableView.indexPathForSelectedRow!.row]
       photoDestination.currentNasaImage = storedPicture
    }
}

extension PicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier:"NiceCell", for: indexPath)
        let images = resultPicture[indexPath.row]
        let imagesToSet = pictures[indexPath.row]
       cell.textLabel?.text = ("Camera \(images.camera.name)")
        cell.detailTextLabel?.text = "Sol \(images.sol)"
        cell.imageView?.image = imagesToSet
            
        
        return cell
    }
    
    
}

