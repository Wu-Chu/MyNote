// 导入页面路由模块
import router from '@ohos.router';
import NoteInfo from '../common/bean/NoteInfo';
import CommonConstants from '../common/constants/CommonConstants';
import { NoteTransferButton } from '../view/NoteTransferButton'
import { NoteInfoTable } from '../common/database/NoteInfo'
import {PublicInfo} from '../common/database/PublicInfo'
import { Logger } from '../common/utils/log/Logger';


@Entry
@Component
struct NotePage {
  @State message: string = '笔记界面';
  @State fontSize: number = 16;
  @State noteInfo: NoteInfo  = { // 笔记信息
    id: 0,
    title: "www",
    content: "",
    date: "",
    imageArr: ''
  }
  @State currentId:number = 0;
  dbApi=new NoteInfoTable();
  // currentId = new PublicInfo()

  build() {
    Row() {
      Column() {
        NoteTransferButton({
          back: () => {
            // todo
            // router.pushUrl({url:'pages/MainPage'})
            router.back()
          },
          edit: () => {
            // todo 跳转到编辑页面
            router.pushUrl({url:'pages/EditPage',
              params: {
                currentId1:this.currentId
              }}
            )

            // Logger.info('wuhao',this.noteInfo)
          }
        })
        Scroll(){
          Column() {
            Text(this.noteInfo.title.length == 0 ? '暂无标题' : this.noteInfo.title)
              .margin({
                top: 29
              })
              .fontColor(this.noteInfo.title.length == 0 ? $r('app.color.black_40') : $r('app.color.black_40'))
              .fontSize(CommonConstants.FONT_SIZE_29)

            Text(this.noteInfo.date + (this.noteInfo.content.length) + '字')
              .margin({
                top: 34
              })
              .fontColor($r('app.color.black_40'))
              .fontSize('17fp')

            if (this.noteInfo.content!='') {
              Text(this.noteInfo.content)
                .margin({
                  top: 35, bottom: 10
                })
                .fontSize(CommonConstants.FONT_SIZE_19)
            }
            else {
              Text("暂无内容在此地，请继续努力")
                .margin({
                  top: 35, bottom: 10
                })
                .fontColor($r('app.color.black_40'))
                .fontSize(CommonConstants.FONT_SIZE_19)
            }

            List({ space: 10, initialIndex: 0 }) {
              ForEach(this.noteInfo.imageArr.length > 5 ? JSON.parse(this.noteInfo.imageArr) : [""], (item) => {
                ListItem() {
                  Image(item)
                    .width(CommonConstants.FULL_WIDTH)
                }
              })
            }
            .width(CommonConstants.FULL_WIDTH)
            .height(CommonConstants.FULL_HEIGHT)
            .enabled(false)
          }
          .alignItems(HorizontalAlign.Start)
        }.scrollable(ScrollDirection.Vertical)
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
      .padding({ left: CommonConstants.MARGIN_2, right: CommonConstants.MARGIN_1 })
      //.backgroundColor($r('app.color.background'))
    }
    .height('100%')
  }

  // 生命周期函数
  onPageShow(): void {

    const params=router.getParams() as {currentId1:number}
    // this.noteInfo.id = params.currentId1
    this.currentId = params.currentId1
    // Logger.info('wuhao',this.noteInfo.id.toString())
    // this.getNoteInfo()
    this.getNoteInfo()

  }

  getNoteInfo(){
    this.dbApi.queryById(this.currentId.toString(),(result)=>{
      this.noteInfo = result[0]
      Logger.info('wuhao',JSON.stringify(this.noteInfo))
    })
    // this.dbApi.queryAll((result)=>{
    //     this.noteInfo = result[0]
    //     Logger.info('wuhao',JSON.stringify(this.noteInfo))
    // })
  }

}