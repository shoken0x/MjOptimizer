import Foundation
import UIKit
import CoreMedia

class TMAnalyzer{
    
    enum MatchType: Int32{
        case COLOR = 0
        case GRAY = 1
        case BINARY = 2
    }
    
    class TemplateImage{
        let pai:Pai
        let trimed:Bool
        let uiimage:UIImage
        init(_ paiStr: String,_ trimed:Bool){
            self.pai = Pai.parse(paiStr)!
            self.trimed = trimed
            var str = "tpl-" + self.pai.toShortStr() + ( trimed ? "-trimed" : "" ) + ".jpg"
            let tmp = UIImage(named:str)!
            //TODO direction
            switch self.pai.direction{
            case .TOP:     self.uiimage = tmp
            case .RIGHT:   self.uiimage = UIImageUtil.rotate(tmp,angle:90)
            case .BOTTOM:  self.uiimage = UIImageUtil.rotate(tmp,angle:180)
            case .LEFT:    self.uiimage = UIImageUtil.rotate(tmp,angle:270)
            }
        }
    }
    
    var templateMatcher: TemplateMatcher
    var paiTypes: [Pai]
    let matchType:MatchType = MatchType.GRAY
    
    init() {
        self.templateMatcher = TemplateMatcher()
        self.paiTypes = [Pai]()
    }
    
    // @uiimage トリミングされた画像
    func analyze(target : UIImage) -> AnalyzeResult {
        let templateImages : [TemplateImage] = [
            TemplateImage("m1l", true),
            TemplateImage("m2t", true),
            TemplateImage("m3t", true),
            TemplateImage("m4t", true),
            TemplateImage("m5t", true),
            TemplateImage("m6t", true),
            TemplateImage("m7t", true),
            TemplateImage("m8t", true),
            TemplateImage("m9t", true),
            TemplateImage("s1t", false),
            TemplateImage("s2t", false),
            TemplateImage("s3t", false),
            TemplateImage("s4t", false),
            TemplateImage("s5t", false),
            TemplateImage("s6t", false),
            TemplateImage("s7t", true),
            TemplateImage("s8t", false),
            TemplateImage("s9t", false),
            TemplateImage("p1t", false),
            TemplateImage("p2t", false),
            TemplateImage("p3t", false),
            TemplateImage("p4t", false),
            TemplateImage("p5t", false),
            TemplateImage("p6t", false),
            TemplateImage("p7t", true),
            TemplateImage("p8t", false),
            TemplateImage("p9t", true),
            TemplateImage("j1t", true),
            TemplateImage("j2t", true),
            TemplateImage("j3t", false),
            TemplateImage("j4t", true),
            TemplateImage("j5t", false),
            TemplateImage("j6t", true),
            TemplateImage("j7t", false),

            TemplateImage("m1r", true),
            TemplateImage("m2r", true),
            TemplateImage("m3r", true),
            TemplateImage("m4r", true),
            TemplateImage("m5r", true),
            TemplateImage("m6r", true),
            TemplateImage("m7r", true),
            TemplateImage("m8r", true),
            TemplateImage("m9r", true),
            TemplateImage("s1r", false),
            TemplateImage("s2r", false),
            TemplateImage("s3r", false),
            TemplateImage("s4r", false),
            TemplateImage("s5r", false),
            TemplateImage("s6r", false),
            TemplateImage("s7r", true),
            TemplateImage("s8r", false),
            TemplateImage("s9r", false),
            TemplateImage("p1r", false),
            TemplateImage("p2r", false),
            TemplateImage("p3r", false),
            TemplateImage("p4r", false),
            TemplateImage("p5r", false),
            TemplateImage("p6r", false),
            TemplateImage("p7r", true),
            TemplateImage("p8r", false),
            TemplateImage("p9r", true),
            TemplateImage("j1r", true),
            TemplateImage("j2r", true),
            TemplateImage("j3r", false),
            TemplateImage("j4r", true),
            TemplateImage("j5r", false),
            TemplateImage("j6r", true),
            TemplateImage("j7r", false),

            TemplateImage("m1b", true),
            TemplateImage("m2b", true),
            TemplateImage("m3b", true),
            TemplateImage("m4b", true),
            TemplateImage("m5b", true),
            TemplateImage("m6b", true),
            TemplateImage("m7b", true),
            TemplateImage("m8b", true),
            TemplateImage("m9b", true),
            TemplateImage("s1b", false),
            TemplateImage("s3b", false),
            TemplateImage("s7b", true),
            TemplateImage("p6b", false),
            TemplateImage("p7b", true),
            TemplateImage("j1b", true),
            TemplateImage("j2b", true),
            TemplateImage("j3b", false),
            TemplateImage("j4b", true),
            TemplateImage("j6b", true),
            TemplateImage("j7b", false),
            
            TemplateImage("m1l", true),
            TemplateImage("m2l", true),
            TemplateImage("m3l", true),
            TemplateImage("m4l", true),
            TemplateImage("m5l", true),
            TemplateImage("m6l", true),
            TemplateImage("m7l", true),
            TemplateImage("m8l", true),
            TemplateImage("m9l", true),
            TemplateImage("s1l", false),
            TemplateImage("s3l", false),
            TemplateImage("s7l", true),
            TemplateImage("p3l", false),
            TemplateImage("p7l", true),
            TemplateImage("j1l", true),
            TemplateImage("j2l", true),
            TemplateImage("j3l", false),
            TemplateImage("j4l", true),
            TemplateImage("j6l", true),
            TemplateImage("j7l", false)

        ]
        
        Log.info("analyze called")
        
        var tmResults: [TMResult] = []
        for templateImage in templateImages {
            Log.info("scan pai:\(templateImage.pai.toString())")
            let matches: Array<AnyObject> = self.templateMatcher.match(
                target,
                template: templateImage.uiimage,
                matchType:matchType.rawValue)
            
//            let matches: Array<AnyObject> = self.templateMatcher.matchTarget(target, withTemplate: pai.toString(),matchType:matchType.rawValue)
            for match: AnyObject in matches {
                if let m = match as? MatcherResult {
                    tmResults.append(TMResult(x: Int(m.x), y: Int(m.y), width: Int(m.width), height: Int(m.height), value: m.value, pai: templateImage.pai))
                }
            }
        }

        //結果のデバッグ表示
        Log.info("template matching finished")
        for result: TMResult in tmResults {
            Log.info("result.pai = \(result.pai.toString())")
            Log.info("result.place = \(result.place)")
        }

        //重なっているマッチ結果をフィルタしてソートする
        tmResults = sortWithPlace(filterUpperValue(filterNotIntersection(tmResults)))
        
        Log.info("intersection fileter finished")
        
        //結果のデバッグ表示
        var cvView = CvView(frame: CGRectMake(0, 0, target.size.width, target.size.height), background: self.templateMatcher.changeDepth(target,matchType:matchType.rawValue))
        for result: TMResult in tmResults {
            Log.info("result.pai = \(result.pai.toString())")
            Log.info("result.place = \(result.place)")
            cvView.addRect(result.place)
        }
        Log.info("total analyze = \(tmResults.count)")
        var debugView = cvView.imageFromView()
        
        return AnalyzeResult(resultList: tmResults,targetImage: self.templateMatcher.changeDepth(target,matchType:matchType.rawValue),debugImage: debugView)
    }
    
    func filterNotIntersection(pais:[TMResult]) -> [TMResult]{
        var selectedPais : [TMResult] = []
        var workPais:[TMResult] = pais
        var tmpPais:[TMResult] = []
        sort(&workPais) { p1, p2 in return p1.value > p2.value }
        while(workPais.count > 1){
            //先頭をとる
            var topValuePai = workPais.shift()
            //先頭を採用
            selectedPais.append(topValuePai)
            //後続は重なりが少ない物のみ採用
            for pai: TMResult in workPais{
                if CGRectIntersectsRect(topValuePai.place, pai.place) {
                    //重なってる
                    let intersection: CGRect = CGRectIntersection(topValuePai.place, pai.place)
                    if intersection.width < 3 {
                    //横方向に3ピクセル以内の重なりなら許容
                        tmpPais.append(pai)
                    }
                }else{
                    //全く重なってない
                    tmpPais.append(pai)
                }
            }
            workPais = tmpPais.copy()
            tmpPais = []
        }
        return selectedPais
    }
    
    //おぎアルゴリズム(つかってない)
    func select(pais: [TMResult]) -> [TMResult] {
        var selected = [TMResult]()
        var sorted_pai = pais
        sort(&sorted_pai) { p1, p2 in return p1.value > p2.value }
        for pai: TMResult in sorted_pai {
            if let nearestPai = self.nearest(pai, paiList: selected) { //物理的に近い牌を探す
                if CGRectIntersectsRect(nearestPai.place, pai.place) { //一番近い牌が重なっている
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

    func filterUpperValue(pais: [TMResult]) -> [TMResult] {
        var filtered_pais = pais
        sort(&filtered_pais){ p1, p2 in return p1.value > p2.value }
        return filtered_pais[0..19]
    }
    
    func sortWithPlace(pais: [TMResult]) -> [TMResult] {
        var sorted_pais = pais
        sort(&sorted_pais){ p1, p2 in return p1.place.origin.x < p2.place.origin.x }
        return sorted_pais
    }
    
    func nearest(pai: TMResult, paiList: [TMResult]) -> TMResult? {
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
