//
//
// Created by André Vinícius Torres Conrado
//


import UIKit
import SnapKit
import Kingfisher

class ActorCellView: UIView {
        
    var actor: Actor?
    
    lazy var thumbImage: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 70
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(actor: Actor) {
        nameLabel.text = actor.name
        thumbImage.kf.setImage(with: actor.thumb)
    }
    
}

extension ActorCellView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(thumbImage)
        addSubview(nameLabel)
    }
    
    func setupContraints() {
        configThumbImageConstraints()
        configNameLabelConstraints()
    }
    
    func configThumbImageConstraints() {
        thumbImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(140)
            make.width.equalTo(140)
        }
    }
    
    func configNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImage.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
}
