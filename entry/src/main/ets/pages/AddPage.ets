import CommonConstants from '../common/constants/CommonConstants'
import NoteInfo from '../common/bean/NoteInfo'
import { NoteAddButton } from '../view/NoteAddButton'
import DateUtil from '../common/utils/DateUtil'
import Router from '@system.router'
import router from '@ohos.router'
import { NoteInfoTable } from '../common/database/NoteInfo'
import { Logger } from '../common/utils/log/Logger'

@Entry
@Component
struct PageAdd {
  @State clickAble: boolean = true;
  @State imageArray: string [] = []; // 图片列表
  @State noteInfo: NoteInfo = { // 笔记信息
    id: 0,
    title: "",
    content: "",
    date: "",
    imageArr: ''
  };
  dbApi=new NoteInfoTable();

  build() {
    Column() {
      // 标题栏
      NoteAddButton({
        clickAble: $clickAble,
        back: () => {
          router.pushUrl({url:'pages/MainPage'})
        },
        save: () => {
          let currentDate = new Date;

          // this.noteInfo.date = DateUtil.getCurrentTime()
          this.noteInfo.date = "0" + (currentDate.getMonth()+1).toString() + "/" + currentDate.getDay().toString()
          this.noteInfo.imageArr = JSON.stringify(this.imageArray)
          this.dbApi.insertNote(this.noteInfo,(success)=>{
            if(!success) AlertDialog.show({
              title: "错误",
              message: "新增内容失败"
            })
            else router.back()
          })
        }
      })
      // 笔记标题
      TextInput({
        placeholder: '标题'
      })
        .placeholderColor($r('app.color.black_40'))
        .fontSize(CommonConstants.FONT_SIZE_19)
        .borderWidth({ bottom: 1 })
        .borderColor($r('app.color.black_10'))
        .padding({
          left: 5
        })
        .backgroundColor(Color.Transparent)
        .height(58)
        .borderRadius(0)
        .margin({ top: 55, bottom: 20 })
        .width('100%')
        .onChange((str) => {
          this.noteInfo.title = str;
        })

      // 笔记正文
      TextArea({
        placeholder: '正文'
      })
        .placeholderColor($r('app.color.black_40'))
        .padding({ left: 5 })
        .backgroundColor(Color.Transparent)
        .borderRadius(0)
        .height(140)
        .margin({ top: 10, bottom: 20 })
        .onChange((str) => {
          this.noteInfo.content = str;
        })

      // 图片
      Grid() {
        ForEach(this.imageArray, (src: string) => {
          GridItem() {
            Image(src)
              .width(98)
              .height(98)
          }
        })
        GridItem() {
          Image($r("app.media.icon_add_image"))
            .width(98)
            .height(98)
            .onClick(() => {
              // todo 添加图片

              this.selectPic()
            })
        }
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(20)
      .rowsGap(20)
      .width(334)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .padding({ left: CommonConstants.MARGIN_2, right: CommonConstants.MARGIN_2 })
    .backgroundColor($r('app.color.background'))
    .alignItems(HorizontalAlign.Start)


  }
  selectPic(){
    Logger.info('wuhao','addtupian')
    let startParmameter = {
      bundleName:"com.ohos.photos",
      abilityName: "com.ohos.photos.MainAbility",
      parameters: {
        uri: "singleselect"
      }
    };
    globalThis.context.startAbilityForResult(startParmameter).then((result) => {
      console.info(`startAbilityForResult Promise.resolve is called, result.resultCode =  ${JSON.stringify(result)}`)
      let want = result['want'];
      console.info(`test select single ${JSON.stringify(want)}`);
      if (want != null && want != undefined) {
        let param = want['parameters'];
        console.info(`test select single ${JSON.stringify(param)}`);
        if (param != null && param != undefined) {
          let uri = param['select-item-list'];
          // console.info(`test select single ${uri[0]}`);
          Logger.info('wuhao','addtupian')
          this.imageArray = uri
        }
      }
    }, (error) => {
      console.info(`startAbilityForResult Promise.Reject is called, error.code = ${error.code}`)
    })
  }
}