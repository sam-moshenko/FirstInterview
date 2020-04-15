//
//  Constants.swift
//  InterviewTask
//
//  Created by Yeskendir Salgara on 4/15/20.
//  Copyright © 2020 Yeskendir Salgara. All rights reserved.
//

import Foundation


enum API{
    
    case photo
    
    var url: URL{
        return URL(string: "https://picsum.photos/200")!
    }
    
}
