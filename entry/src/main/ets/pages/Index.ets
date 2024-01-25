// 导入页面路由模块
import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';


@Entry
@Component
struct Index {
  @State message: string = '登录界面';


  build() {
    Row() {
      Column() {
        Column(){
          Text(this.message)
            .fontSize(CommonConstants.FONT_SIZE_38)
            .fontWeight(FontWeight.Bold)
          Row(){}.margin(10)
          TextInput({placeholder:'请输入用户名'})
            .margin({top:20})
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          Row(){}.margin(10)
          TextInput({placeholder:'请输入密码'})
            .margin({top:20})
            // .type(InputType.Password)
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          Row(){}.margin(10)
          Button('登录')
            .width(100)
            .margin({top:20})
            .backgroundColor('#03A9F4')
            .onClick(()=>{
              router.pushUrl({url:'pages/MainPage'}).then(()=>{

              }).catch(()=>{

              })
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: CommonConstants.MARGIN_2, right: CommonConstants.MARGIN_1 })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor($r('app.color.blue_11'))
  }


}