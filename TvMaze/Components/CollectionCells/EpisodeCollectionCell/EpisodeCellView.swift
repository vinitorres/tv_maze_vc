//
// Created by André Vinícius Torres Conrado
//

import UIKit
import SnapKit
import Kingfisher

class EpisodeCellView: UIView {
        
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var textBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return backgroundView
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        title.numberOfLines = 2
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(episode: Episode) {
        titleLabel.text = "\(episode.number) : \(episode.name)"
        bannerImage.kf.setImage(with: episode.poster)
    }

}

extension EpisodeCellView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(bannerImage)
        addSubview(textBackgroundView)
        addSubview(titleLabel)
    }
    
    func setupContraints() {
        setupBannerImageConstraints()
        setupTextBackgroundViewConstraints()
        setupTitleLabelConstraints()
    }
    
    func setupBannerImageConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(snp.width)
        }
    }
    
    func setupTextBackgroundViewConstraints() {
        textBackgroundView.snp.makeConstraints { make in
            make.bottom.equalTo(bannerImage.snp.bottom)
            make.leading.equalTo(bannerImage.snp.leading)
            make.trailing.equalTo(bannerImage.snp.trailing)
        }
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(textBackgroundView.snp.top).offset(8)
            make.bottom.equalTo(textBackgroundView.snp.bottom).inset(8)
            make.leading.equalTo(textBackgroundView.snp.leading).offset(8)
            make.trailing.equalTo(textBackgroundView.snp.trailing).inset(8)
        }
    }
    
}
