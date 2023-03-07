//
// Created by André Vinícius Torres Conrado
//


import UIKit
import SnapKit
import Kingfisher

class EpisodeCollectionCell: UICollectionViewCell {
    
    static let identifier: String = "EpisodeCollectionCell"
    
    lazy var customView: EpisodeCellView = EpisodeCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(episode: Episode) {
        customView.prepare(episode: episode)
    }
    
}

extension EpisodeCollectionCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(customView)
    }
    
    func setupContraints() {
        setupCustomViewConstraints()
    }
    
    func setupCustomViewConstraints() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
