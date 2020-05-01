
import UIKit

class DetailedViewController: UIViewController {
  
  var pictureData: NasaPhotos.PhotosInfo!
  var currentNasaImage: UIImage!
  
  @IBOutlet weak var nasaPhotoImage: UIImageView!
  
  @IBOutlet weak var lable1: UILabel!
  
  @IBOutlet weak var lable2: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UISetup()
  }
  

  func UISetup() {
    navigationItem.title = pictureData.camera.name
    lable1.text = pictureData.earth_date
    lable2.text = ("Sol \(pictureData.sol)")
    nasaPhotoImage.image = currentNasaImage
  }
  
  
  
}
