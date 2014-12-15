//
//  Background.swift
//  AppleCatch
//
//  Created by David Hakopian on 2014-12-13.
//  Copyright (c) 2014 David Hakopian. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    
    init(filename: String){
        
        let backgroundTexture: SKTexture  = SKTexture(imageNamed: filename)
        super.init(texture: backgroundTexture, color: nil, size: backgroundTexture.size())
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}