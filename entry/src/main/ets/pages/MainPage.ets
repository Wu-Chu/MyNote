// 导入页面路由模块
import router from '@ohos.router';

import CommonConstants from '../common/constants/CommonConstants'
import NoteInfo from '../common/bean/NoteInfo'

import { NotebookItem } from '../view/NotebookItem'

@Entry
@Component
struct MainPage {
  @State message: string = '主界面';
  @State noteInfoList: NoteInfo[] = []; // 笔记信息列表

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        // 笔记列表
        List({ space: 0, initialIndex: 0 }) {
          ForEach(this.noteInfoList, (item, index) => {
            ListItem() {
              NotebookItem({
                noteInfo: item,
                click: (id) => {
                  // todo 点击笔记，跳转至详情页
                  router.pushUrl({url:'pages/NotePage'}).then(()=>{

                  }).catch(()=>{

                  })
                },
                delete: (id) => {
                  // todo 删除笔记
                }
              })
            }
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
        .layoutWeight(1)


      // .backgroundColor($r('app.color.background'))
    }
    .width('100%')
  }

  .height('100%')
}

  // 生命周期函数
  onPageShow(): void {
    this.refreshData()
  }

  // 查询笔记数据
  refreshData() {
    // todo 查询笔记数据
    // 为了展示页面效果添加的临时数据
    this.noteInfoList = [
      {
        id: 1,
        title: "笔记1",
        content: "我是内容1",
        date: "03/20",
        imageArr: ""
      },
      {
        id: 2,
        title: "笔记2",
        content: "我是内容2",
        date: "02/21",
        imageArr: ""
      }
    ]
  }
}