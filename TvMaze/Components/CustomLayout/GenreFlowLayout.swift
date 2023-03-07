//
//
// Created by André Vinícius Torres Conrado
//

import UIKit

class GenreFlowLayout: UICollectionViewFlowLayout {
    
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
        estimatedItemSize = UICollectionView.layoutFittingExpandedSize
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
