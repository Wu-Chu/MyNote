import data_rdb from '@ohos.data.relationalStore'
import NoteInfo from '../bean/NoteInfo';


import {NOTE_INFO,STORE_CONFIG} from '../constants/CommonConstants'

export class NoteInfoTable{
  my_rdbStore:data_rdb.RdbStore

  getRdbStore(callback:()=>void){
    if(this.my_rdbStore){
      callback();
      return
    }

    //配置数据库
    const CONFIG = {
      name:STORE_CONFIG.name,
      securityLevel:data_rdb.SecurityLevel.S1
    }
    //创建数据库
    data_rdb.getRdbStore(globalThis.context,CONFIG,(err,RdbStore)=>{
      this.my_rdbStore = RdbStore;
      //建表
      RdbStore.executeSql(NOTE_INFO.sqlCreate,null)
    })
  }

  //插入笔记（新建笔记）
  insertNote(noteInfo:NoteInfo,callback:(successful:boolean)=>void){
    try{
      this.getRdbStore(()=>{
        //数据格式转换
        const valueBucket = generateBucket(noteInfo);

        this.my_rdbStore.insert(NOTE_INFO.tableName,valueBucket,function(status,rowID){
          if (status) {
            // Logger.info(Tag, "Insert is failed");
            return;
          }
          // Logger.info(Tag, "Insert is successful, rowId = " + rowId);
          callback(true);
        })
      })
    }catch(err){
      callback(false);
      // Logger.info(Tag, err);
    }
  }

  //通过id删除笔记
  deleteById(id, callback:(successful:boolean)=>void) {
    try {
      // 获取RdbStore
      this.getRdbStore(() => {
        // 获取RdbPredicates
        let predicates = new data_rdb.RdbPredicates(NOTE_INFO.tableName);
        // 匹配id字段
        predicates.equalTo("id", id);
        // 删除数据
        this.my_rdbStore.delete(predicates, function (err, rows) {
          if (err) {
            // Logger.info(Tag, "Delete failed, err: " + err);
            return
          }
          // Logger.info(Tag, "Delete rows: " + rows);
          callback(true);
        })
      })
    } catch (err) {
      callback(false);
      // Logger.info(Tag, err);
    }
  }

  //修改笔记（保存功能）
  updateNote(noteInfo: NoteInfo, callback:(successful:boolean)=>void) {
    try {
      // 获取RdbStore
      this.getRdbStore(() => {
        // 数据格式转换
        const valueBucket = generateBucket(noteInfo);
        // Logger.info(Tag, " updateNote " + JSON.stringify(valueBucket));
        // 获取RdbPredicates
        let predicates = new data_rdb.RdbPredicates(NOTE_INFO.tableName);
        // 匹配id字段
        predicates.equalTo("id", noteInfo.id);
        // 更新数据
        this.my_rdbStore.update(valueBucket, predicates, function (err, rows) {
          if (err) {
            // Logger.info(Tag, "Updated failed, err: " + err);
            callback(false);
            return
          }
          // Logger.info(Tag, "Updated row count: " + rows);
          callback(true);
        })
      })
    } catch (err) {
      callback(false);
      // Logger.info(Tag, err);
    }
  }



  //查找笔记
  //输入一个处理结果的回调函数
  queryAll(callback:(result:Array<NoteInfo>)=>void) {
    this.query(null,(a,b)=>{},callback)
  }

  queryById(id:string,callback:(result:Array<NoteInfo>)=>void){
    this.query(id,(predicates,input)=>{predicates.equalTo('id',input)},callback)
  }
  queryByTitle(title:string,callback:(result:Array<NoteInfo>)=>void){
    this.query(title,(predicates,input)=>{predicates.contains('title',input)},callback)
  }
  queryByDate(date:string,callback:(result:Array<NoteInfo>)=>void){
    this.query(date,(predicates,input)=>{predicates.equalTo('date',input)},callback)
  }

  private query(input:string,predicate:(predicates:data_rdb.RdbPredicates,input:string)=>void,callback:(result:Array<NoteInfo>)=>void) {
    try {
      // 获取RdbStore
      this.getRdbStore(() => {
        // 获取RdbPredicates
        let predicates = new data_rdb.RdbPredicates(NOTE_INFO.tableName)
        predicate(predicates,input)
        // 按照date字段降序排序
        predicates.orderByDesc('date');
        // 查询数据
        this.my_rdbStore.query(predicates, NOTE_INFO.columns, (err, resultSet) => {
          if (err) {
            // Logger.info(Tag, "query failed, err: " + err)
            return
          }
          let result: Array<NoteInfo> = []
          let count = resultSet.rowCount
          if (count === 0) {
            callback(result)
          } else {
            // 跳转到第一行
            resultSet.goToFirstRow()
            for (let i = 0;i < count; i++) {
              let tem = new NoteInfo(0, '', '', '', '')
              // 获取数据
              tem.id = resultSet.getDouble(resultSet.getColumnIndex('id'))
              tem.date = resultSet.getString(resultSet.getColumnIndex('date'))
              tem.title = resultSet.getString(resultSet.getColumnIndex('title'))
              tem.content = resultSet.getString(resultSet.getColumnIndex('content'))
              tem.imageArr = resultSet.getString(resultSet.getColumnIndex('imageArr'))
              result[i] = tem
              // 跳转到下一行
              resultSet.goToNextRow()
            }
            resultSet.close()
            callback(result)
          }
        })
      })
    } catch (err) {
      callback([]);
      // Logger.info(Tag, err);
    }
  }

}





// 数据转换
function generateBucket(noteInfo: NoteInfo) {
  let obj = {};
  NOTE_INFO.columns.forEach((item) => {
    if (item != 'id') {
      obj[item] = noteInfo[item];
    }
  });
  return obj;
}