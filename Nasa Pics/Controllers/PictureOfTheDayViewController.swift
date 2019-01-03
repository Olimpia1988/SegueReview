//
//  PictureOfTheDayViewController.swift
//  Nasa Pics
//
//  Created by Olimpia on 1/3/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import UIKit

class PictureOfTheDayViewController: UIViewController {
    
    private var picOfTheDay: DailyPhoto?
    
   
   
    @IBOutlet weak var dayPicture: UIImageView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var label1: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
       
        
    }
    
    
    private func fetchData() {
        DayPhotoApiClient.getDayPhoto { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.picOfTheDay = data
                self.getSecondPic()
            }
        }
        
   
      
}
    func getSecondPic() {
    SecondImageHelper.secondPicture(strUrl: (picOfTheDay?.url)!) { (error, theOne) in
    DispatchQueue.main.async {
    if let theOne = theOne {
    self.dayPicture.image = theOne
        self.text.text = self.picOfTheDay?.explanation
        self.label1.text = self.picOfTheDay?.title
    }
    }
    
    }
    }
    

}


    

