// 导入页面路由模块
import router from '@ohos.router';



@Entry
@Component
struct Index {
  @State message: string = '笔记界面';


  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
    }
    .height('100%')
  }


}