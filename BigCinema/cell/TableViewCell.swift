//
//  TableViewCell.swift
//  BigCinema
//
//  Created by 1 on 05.04.2022.
//

import UIKit
import RealmSwift
import SDWebImage
import StatusAlert

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataReleaseLabel: UILabel!
    @IBOutlet weak var owerviewMediaLabel: UILabel!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var imagePosterCell: UIImageView!
    
    var _movie: Movie? = nil
    private let realm = try? Realm()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePosterCell.layer.cornerRadius = 20
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
        
        try? realm?.write {
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
    
    @IBAction func fetchButtonPressed(_ sender: Any) {
        save(movie: _movie)
    }
    func configure(movie: Movie) {
        owerviewMediaLabel.text = movie.overview
        mediaTitleLabel.text = movie.original_title
        dataReleaseLabel.text = movie.release_date
        _movie = movie
        
        guard let images = movie.poster_path else { return }
        NetworkManager.shared.setImageFor(imageView: imagePosterCell, path: images)
    }
}



