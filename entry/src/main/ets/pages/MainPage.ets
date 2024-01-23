// 导入页面路由模块
import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants'
import NoteInfo from '../common/bean/NoteInfo'
import { NotebookItem } from '../view/NotebookItem'
import { NoteInfoTable } from '../common/database/NoteInfo';

@Entry
@Component
struct MainPage {
  @State message: string = '主界面';
  @State deleteMode: boolean = false;
  @State noteInfoList: NoteInfo[] = []; // 笔记信息列表
  @State searchChangeValue:string=''
  @State searchSubmitValue:string=''
  @State month:boolean[]=[true,true,true,true,true,true,true,true,true,true,true,true]

  private controller:SearchController = new SearchController()
  private scroller:Scroller = new Scroller()
  private noteScroller:Scroller = new Scroller()
  private arr:number[] = [1,2,3,4,5,6,7,8,9,10,11,12]

  @Builder tabMonth(month: number) {
    Row(){
      Text(month.toString())
        .width(40)
        .height(40)
        .fontSize('20fp')
        .fontColor('#ffffff')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.month[month-1] == true ? '#3366cc':'#ffa5c0e0')
        .margin(3)
        .onClick(()=>{
          if(this.month[month-1]){
            this.month[month-1]=false;
          }else{
            this.month[month-1]=true;
          }
          //点击选择月份相应的文件
        })
    }
  }

  build() {
    Row() {
      Column() {
        Column(){
          Search({value:this.searchChangeValue,placeholder:'请输入搜索内容',controller:this.controller})
            .width('100%')
            .height(30)
            .onSubmit((value:string)=>{
              this.searchSubmitValue = value
            })
        }//搜索栏
        Column(){
          Text('月份')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin(15)
            .width('100%')
            .textAlign(TextAlign.Start)
          Scroll(this.scroller){
            Row(){
              ForEach(this.arr,(item)=>{
                this.tabMonth(item)
              },item=>item)
            }
          }
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Horizontal)

          ScrollBar({scroller:this.scroller,direction:ScrollBarDirection.Horizontal,state:BarState.Auto}){
            Text()
              .height(20)
              .backgroundColor('#C0C0C0')
          }
        }//月份筛选
        Column(){
          Row(){
            Text(this.message)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)
            Button('-',{ type: ButtonType.Circle, stateEffect: true })
              .width(30)
              .margin(3)
              .padding(-5)
              .fontSize(16)
              .backgroundColor(this.deleteMode?'#ff0000': '#ff629afc')
              .onClick(()=>{
                if(this.deleteMode){
                  this.deleteMode = false;
                }else{
                  this.deleteMode = true;
                }
              })//切换删除模式
            Button('+',{ type: ButtonType.Circle, stateEffect: true })
              .width(30)
              .margin(3)
              .padding(-5)
              .fontSize(16)
              .backgroundColor('#ff629afc')
              .onClick(()=>{
                router.pushUrl({url:'pages/AddPage'})
              })
          }
          Divider()
            .margin({top:15})
          // 笔记列表
          Scroll(this.noteScroller){
            Flex({direction:FlexDirection.Column}){
              ForEach(this.noteInfoList,(item,index)=>{
                Column(){
                  if(this.month[item.date.toString().substring(0,2)-1] && (item.content.indexOf(this.searchSubmitValue) != -1||item.title.indexOf(this.searchSubmitValue) != -1)){
                    Stack({alignContent:Alignment.End}){
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
                      Button('-',{ type: ButtonType.Circle, stateEffect: true })
                        .width(25)
                        .margin({ right:20,bottom:50 })
                        .padding(-5)
                        .fontSize(16)
                        .borderWidth(2)
                        .borderColor('#ff0000')
                        .fontColor('#ff0000')
                        .backgroundColor('#ffffff')
                        .onClick(()=>{
                          //删除指定文件
                        })
                        .visibility(this.deleteMode ? Visibility.Visible : Visibility.Hidden)
                    }
                  }
                  //Text(index.toString())
                  //  .height(30)
                  //  .width('100%')
                }
              },item=>item)
            }
            .margin({top:15})
          }
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Vertical)
          .priorityGesture(PanGesture)
          .backgroundColor('#fff0f1f3')

          ScrollBar({scroller:this.noteScroller,direction:ScrollBarDirection.Vertical,state:BarState.Auto}){
            Text()
              .height(20)
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
        }.layoutWeight(1)//笔记列表
        Text()
          .height(20)
          .backgroundColor('#C0C0C0')
      }
      .width('90%')
      .margin('5%')
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
        title: "",
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
        date: "01/21",
        imageArr: ""
      },
      {
        id: 6,
        title: "笔记6",
        content: "我是内容2",
        date: "01/21",
        imageArr: ""
      }
    ]
  }
}