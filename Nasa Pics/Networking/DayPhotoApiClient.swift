
import Foundation

final class DayPhotoApiClient {
    static func getDayPhoto(completionHandler: @escaping((AppError?, DailyPhoto?) -> Void)) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=2NgfwKviUaK4gcPzk2uhFn1SRRLS4ZVX7B06kKTf"
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL("bad URL"), nil)
            return
        }
        var urlRequest = URLRequest(url: url)
        
       urlRequest.addValue("2NgfwKviUaK4gcPzk2uhFn1SRRLS4ZVX7B06kKTf", forHTTPHeaderField: "Autorizathion")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            } else if let data = data {
                do {
                    let photoData = try JSONDecoder().decode(DailyPhoto.self, from: data)
                    completionHandler(nil, photoData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            
        }.resume()
        
       
    }
}

