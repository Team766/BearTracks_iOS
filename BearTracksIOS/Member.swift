//
//  Member.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/19/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import Foundation
import UIKit

class Member {
    
    //MARK: Properties
    let name: String
    let photo: UIImage
    let key: String

    init(name:String, photo: UIImage, key:String){
        self.name = name
        self.photo = photo
        self.key = key
    }

}

