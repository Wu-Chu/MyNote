export default class CommonConstants {
  static readonly notebookName: string = '记事本'
  static readonly KEY_NOTEBOOK_NAME: string = 'notebookName';
  static readonly PREFERENCE_NAME: string = 'myStore';
  static readonly FULL_WIDTH: string = '100%';
  static readonly FULL_HEIGHT: string = '100%';
  static readonly MARGIN_1: number = 17;
  static readonly MARGIN_2: number = 24;
  static readonly MARGIN_17: Object = {
    left: 17,
    right: 17
  };
  static readonly MARGIN_24: Object = {
    left: 24,
    right: 24
  };
  static readonly FONT_SIZE_17: string = '17fp';
  static readonly FONT_SIZE_19: string = '19fp';
  static readonly FONT_SIZE_22: string = '22fp';
  static readonly FONT_SIZE_29: string = '29fp';
  static readonly FONT_SIZE_38: string = '38fp';
}

export const STORE_CONFIG = { name: 'noteInfo.db' };

export const NOTE_INFO = {
  tableName: 'noteInfo',
  sqlCreate: 'CREATE TABLE IF NOT EXISTS noteInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, ' +
    'title TEXT NOT NULL, content TEXT NOT NULL, imageArr TEXT NOT NULL)',
  columns: ['id', 'date', 'title', 'content', 'imageArr']
}