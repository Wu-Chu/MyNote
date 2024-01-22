import CommonConstants from '../common/constants/CommonConstants'

@Component
export struct NoteTransferButton {
  back: (event) => void;
  edit: (event) => void;

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
      Text('笔记')
        .fontSize(CommonConstants.FONT_SIZE_38)
        .fontColor($r('app.color.theme'))
      Blank()

      Text('编辑页面')
        .fontSize(CommonConstants.FONT_SIZE_22)
        .fontColor(FontWeight.Bold)
        .padding({
          left: 15
        })
        .align(Alignment.Center)
        .height(54)
        .onClick((e) => {
          this.edit(e)
        })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(54)
    .margin({
      top: 19
    })
  }
}