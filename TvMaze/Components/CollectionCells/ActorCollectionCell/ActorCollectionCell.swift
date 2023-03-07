//
//
// Created by André Vinícius Torres Conrado
//


import UIKit
import SnapKit

class ActorCollectionCell: UICollectionViewCell {
    
    static let identifier: String = "ActorCollectionCell"
    
    var actor: Actor?
    
    lazy var customView: ActorCellView = {
        var view = ActorCellView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(actor: Actor) {
        customView.prepare(actor: actor)
    }
    
}

extension ActorCollectionCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(customView)
    }
    
    func setupContraints() {
        configCustomViewConstraints()
    }
    
    func configCustomViewConstraints() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
