//
//  DetalheFotosCell.swift
//  Tinder
//
//  Created by Vinicius Rocha on 26/04/20.
//  Copyright © 2020 ViniciusRocha. All rights reserved.
//

import UIKit

class DetalheFotosCell: UICollectionViewCell {
    
    let descricaoLabel: UILabel = .textBoldLabel(16)
    
    let slideFotosViewController = SlideFotosViewController()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        descricaoLabel.text = "Fotos recentes Instagran"
        
        addSubview(descricaoLabel)
        descricaoLabel.preencher(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
        )
        
        addSubview(slideFotosViewController.view)
        slideFotosViewController.view.preencher(
            top: descricaoLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
