//
// Created by Thierry on 16/1/6.
// Copyright (c) 2016 Thierry. All rights reserved.
//

import Foundation
import EVReflection

class BaseObject:EVObject {
    
    /**
     Override super setValue method, ignore warning
     
     - parameter value:
     - parameter key:
     */
    override func setValue(_ value: Any!, forUndefinedKey key: String) {}
    
}
