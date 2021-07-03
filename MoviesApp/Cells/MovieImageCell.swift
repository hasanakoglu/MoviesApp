import Foundation
import UIKit

final class MovieImageCell: UITableViewCell {
    static let identifier: String = "cell"
    let cardView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var dateLabel: UILabel = UILabel()
    var ratingLabel: UILabel = UILabel()
    var ratingImageView: UIImageView = UIImageView()
    var posterImg: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func update(title: String?, image: UIImageView?, year: String?, rating: Double?) {
        guard let year = year else { return }
        guard let rating = rating else { return }
        titleLabel.text = title
        dateLabel.text = "Release Date: " + year
        ratingLabel.text = "\(rating)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.addSubview(cardView)
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6
        cardView.layer.shadowOpacity = 0.8
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        cardView.addSubview(posterImg)
        posterImg.translatesAutoresizingMaskIntoConstraints = false
        posterImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        posterImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        posterImg.heightAnchor.constraint(equalToConstant: 150).isActive = true
        posterImg.widthAnchor.constraint(equalToConstant: 120).isActive = true
        posterImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        cardView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImg.trailingAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        cardView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: posterImg.trailingAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        cardView.addSubview(ratingImageView)
        ratingImageView.image = UIImage(systemName: "star.fill")
        ratingImageView.tintColor = .systemYellow
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.leadingAnchor.constraint(equalTo: posterImg.trailingAnchor, constant: 5).isActive = true
        ratingImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ratingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        cardView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = .black
        ratingLabel.numberOfLines = 0
        
        ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 5).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
}
