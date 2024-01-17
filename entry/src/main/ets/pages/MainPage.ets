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
  @State searchChangeValue:string=''
  @State searchSubmitValue:string=''

  private controller:SearchController = new SearchController()
  private scroller:Scroller = new Scroller()
  private noteScroller:Scroller = new Scroller()
  private arr:number[] = [1,2,3,4,5,6,7,8,9,10]

  build() {
    Row() {
      Column() {
        Column(){
          Search({value:this.searchChangeValue,placeholder:'请输入搜索内容',controller:this.controller})
            .width('80%')
            .height(30)
            .onSubmit((value:string)=>{
              this.searchSubmitValue = value
            })
        }
        Column(){
          Text('日期')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Scroll(this.scroller){
            Flex({direction:FlexDirection.Row}){
              ForEach(this.arr,(item)=>{
                Row(){
                  Text(item.toString())
                    .width('10%')
                    .height(60)
                    .backgroundColor('#3366CC')
                    .textAlign(TextAlign.Center)
                    .margin({left:10})
                    .onClick(()=>{
                      //点击选择日期相应的文件
                    })
                }
              },item=>item)
            }
            .margin({top:5})
          }
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Horizontal)

          ScrollBar({scroller:this.scroller,direction:ScrollBarDirection.Horizontal,state:BarState.Auto}){
            Text()
              .height(40)
              .backgroundColor('#C0C0C0')
          }
        }
        Column(){
          Text(this.message)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 笔记列表
          Scroll(this.noteScroller){
            Flex({direction:FlexDirection.Column}){
              ForEach(this.noteInfoList,(item,index)=>{
                Column(){
                  NotebookItem({
                    noteInfo: item,
                    // click: (id) => {
                    //   // todo 点击笔记，跳转至详情页
                    //   router.pushUrl({url:'pages/NotePage'}).then(()=>{
                    //
                    //   }).catch(()=>{
                    //
                    //   })
                    // },
                    // delete: (id) => {
                    //   // todo 删除笔记
                    // }
                  })
                  Text('1')
                    .height(30)
                    .width('100%')
                }
              },item=>item)
            }
            .margin({top:15})
          }
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Horizontal)
          .priorityGesture(PanGesture)

          ScrollBar({scroller:this.noteScroller,direction:ScrollBarDirection.Vertical,state:BarState.Auto}){
            Text()
              .height(40)
              .backgroundColor('#C0C0C0')
          }
          // List({ space: 0, initialIndex: 0,scroller:this.noteScroller }) {
          //   // ForEach(this.noteInfoList, (item, index) => {
          //   //   ListItem() {
          //   //     NotebookItem({
          //   //       noteInfo: item,
          //   //       click: (id) => {
          //   //         // todo 点击笔记，跳转至详情页
          //   //         router.pushUrl({url:'pages/NotePage'}).then(()=>{
          //   //
          //   //         }).catch(()=>{
          //   //
          //   //         })
          //   //       },
          //   //       delete: (id) => {
          //   //         // todo 删除笔记
          //   //       }
          //   //     })
          //   //   }
          //   // })
          // }
          // .width(CommonConstants.FULL_WIDTH)
          // .height(CommonConstants.FULL_HEIGHT)
          // .edgeEffect(EdgeEffect.Spring)
          // .onScrollIndex((firstIndex:number,lastIndex:number)=>{
          //
          // })



          // .backgroundColor($r('app.color.background'))
        }
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
      },
      {
        id: 3,
        title: "笔记3",
        content: "我是内容2",
        date: "02/21",
        imageArr: ""
      },
      {
        id: 4,
        title: "笔记4",
        content: "我是内容2",
        date: "02/21",
        imageArr: ""
      },
      {
        id: 5,
        title: "笔记5",
        content: "我是内容2",
        date: "02/21",
        imageArr: ""
      },
      {
        id: 6,
        title: "笔记6",
        content: "我是内容2",
        date: "02/21",
        imageArr: ""
      }
    ]
  }
}