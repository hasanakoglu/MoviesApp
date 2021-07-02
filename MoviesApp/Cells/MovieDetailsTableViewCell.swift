import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = UILabel()
    private let movieImageView: UIImageView = UIImageView()
    private let button = UIButton()
    
    var movieDescriptionURL: URL?
    let descriptionLabel: UILabel = UILabel()
    let favouriteButton = UIButton()
    var handler: ((UIButton) -> Void)?
    
    static let reuseIdentifier = "movieDetails"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(button)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.numberOfLines = 0
        movieImageView.contentMode = .scaleAspectFit
        button.setTitle("Website", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favouriteButton.addTarget(self, action: #selector(favouritesButtonPressed(sender:)), for: .touchUpInside)
        favouriteButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30).isActive = true
        favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        favouriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favouriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        
        button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50.0).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func update(with movie: Movie) {
        nameLabel.text = movie.title
        descriptionLabel.text = movie.overview == "" ? "No Description" : movie.overview
        guard let urlString = movie.title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        movieDescriptionURL = URL(string: "https://m.imdb.com/find?q=\(urlString)")
        movieImageView.loadImageFromUrl(urlString: movie.fullImageString)
        updateConstraints()
    }
    
    @objc func buttonTapped() {
        guard let url = movieDescriptionURL else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func favouritesButtonPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.handler?(sender)
    }
}
