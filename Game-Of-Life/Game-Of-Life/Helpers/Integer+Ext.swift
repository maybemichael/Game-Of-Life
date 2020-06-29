//
//  Integer+Ext.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/28/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import Foundation

extension Int {
    func withinBoard(count: Int) -> Int {
        (self % count + count) % count
    }
}
