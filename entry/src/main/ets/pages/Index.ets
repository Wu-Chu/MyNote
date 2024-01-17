// 导入页面路由模块
import router from '@ohos.router';



@Entry
@Component
struct Index {
  @State message: string = '登录界面';


  build() {
    Row() {
      Column() {
        Column(){
          Text(this.message)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder:'请输入用户名'})
            .margin({top:20})
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          TextInput({placeholder:'请输入密码'})
            .margin({top:20})
            // .type(InputType.Password)
            .onSubmit((EnterKeyType)=>{
              console.info(EnterKeyType+'输入法回车键的类型值')
            })
          Button('登录')
            .width(100)
            .margin({top:20})
            .onClick(()=>{
              router.pushUrl({url:'pages/MainPage'}).then(()=>{

              }).catch(()=>{

              })
            })
        }
        // .backgroundColor($r('app.color.black_40'))
      }
      .width('100%')
    }
    .height('100%')
  }


}