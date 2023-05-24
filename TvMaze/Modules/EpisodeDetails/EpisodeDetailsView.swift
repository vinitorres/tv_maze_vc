//
//
// Created by André Vinícius Torres Conrado
//


import UIKit
import Kingfisher
import SnapKit

class EpisodeDetailsView: UIView {
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var infoContainerView = UIView()
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_placeholder")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.numberOfLines = 2
        return title
    }()
    
    lazy var seasonLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 22)
        title.numberOfLines = 2
        return title
    }()
        
    lazy var summaryLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.text = "Summary"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        return title
    }()
    
    lazy var summaryTextLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.text = "AH S9HDOAHSDHAJSHDAHSDHJI JASID J{AJS9 FJ0SDJ F0AWJDS0[ J[j 90fsdj09f js09djf 90sjd9 f0js90dj fjs0d fsda f"
        title.font = UIFont.systemFont(ofSize: 14)
        return title
    }()
    
    lazy var backButton: CustomBackButton = {
        let customBackButton = CustomBackButton()
        return customBackButton
    }()
    
    func prepare(episode: Episode) {
        //bannerImage.kf.setImage(with: episode.image)
        titleLabel.text = episode.name
        summaryTextLabel.text = episode.summary
    }
}

extension EpisodeDetailsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(bannerImage)
        mainStackView.addArrangedSubview(infoContainerView)
        
        infoContainerView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(seasonLabel)
        infoStackView.addArrangedSubview(summaryLabel)
        infoStackView.addArrangedSubview(summaryTextLabel)

    }
    
    func setupContraints() {
        configMainStackViewConstraints()
        configInfoStackViewConstraints()
        configBannerImageConstraints()
    }
    
    func configMainStackViewConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.snp.width)
        }
    }
    
    func configInfoStackViewConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configBannerImageConstraints() {
//        bannerImage.snp.makeConstraints { make in
//            make.top.equalTo(imageContainerView.snp.top)
//            make.bottom.equalTo(imageContainerView.snp.bottom)
//            make.leading.equalTo(imageContainerView.snp.leading)
//            make.trailing.equalTo(imageContainerView.snp.trailing)
//        }
    }
    
}
