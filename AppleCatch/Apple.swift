//
//  Apple.swift
//  AppleCatch
//
//  Created by David Hakopian on 2014-12-13.
//  Copyright (c) 2014 David Hakopian. All rights reserved.
//

import Foundation
import SpriteKit


class Apple: SKSpriteNode {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(filename: String){
        let imageTexture: SKTexture = SKTexture(imageNamed: filename)
        super.init(texture: imageTexture, color: nil, size: imageTexture.size())
    }
    
    
}
