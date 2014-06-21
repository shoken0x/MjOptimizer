import Foundation
import UIKit
import CoreMedia

class TMAnalyzer: TMAnalyzerProtocol {
    var matcher: TemplateMatcher
    var paiTypes: Pai[]
    
    init() {
        self.matcher = TemplateMatcher()
        self.paiTypes = Pai[]()
        self.setupPaiTypes()
    }
    
    func setupPaiTypes() {
        
        let keys = [
            "m1t", "m2t", "m3t", "m4t", "m5t", "m6t", "m7t", "m8t", "m9t",
            "p1t", "p2t", "p3t", "p4t", "p5t", "p6t", "p7t", "p8t", "p9t",
            "s1t", "s2t", "s3t", "s4t", "s5t", "s6t", "s7t", "s8t", "s9t",
            "j1t", "j2t", "j3t", "j4t", "j5t", "j6t", "j7t"
        ]
        //let keys = ["p6t"]
        
        for key in keys {
            paiTypes.append(Pai.parse(key)!)
        }
    }
    
    func analyze(image : CMSampleBuffer, targetFrame : CGRect, lastAnalyzerResult : AnalyzeResultProtocol?) -> AnalyzeResultProtocol {
        
        let uiimage = TemplateMatcher.UIImageFromCMSampleBuffer(image)
        let results = self.analyze(uiimage)
        return AnalyzeResult(resultList: results)
    }
        
    func analyze(target: UIImage) -> TMResult[] {
        var results: TMResult[] = []
        for pai in self.paiTypes {
            let matches: Array<AnyObject> = self.matcher.matchTarget(target, withTemplate: pai.toString())
            for match: AnyObject in matches {
                if let m = match as? MatcherResult {
                    results.append(TMResult(x: Int(m.x), y: Int(m.y), width: Int(m.width), height: Int(m.height), value: m.value, pai: pai))
                }
            }
        }
        return select(results)
    }
    
    func select(pais: TMResult[]) -> TMResult[] {
        var selected = TMResult[]()
        var sorted_pai: TMResult[] = sort(pais) { p1, p2 in return p1.value < p2.value }
        for pai: TMResult in sorted_pai {
            if let nearestPai = self.nearest(pai, paiList: selected) {
                if CGRectIntersectsRect(nearestPai.place, pai.place) {
                    let intersection: CGRect = CGRectIntersection(nearestPai.place, pai.place)
                    let ratio: CGFloat = (intersection.width * intersection.height) / (pai.place.width * pai.place.height)
                    if ratio > 0.15 {
                        if pai.value > nearestPai.value {
                            selected = selected.filter { $0 !== nearestPai }
                            selected.append(pai)
                        }
                    } else {
                        selected.append(pai)
                    }
                } else {
                    selected.append(pai)
                }
            } else {
                selected.append(pai)
            }
        }
        return selected
    }
    
    func nearest(pai: TMResult, paiList: TMResult[]) -> TMResult? {
        var minDistance = Double.infinity
        var nearestPai: TMResult? = nil
        for p in paiList {
            let distance = pai.distance(p)
            if minDistance > distance {
                minDistance = distance
                nearestPai = p
            }
        }
        return nearestPai
    }
}

class AnalyzeResult: AnalyzeResultProtocol {
    let resultList: TMResult[]
    let paiList: Pai[]
    
    init(resultList: TMResult[]) {
        self.resultList = resultList
        self.paiList = resultList.map{ $0.pai }
    }
    
    //牌のリスト。0番目は手牌の一番左
    func getPaiList() -> Pai[] {
        return paiList
    }
    
    //牌の位置(paiPositionIndex)を指定すると、その牌がある場所を長方形で返す
    func getPaiPositionRect(paiPositionIndex: Int) -> CGRect {
        return resultList[paiPositionIndex].place
    }
    
    //解析に成功した牌の数
    func getAnalyzeSuccessNum() -> Int {
        return resultList.count
    }

    //解析に成功したかどうか
    func isSuccess() -> Bool {
        return self.getAnalyzeSuccessNum() >= 13
    }
}
