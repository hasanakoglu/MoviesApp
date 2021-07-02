import UIKit

class MovieDetailsViewController: UITableViewController {
    private let movie: Movie
    private var viewModel: MovieDetailsViewModelProtocol
    
    init(movie: Movie, viewModel: MovieDetailsViewModelProtocol = MovieDetailsViewModel()) {
        self.movie = movie
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = movie.title
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        viewModel.viewWillAppear()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(MovieDetailsTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
}

extension MovieDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.reuseIdentifier, for: indexPath) as? MovieDetailsTableViewCell else { return UITableViewCell() }
        
        cell.favouriteButton.isSelected = viewModel.buttonSelectedState(movie: movie)
        cell.update(with: movie)
        cell.handler = { sender in
            if sender.isSelected {
                self.viewModel.addToFavourites(movie: self.movie)
            } else {
                self.viewModel.removeFromFavourites(movie: self.movie)
            }
        }
        return cell
    }
}
