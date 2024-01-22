import CommonConstants from '../common/constants/CommonConstants'

@Component
export struct NoteSaveButtons {
  back: (event) => void;
  save: (event) => void;
  @Link change: boolean
  build() {
    Row(){
      Row() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
      }.padding({ left: 2, right: 17, top: 10, bottom: 10 })
      .onClick((e) => {
        this.back(e)
      })
      Text('编辑')
        .fontSize(CommonConstants.FONT_SIZE_38)
        .fontColor($r('app.color.theme'))
      Blank()

      Text('保存')
        .fontSize(CommonConstants.FONT_SIZE_22)
        .fontColor(FontWeight.Bold)
        .padding({
          left: 15
        })
        .align(Alignment.Center)
        .height(54)
        .onClick((e) => {
          this.save(e)
        })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(54)
    .margin({
      top: 19
    })
  }
}