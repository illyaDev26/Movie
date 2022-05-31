//
//  LaterWatchMovieViewController.swift
//  BigCinema
//
//  Created by 1 on 07.04.2022.
//

import UIKit
import RealmSwift

class LaterWatchMovieViewController: UIViewController {
    
    @IBOutlet weak var watchLaterTableView: UITableView!
    
    private let realm = try? Realm()
    var moviesList: [MovieRealm] = []
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override  func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        watchLaterTableView.dataSource = self
        watchLaterTableView.delegate = self
        watchLaterTableView.register(UINib(nibName: "WatchLaterTableViewCell", bundle: nil), forCellReuseIdentifier: "WatchLaterTableViewCell")
        watchLaterTableView.backgroundColor = UIColor(named: "back")
        print(moviesList)
        moviesList = getMovies()
        watchLaterTableView.reloadData()
        
    }
    private func getMovies()-> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let moviesResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in moviesResult {
            movies.append(movie)
        }
        return movies
    }
}
extension LaterWatchMovieViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchLaterTableView.dequeueReusableCell(withIdentifier: "WatchLaterTableViewCell", for: indexPath) as! WatchLaterTableViewCell
        cell.configure(movie: moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let myMovie = UIContextualAction(style: .destructive, title: nil) { ( _, _, complitionHand) in
            self.moviesList.remove(at: indexPath.row)
            self.watchLaterTableView.deleteRows(at: [indexPath], with: .fade)
        }
        myMovie.image = UIImage(systemName: "trash")
        myMovie.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [myMovie])
    }
}
