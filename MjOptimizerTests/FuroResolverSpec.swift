import MjOptimizer
import Quick
import Nimble

class FuroResolverSpec: QuickSpec {
    override func spec() {
        describe("getFuro"){
            it("returns mentsu list 1"){
                let pl : Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj2tj2tj2l")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("ポン:j2")
            }
            
            it("returns mentsu list 2"){
                let pl : Pai[] = Pai.parseList("m1tm1tp9tp9rp9tp9tp7lp7tp7tp7tp8tp8tp8tp8rm1lm2tm3t")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("チー:m1m2m3")
                expect(mentsuList[1].toString()).to.equal("ミンカン:p8")
                expect(mentsuList[2].toString()).to.equal("ミンカン:p7")
                expect(mentsuList[3].toString()).to.equal("ミンカン:p9")
            }
            it("returns mentsu list 3"){
                let pl : Pai[] = Pai.parseList("m1tm2tm3tp2tp2tp6lp7tp8tp8tp8lp8tp9tp9tp9r")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("ポン:p9")
                expect(mentsuList[1].toString()).to.equal("ポン:p8")
                expect(mentsuList[2].toString()).to.equal("チー:p6p7p8")
            }
            it("returns mentsu list 4"){
                let pl : Pai[] = Pai.parseList("m1tm1ts7ts8ts9ts9rs9ts9tm1lm2tm3tm4lm5tm6t")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("チー:m4m5m6")
                expect(mentsuList[1].toString()).to.equal("チー:m1m2m3")
                expect(mentsuList[2].toString()).to.equal("ポン:s9")
            }
            it("returns mentsu list 5"){
                let pl : Pai[] = Pai.parseList("m1tm1tr0ts1ts1tr0ts7ls8ts9ts9rs9ts9tm4lm5tm6t")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("チー:m4m5m6")
                expect(mentsuList[1].toString()).to.equal("ポン:s9")
                expect(mentsuList[2].toString()).to.equal("チー:s7s8s9")
                expect(mentsuList[3].toString()).to.equal("アンカン:s1")
            }
            it("returns mentsu list 6"){
                let pl : Pai[] = Pai.parseList("s7ts8ts9ts9ts9tm4lm5tm6tr0ts2ts2tr0tm1lm1tm1t")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("ポン:m1")
                expect(mentsuList[1].toString()).to.equal("アンカン:s2")
                expect(mentsuList[2].toString()).to.equal("チー:m4m5m6")
            }
            it("returns mentsu list 7"){
                let pl : Pai[] = Pai.parseList("s7ts8ts9ts9ts9tm4lm5tm6tm1lm1tm1ts2tr0tr0ts2t")!
                let mentsuList :Mentsu[] = FuroResolver.getFuro(pl)!
                expect(mentsuList[0].toString()).to.equal("アンカン:s2")
                expect(mentsuList[1].toString()).to.equal("ポン:m1")
                expect(mentsuList[2].toString()).to.equal("チー:m4m5m6")
            }
            it("returns nil 1"){
                let pl : Pai[] = Pai.parseList("m1tm1ts8ts9ts9rs9ts9tm1lm2tm3tp8lp8tp8tp8t")!
                expect(FuroResolver.getFuro(pl)).to.beNil()
            }
            it("returns nil 2"){
                let pl : Pai[] = Pai.parseList("m1tm1tr0ts1tr0ts7ts8ts9ts9rs9ts9tm1lm2tm3t")!
                expect(FuroResolver.getFuro(pl)).to.beNil()
            }
            it("returns nil 3"){
                let pl : Pai[] = Pai.parseList("m1tm1ts7ts7ts7ts8ts8ts8ts9ts9ts9rp4tp5tp6t")!
                expect(FuroResolver.getFuro(pl)).to.beNil()
            }
        }
        describe("getOneFuro"){
            it("gets pon"){
                let pl : Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj2tj2tj2l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:j2")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("gets chi"){
                let pl : Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tm1tm2lm3t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("チー:m1m2m3")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("345678(9)999 -> 345 678 (9)999"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("3456789(9)99 -> 345 678 9(9)99"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("34567899(9)9 -> 345 678 99(9)9"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("345678999(9) -> 345 678 999(9)"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            
            it("345678(9)99(9) -> 3456 78(9) 99(9)"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("34567(8)999(9) -> 3456 7(8)9 99(9)"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("3456(7)8999(9) -> 3456 (7)89 99(9)"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("345(6)78999(9) -> 345 (6)78 999(9)"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9tp9tp9l")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            
            it("345678(9)99(9) -> 3456 78(9) 9(9)9"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("34567(8)99(9)9 -> 3456 7(8)9 9(9)9"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("3456(7)899(9)9 -> 3456 (7)89 9(9)9"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("345(6)7899(9)9 -> 345 (6)78 99(9)9"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9tp9lp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            
            it("345678(9)(9)99 -> 3456 78(9) (9)99"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8tp9lp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("34567(8)9(9)99 -> 3456 7(8)9 (9)99"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7tp8lp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("3456(7)89(9)99 -> 3456 (7)89 (9)99"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6tp7lp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ポン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("345(6)789(9)99 -> 345 (6)78 9(9)99"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tp9lp9tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("ミンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            
            it("アンカン表裏裏表"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tp9tr1tr1tp9t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("アンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
            it("アンカン裏表表裏"){
                let pl : Pai[] = Pai.parseList( "j1tj1tj3tj3tj3tp6lp7tp8tr1tp9tp9tr1t")!
                let getOneFuroResult : GetOneFuroResult = FuroResolver.getOneFuro(pl)
                switch getOneFuroResult{
                case let .SUCCESS(mentsu):
                    expect(mentsu.toString()).to.equal("アンカン:p9")
                default:
                    //SUCCESS以外がかえってくるのはそもそもNGなので、強制的にテストを失敗にする
                    expect(false).to.beTrue()
                }
            }
        }
    }
}
