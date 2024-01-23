import CommonConstants from '../common/constants/CommonConstants'

@Component
export struct NoteAddButton {
  @Link clickAble: boolean;
  back: (event) => void;
  save: (event) => void;

  build() {
    Row() {
      Row() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
      }.padding({ left: 2, right: 17, top: 10, bottom: 10 })
      .onClick((e) => {
        this.back(e)
      })

      Text('新增')
        .fontSize(CommonConstants.FONT_SIZE_29)
      Blank()
      Button('保存')
        .fontSize(CommonConstants.FONT_SIZE_22)
        .backgroundColor(this.clickAble ? $r('app.color.theme') : $r('app.color.button_disable'))
        .height(44)
        .borderRadius(7)
        .padding({
          left: 14,
          right: 14,
        })
        .margin({ bottom: 4 })
        .enabled(this.clickAble)
        .onClick((e) => {
          this.save(e)
        })
        .type(ButtonType.Normal)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(54)
    .margin({
      top: 19
    })
  }
}