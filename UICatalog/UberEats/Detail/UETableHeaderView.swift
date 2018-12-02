//
//  UETableHeaderView.swift
//  UICatalog
//

import UIKit

class UETableHeaderView: UIView {
    
    var imageView = UIImageView()
    
    var imageSize: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: ((screenWidth * 250) / 375))
    }
    
    private var size: CGSize {
        return CGSize(width: imageSize.width, height: imageSize.height + 80)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    // MARK: Public
    func updateScrollViewOffset(_ scrollView: UIScrollView) {
    
        let offset = scrollView.contentOffset.y

        if offset < 0 {
            imageView.frame = CGRect(x: offset ,y: offset, width: imageSize.width - (offset * 2) , height: imageSize.height - offset);
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height);
        }
    }
}
