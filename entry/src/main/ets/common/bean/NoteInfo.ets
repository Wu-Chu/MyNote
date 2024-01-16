export default class NoteInfo {
  id: number;
  date: string;
  title: string;
  content: string;
  imageArr: string;

  constructor(id: number, date: string, title: string, content: string, imageArr: string) {
    this.id = id;
    this.date = date;
    this.title = title;
    this.content = content;
    this.imageArr = imageArr;
  }
}
