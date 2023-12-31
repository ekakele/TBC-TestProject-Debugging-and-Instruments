//
//  NewsTableViewCell.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import UIKit
import Kingfisher

final class NewsTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 117).isActive = true
        return imageView
    }()
    
    private var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
#warning("მოულოდნელი მახე, რა თქმა უნდა, უნდა ჩავაკომენტაროთ, რომ ეკრანზე გამოჩნდეს news-ის title.")
        //        label.isHidden = true
        return label
    }()
    
    private var newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsTitleLabel, newsAuthorLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - init
#warning("აქ ერორდება იმის გამო, რომ მოცემული init წარმოადგენს UITableViewCell-ის ინიციალიზატორს, მაშინ, როცა NewsTableViewCell-ს კლასი ფაილში წარმოდგენილია, როგორც UICollectionViewCell შვილობილი კლასი. შესაბამისად, ეს კლასი ვერ მიიღებს მემკვიდრეობით და ვერ შეცვლის UITableViewCell-ის აქ წარმოდგენილ მეთოდს. თუ ზემოთ გავასწორებთ სუპერკლასს, პრობლემაც მოგვარდება და init-ის override-იც შესაბამისობაში მოვა UITableViewCell-ის შვილობილ კლასთანაც.")
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
#warning("ჩასამატებელია prepareForReuse() ფუქნცია reusable cell-ების გასასუფთავებლად, რაც უზურნველყოფს cell-ში არსებული დინამიური data-ს წაშლას ამ cell-ის ხელახლა შეუფერხებლად გამოყენების მიზნით.")
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.image = nil
        newsTitleLabel.text = nil
        newsAuthorLabel.text = nil
    }
    
    // MARK: - Setup
    private func setupSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
#warning("არასწორად გაწერილი left და right Anchor-ები")
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            //            mainStackView.leadingAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            //            mainStackView.trailingAnchor.constraint(equalTo: contentView.leftAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure
#warning("configure ფუნქციის access level უნდა შეიცვლაოს private-დან internal-მდე, რათა კონტროლერმა შეძლოს მიწვდეს ამ ფუქციას და ამ ფუქნციის საშუალებით დაუსეტოს cell-ის property-ებს ინფორმაცია.")
    func configure(with news: News) {
        let url = URL(string: news.urlToImage ?? "")
        newsImageView.kf.setImage(with: url)
        newsTitleLabel.text = news.title
        newsAuthorLabel.text = news.author
    }
}


