/**
 * Grid item data.
 */
export class DetailItemData {
  /**
   * Grid item content.
   */
  name: Resource;
  id: number;
  title: string;
  singer: string
  label: Resource | string;
  /**
   * 歌手
   */
  ar: [
    {
      id: string,
      name: string
    }
  ];

  /**
   * 歌曲
   */
  al: {
    "id": string | number,
    "name": string,
    "picUrl": string,
    "tns": [],
    "pic_str": string,
    "pic": string | number
  }
  length: Number;
}