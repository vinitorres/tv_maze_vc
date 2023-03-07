//
//
// Created by André Vinícius Torres Conrado
//

import UIKit

class CastFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 180

    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        minimumInteritemSpacing = 16
        scrollDirection = .horizontal
    }

    func itemWidth() -> CGFloat {
        return 140
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
