import Foundation

final class NasaAPIClient {
    static func getPhoto(completionHandler:@escaping ((AppError?, NasaPhotos? ) -> Void)) {
        
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&cam=navcam0&api_key=2NgfwKviUaK4gcPzk2uhFn1SRRLS4ZVX7B06kKTf"
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL("bad URL"), nil)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("2NgfwKviUaK4gcPzk2uhFn1SRRLS4ZVX7B06kKTf", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            } else if let data = data {
                do {
                    let searchData = try JSONDecoder().decode(NasaPhotos.self , from: data)
                    completionHandler(nil,searchData)
                        
                } catch {
                     completionHandler(AppError.decodingError(error), nil)
                }
                
            }
        }.resume()
    }
}
