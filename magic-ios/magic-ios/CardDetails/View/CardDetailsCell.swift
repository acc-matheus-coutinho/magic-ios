//
//  CardDetailsCell.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 16/08/22.
//

import Kingfisher
import UIKit
import SnapKit

class CardDetailsCell: UICollectionViewCell {

    static let cellId = "CardDetailsCell"

    var card: Card? {
        didSet {
            let secureURL: URL? = (try? card?.imageUrl?.replacingOccurrences(of: "http://", with: "https://").asURL())
            loadingView.isHidden = false
            titleLabel.text = card?.name
            imageView.kf.setImage(with: secureURL, placeholder: placeholderImage) { _ in
                self.loadingView.stopAnimating()
                self.loadingView.isHidden = true
                self.imageView.isHidden = false
            }
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sem nome"
        label.font = .systemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()

    private lazy var loadingView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private lazy var placeholderImage = UIImage(named: "magicCardBack")

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }

    private func configureViews() {
        imageView.isHidden = true
        loadingView.startAnimating()
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(loadingView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.lessThanOrEqualToSuperview()
            make.height.greaterThanOrEqualTo(340)
        }

        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

    }

    public func configure(card: Card) {
        self.card = card
    }
}
