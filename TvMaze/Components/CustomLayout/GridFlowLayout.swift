import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 250

    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
        scrollDirection = .vertical
    }

    func itemWidth() -> CGFloat {
        return collectionView!.frame.width/2 - 24
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
