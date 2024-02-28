import type { DetailItemData } from './DetailItemData';

/**
 * Detail list item info.
 */
export class DetailListItem {
  /**
   * Detail list item index.
   */
  index: number;

  /**
   * Detail list item title.
   */
  name: Resource;

  /**
   * Detail list item data.
   */
  songs: Array<DetailItemData>; // tracks:
}

/**
 * 获取歌单详情 类型
 */
export class playlistDetailType {
  /**
   * Detail list item index.
   */
  index: number;

  /**
   * Detail list item title.
   */
  name: Resource;

  // 描述
  description: string;
  // 背景图片
  coverImgUrl: string;
  // 播放次数
  playCount: string;
  // 收藏数
  subscribedCount: string;
  // Hi-Res
  relateResType: Boolean;

  /**
   * Detail list item data.
   */
  tracks: Array<DetailItemData>; // tracks:
}

/**
 * 跳转分类详情URL
 */
export class DataModel {
  id: string;
}