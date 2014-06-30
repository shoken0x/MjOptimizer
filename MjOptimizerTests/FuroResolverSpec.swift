import MjOptimizer
import Quick
import Nimble

class FuroResolverSpec: QuickSpec {
    override func spec() {
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
//
//# get_furo正常系1
//  # step1-1-1, step1-1-7-4-2
//  def test_normal_get_furo_1
//  # get_furo正常系2
//  # step1-1-2, step1-1-7-1, step1-2
//  def test_normal_get_furo_2
//    pai_items = "m1tm2tm3tp2tp2tp6lp7tp8tp8tp8lp8tp9tp9tp9r"
//  # get_furo正常系3
//  # step1-1-4, step1-1-7-3, step2-1(, step1-2)
//  def test_normal_get_furo_3
//    pai_items = "m1tm1tp9tp9rp9tp9tp7lp7tp7tp7tp8tp8tp8tp8rm1lm2tm3t"
//  # get_furo正常系4
//  # step1-1-6(, step1-2)
//  def test_normal_get_furo_4
//    pai_items = "m1tm1ts7ts8ts9ts9rs9ts9tm1lm2tm3tm4lm5tm6t"
//
//  # get_furo正常系5
//  # step1-1-7-4-3(, step1-2)
//  def test_normal_get_furo_5
//    pai_items = "m1tm1tr0ts1ts1tr0ts7ts8ts9ts9rs9ts9tm4lm5tm6t"
//  # get_furo正常系6
//  # step3-1(, step1-1-2, step1-2)
//  def test_normal_get_furo_6
//    pai_items = "s7ts8ts9ts9ts9tm4lm5tm6tr0ts2ts2tr0tm1lm1tm1t"
//    
//  # get_furo正常系7
//  # step3-2(, step1-1-2, step1-2)
//  def test_normal_get_furo_7
//    pai_items = "s7ts8ts9ts9ts9tm4lm5tm6tm1lm1tm1ts2tr0tr0ts2t"
//  # get_furo異常系1
//  # step1-1-5
//  def test_error_get_furo_1
//    pai_items = "m1tm1ts8ts9ts9rs9ts9tm1lm2tm3tp8lp8tp8tp8t"
//  # get_furo異常系2
//  # step1-1-7-4-4
//  def test_error_get_furo_2
//    pai_items = "m1tm1tr0ts1tr0ts7ts8ts9ts9rs9ts9tm1lm2tm3t"
//  # get_furo異常系3
//  # step1-3
//  def test_error_get_furo_3
//    pai_items = "m1tm1ts7ts7ts7ts8ts8ts8ts9ts9ts9tp4tp5rp6t"
//  # get_furo異常系4
//  # step2-2
//  def test_error_get_furo_4
//    pai_items = "m1tm1ts7ts7ts7ts8ts8ts8ts9ts9ts9rp4tp5tp6t"
