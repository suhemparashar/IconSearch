//
//  LoaderView.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import UIKit

class LoaderView: UIView {
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading⌛..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(loadingLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingLabel.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            self.frame = viewController.view.frame
            viewController.view.addSubview(self)
        }
    }
    
    func hide() {
        removeFromSuperview()
    }
}
