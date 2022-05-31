//
//  DetailMovieViewController.swift
//  BigCinema
//
//  Created by 1 on 07.04.2022.
//

import UIKit
import RealmSwift
import StatusAlert
import SDWebImage
class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var plussButtonPressed: UIButton!
    @IBOutlet weak var overviewMovieTextLabe: UILabel!
    @IBOutlet weak var textTitleMovieLabel: UILabel!
    @IBOutlet weak var posterMovieImage: UIImageView!
    @IBOutlet weak var releaseMovieTextLabel: UILabel!
    
    private let realm = try? Realm()
    var  movies: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plussButtonPressed.layer.cornerRadius = 45
        facadeUI()
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        save(movie: movies)
    }
    
    func save(movie: Movie?){
        let movieRealm = MovieRealm()
        movieRealm.title = movie?.original_title ?? ""
        movieRealm.voteAverage = movie?.vote_average ?? 0.0
        movieRealm.releaseDate = movie?.release_date ?? ""
        movieRealm.popularity = movie?.popularity ?? 0.0
        movieRealm.posterPath = movie?.poster_path ?? ""
        movieRealm.backdropPath = movie?.backdrop_path ?? ""
        movieRealm.id = String(describing:movie?.id)

        try? realm?.write{
            realm?.add(movieRealm, update: .all)
        }
        let statusAlert = StatusAlert()
        if let title = movie?.original_title {
            statusAlert.title = "\(title)saved"
        }
        statusAlert.message = "See In Watch Later"
        statusAlert.canBePickedOrDismissed = true
        statusAlert.showInKeyWindow()
    }
    func facadeUI(){
        
        textTitleMovieLabel.text = movies?.original_title
        overviewMovieTextLabe.text = movies?.overview
        if let dataReleaseMovie = movies?.release_date{
        releaseMovieTextLabel.text = "Дата релізу: \(dataReleaseMovie)"
        }
        guard let imagePath = movies?.backdrop_path else { return }
        let urlString = "https://image.tmdb.org/t/p/w200" + imagePath
        let url = URL(string: urlString)
        posterMovieImage.sd_setImage(with: url, completed: nil)
        
    }
}
