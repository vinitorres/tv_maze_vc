//
//
// Created by André Vinícius Torres Conrado
//

import UIKit
import SnapKit

protocol FavoriteButtonDelegate {
    func backAction()
}

class FavoriteButton: UIView {
    
    var delegate: CustomBackButtonDelegate?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedBackButton() {
        delegate?.backAction()
    }
    
}

extension FavoriteButton: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(backButton)
    }
    
    func setupContraints() {
        configViewConstraints()
        configBackButtonConstraints()
    }
    
    func configViewConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    func configBackButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
}
