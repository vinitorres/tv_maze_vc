//
//
// Created by André Vinícius Torres Conrado
//


import UIKit
import SnapKit

class GenreCollectionCell: UICollectionViewCell {
    
    static let identifier: String = "GenreCollectionCell"
    
    lazy var customView: GenreCellView = GenreCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(genre: String) {
        customView.prepare(genre: genre)
    }

}

extension GenreCollectionCell: ViewConfiguration {
    
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
