//
//  WatchLaterTableViewCell.swift
//  BigCinema
//
//  Created by 1 on 08.04.2022.
//

import UIKit
import  SDWebImage
class WatchLaterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var datareleaseTextLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(movie: MovieRealm?) {
        titleTextLabel.text = movie?.title
        datareleaseTextLabel.text = movie?.releaseDate
        
        guard let imagePath = movie?.posterPath else { return }
        NetworkManager.shared.setImageFor(imageView: posterImage, path: imagePath)

    }
}
