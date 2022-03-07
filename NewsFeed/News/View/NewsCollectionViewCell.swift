//
//  NewsCollectionViewCell.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 08/02/22.
//

import UIKit
import Combine
import ImageCacheKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let nibName = "NewsCollectionViewCell"
    private var cancellable: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        articleImageView.image = nil
        super.prepareForReuse()
    }
    
    func configure(articleItem: ArticleItem) {
       titleLabel.text = articleItem.title
       descriptionLabel.text = articleItem.description
        cancellable = loadImage(from: articleItem).receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] image in
            self?.articleImageView.image = image == nil ? UIImage(named: "PlaceholderImage") : image
       })
    }
    
    func loadImage(from articleItem: ArticleItem) -> AnyPublisher<UIImage?, Never> {
        return Just(articleItem.urlToImage).flatMap({ urlToImage -> AnyPublisher<UIImage?, Never> in
            if let url = URL(string: urlToImage ?? "") {
                return ImageLoader.shared.loadImage(from: url)
            }
            return Just(nil).eraseToAnyPublisher()
        }).eraseToAnyPublisher()
    }
    
}

extension UIView {
    func commonInit(nibName: String) {
        if let view = loadViewFromNib(nibName: nibName) {
            view.addAsSubviewWithEqualConstraints(to: self)
        }
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addAsSubviewWithEqualConstraints(to containerView: UIView) {
        self.frame = containerView.bounds
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
        ])
    }
}


