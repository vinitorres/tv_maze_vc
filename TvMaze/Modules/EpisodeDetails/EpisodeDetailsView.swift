//
//
// Created by André Vinícius Torres Conrado
//


import UIKit
import Kingfisher
import SnapKit

class EpisodeDetailsView: UIView {
    
    var onClose: (() -> Void)?
    
    lazy var mainView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
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
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
        
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Summary"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var summaryTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(onCloseTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    func prepare(episode: Episode, onClose:(() -> Void)?) {
        self.onClose = onClose
        bannerImage.kf.setImage(with: episode.poster)
        titleLabel.text = episode.name
        seasonLabel.text = "Season \(episode.season) - Episode \(episode.number)"
        summaryTextLabel.text = episode.summary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onCloseTapped() {
        onClose?()
    }
}

extension EpisodeDetailsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(mainView)
        mainView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(bannerImage)
        mainStackView.addArrangedSubview(infoContainerView)
        mainStackView.addArrangedSubview(closeButton)

        infoContainerView.addSubview(infoStackView)

        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(seasonLabel)
        infoStackView.addArrangedSubview(summaryLabel)
        infoStackView.addArrangedSubview(summaryTextLabel)
    }
    
    func setupContraints() {
        configMainViewConstraints()
        configMainStackViewConstraints()
        configInfoStackViewConstraints()
        configBannerImageConstraints()
        configCloseButtonConstraints()
    }
    
    func configMainViewConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        mainView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(screenWidth - 40)
        }
    }
    
    func configMainStackViewConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        bannerImage.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
    }
    
    func configCloseButtonConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
}
