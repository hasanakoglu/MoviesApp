import UIKit

class MainViewController: UIViewController {
    let tableViewController: UITableViewController = UITableViewController(style: .plain)
    var tableView: UITableView { return tableViewController.tableView }
    var viewModel: MoviesViewModelProtocol
    var coordinator: MainViewCoordinator?
    
    public init(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Top-Rated Movies"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        
        viewModel.fetchMovies { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        addChild(tableViewController)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.register(MovieImageCell.self, forCellReuseIdentifier: MovieImageCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.listOfMovies[indexPath.row]
        coordinator?.didSelect(movie: movie)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieImageCell.identifier, for: indexPath) as! MovieImageCell
        cell.selectionStyle = .none
        let movie = viewModel.listOfMovies[indexPath.row]
        
        cell.img.loadImageFromUrl(urlString: movie.fullImageString)
        cell.update(title: movie.title, image: cell.img)
        return cell
    }
}
