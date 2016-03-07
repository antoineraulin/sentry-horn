//
// Created by Thierry on 15/12/31.
// Copyright (c) 2015 Thierry. All rights reserved.
//

import Foundation


class SimulatorUtility
{
    class var isRunningSimulator: Bool
    {
        get
        {
            return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
        }
    }
}
