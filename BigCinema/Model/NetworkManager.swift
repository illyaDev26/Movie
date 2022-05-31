//
//  NetworkManager.swift
//  BigCinema
//
//  Created by 1 on 05.04.2022.
//

import Foundation
import Alamofire
import SDWebImage

struct NetworkManager {
    
    static let shared = NetworkManager()
    private init(){ }
    
    func loadMoviesList(completion: @escaping(([Movie])->())) {
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=96cfbe0ba15c4721bca8030e8e32becb"
        
        AF.request(url).responseJSON { responce in
            do{
                let allData = try JSONDecoder().decode(Movies.self, from: responce.data!)
                print(allData.results?.first! as Any)
                completion(allData.results ?? [])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
// MARK: - SDWebImage function.

extension NetworkManager {
    func setImageFor(imageView: UIImageView, path: String) {
        let stringURL = "https://image.tmdb.org/t/p/w500" + path
        guard let url = URL(string: stringURL) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }
}
