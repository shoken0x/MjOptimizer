//
//  ViewUtils.swift
//  MjOptimizer
//
//  Created by Shoken Fujisaki on 6/18/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

class ViewUtils {
    class func convertStringListFromPaiList(paiList: Pai[]) -> String[] {
        var strArray: String[] = []
        for pai: Pai in paiList {
            strArray.append(convertStringFromPai(pai))
        }
        return strArray
    }
    
    class func convertStringFromPai(pai: Pai) -> String {
        switch pai.type {
        case PaiType.MANZU:
            switch pai.number {
            case 1: return "MJw1"
            case 2: return "MJw2"
            case 3: return "MJw3"
            case 4: return "MJw4"
            case 5: return "MJw5"
            case 6: return "MJw6"
            case 7: return "MJw7"
            case 8: return "MJw8"
            case 9: return "MJw9"
            default: return ""
            }
        case PaiType.SOUZU:
            switch pai.number {
            case 1: return "MJs1"
            case 2: return "MJs2"
            case 3: return "MJs3"
            case 4: return "MJs4"
            case 5: return "MJs5"
            case 6: return "MJs6"
            case 7: return "MJs7"
            case 8: return "MJs8"
            case 9: return "MJs9"
            default: return ""
            }
        case PaiType.PINZU:
            switch pai.number {
            case 1: return "MJt1"
            case 2: return "MJt2"
            case 3: return "MJt3"
            case 4: return "MJt4"
            case 5: return "MJt5"
            case 6: return "MJt6"
            case 7: return "MJt7"
            case 8: return "MJt8"
            case 9: return "MJt9"
            default: return ""
            }
        case PaiType.JIHAI:
            switch pai.number {
            case 1: return "MJf1"
            case 2: return "MJf2"
            case 3: return "MJf3"
            case 4: return "MJf4"
            case 5: return "MJd1"
            case 6: return "MJd2"
            case 7: return "MJd3"
            default: return ""
            }
        default: return ""
        }
    }
}