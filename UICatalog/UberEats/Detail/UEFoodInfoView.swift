//
//  UEFoodInfoView.swift
//  UICatalog
//

import UIKit

class UEFoodInfoView: UIView {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var cardViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelHeigthConstraint: NSLayoutConstraint!
    
    private let cardMargin: CGFloat = 20
    private let titleLabelHeight: CGFloat = 80
    private let height: CGFloat = 140
    private var imageSize: CGSize = .zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 0.1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Public
    func layout(in view: UIView, targetImageView: UIImageView, imageSize: CGSize) {
        
        self.imageSize = imageSize

        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        centerYAnchor.constraint(equalTo: targetImageView.bottomAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        
        transform = CGAffineTransform(translationX: 0, y: 40)
        self.alpha = 0.0
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.15,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
                        self?.alpha = 1
                        self?.transform = CGAffineTransform.identity
                       },completion: nil)
    }
    
    func updateScrollViewOffset(_ scrollView: UIScrollView, completion: (Bool) -> Void) {
        
        let diff = scrollView.contentOffset.y / (imageSize.height - (height / 2))
        if scrollView.contentOffset.y < (imageSize.height - (height / 2)) {
            completion(false)
            
            transform = CGAffineTransform(translationX: 0, y: -scrollView.contentOffset.y)
            
            if diff <= 0 { return }
            
            titleLabelTopConstraint?.constant = (UIApplication.shared.statusBarFrame.height) * diff
            titleLabelHeigthConstraint.constant = (titleLabelHeight / 2) + ((titleLabelHeight / 2) * (1 - diff))
            cardViewLeadingConstraint.constant = cardMargin * (1 - diff)
            cardViewTrailingConstraint.constant = cardMargin * (1 - diff)
            
            genreLabel.alpha = (1 - diff)
            infoLabel.alpha = (1 - diff)
            
        } else {
            completion(true)
            
            transform = CGAffineTransform(translationX: 0, y: -(imageSize.height - (height / 2)))
            
            titleLabelTopConstraint?.constant = (UIApplication.shared.statusBarFrame.height)
            titleLabelHeigthConstraint.constant = (titleLabelHeight / 2)
            cardViewLeadingConstraint.constant = 0
            cardViewTrailingConstraint.constant = 0
            
            genreLabel.alpha = 0
            infoLabel.alpha = 0
        }
    }
}
