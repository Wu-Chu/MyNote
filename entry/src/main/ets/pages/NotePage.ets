// 导入页面路由模块
import router from '@ohos.router';

@Entry
@Component
struct NotePage {
  @State message: string = '笔记界面';
  @State fontSize: number = 16;

  build() {
    Row() {
      Column() {
        Text(this.message)
          .margin({ top: 20 })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Flex({ direction: FlexDirection.Row }) {
          Button('< 返回')
            .width(80)
            .margin({ top: 10, left: 20 })
            .onClick(()=>{
              router.back()
            })
        }

        TextArea()
          .margin(20)
          .layoutWeight(1)
          .fontSize(this.fontSize)
      }
      .width('100%')
    }
    .height('100%')
  }
}