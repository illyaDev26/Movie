
import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let realm = try? Realm()
    var movieList: [MovieRealm] = []
    
    var moviesList: [Movie] = []
    var filterMoviesList: [Movie] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var serchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return   searchController.isActive && !serchBarIsEmpty
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        let movies = NetworkManager.shared.loadMoviesList(completion: { [self] movies in
            self.moviesList = movies
            self.tableView.reloadData()
            
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.searchTextField.backgroundColor = .yellow
            searchController.searchBar.tintColor = .yellow
            
            navigationItem.searchController = searchController
            definesPresentationContext = true
            navigationItem.hidesSearchBarWhenScrolling = false
        })
    }
    private  func getMovies()-> [MovieRealm] {
        var movies = [MovieRealm]()
        
        guard let moviesResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in moviesResult {
            movies.append(movie)
        }
        return movies
    }
}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filterMoviesList.count
        }
            return moviesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        var films: Movie
        if isFiltering {
            films = filterMoviesList[indexPath.row]
            print(filterMoviesList)
        } else {
            films =  moviesList[indexPath.row]
        }
        cell.configure(movie: films)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "DetailMovieViewController") as? DetailMovieViewController else { return }
        
        if isFiltering {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.movies = filterMoviesList[indexPath.row]
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.movies = moviesList[indexPath.row]
        }
    }
}
extension ViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterMoviesForSearchText(searchController.searchBar.text!)
    }
    private func filterMoviesForSearchText(_ searchText: String){
        filterMoviesList = moviesList.filter {
            $0.original_title!.contains(searchText)
        }
        tableView.reloadData()
    }
}
