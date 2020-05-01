
import UIKit

class PicturesViewController: UIViewController {
  
  
  private var resultPicture = [NasaPhotos.PhotosInfo]() {
    didSet {
      DispatchQueue.main.async {
        self.myTableView.reloadData()
      }
    }
  }
  
  
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
    delegationSetup()
  }
  
  func delegationSetup() {
    myTableView.dataSource = self
    myTableView.delegate = self
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
    guard let indexPath = myTableView.indexPathForSelectedRow,
      let destination = segue.destination as? DetailedViewController else { fatalError("indexPath, detailVC nil") }
    let dataToSend = resultPicture[indexPath.row]
    let imageToSend = pictures[indexPath.row]
    destination.pictureData = dataToSend
    destination.currentNasaImage = imageToSend
  }
}

extension PicturesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PicturesCell", for: indexPath) as? PicturesCell else { return UITableViewCell() }
    let singleObject = resultPicture[indexPath.row]
    let singleImage = pictures[indexPath.row]
    
    cell.NasaImage.image = singleImage
    cell.writenData.text = ("Camera \(singleObject.camera.name)")
    cell.solsTextLabel.text = "Sol \(singleObject.sol)"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 400
  }
  
}

