/**
 * Common constants for all features.
 */
export class CommonConstants {
  /**
   * 服务器地址
   */
  static readonly SERVER: string = 'http://192.168.3.126:3000'; // https://netease-music.zeabur.app;

  /**
   * 所有榜单
   * 在线文档：https://docs.neteasecloudmusicapi.binaryify.com/#/?id=%e6%89%80%e6%9c%89%e6%a6%9c%e5%8d%95%e5%86%85%e5%ae%b9%e6%91%98%e8%a6%81
   * 必选参数 : id : 歌单 id
   */
  static readonly TOP_LIST: string = 'toplist/detail';

  /**
   * 获取歌单详情
   * 在线文档 : https://docs.neteasecloudmusicapi.binaryify.com/#/?id=%e8%8e%b7%e5%8f%96%e6%ad%8c%e5%8d%95%e8%af%a6%e6%83%85
   */
  static readonly PLAY_LIST_DETAIL: string = 'playlist/detail'

  /**
   * 获取歌单所有歌曲
   *  在线文档 : https://docs.neteasecloudmusicapi.binaryify.com/#/?id=%e8%8e%b7%e5%8f%96%e6%ad%8c%e5%8d%95%e6%89%80%e6%9c%89%e6%ad%8c%e6%9b%b2
   *  必选参数 : id : 歌单 id
   *  可选参数 : limit : 限制获取歌曲的数量，默认值为当前歌单的歌曲数量
   *  可选参数 : offset : 默认值为0
   *  注：关于offset，你可以这样理解，假设你当前的歌单有200首歌
   *    你传入limit=50&offset=0等价于limit=50，你会得到第1-50首歌曲
   *    你传入limit=50&offset=50，你会得到第51-100首歌曲
   *    如果你设置limit=50&offset=100，你就会得到第101-150首歌曲
   */
  static readonly PLAY_LIST_TRACK_ALL: string = 'playlist/track/all'

  /**
   * 获取音乐 url
   */
  static readonly SONG_URL: string = 'song/url'

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: string = 'success';

  /**
   * Search weight.
   */
  static readonly SEARCH_WEIGHT: number = 10;

  /**
   * The divider stroke width.
   */
  static readonly DIVIDER_STROKE_WIDTH: number = 1;

  /**
   * The offset of detail list for LG device.
   */
  static readonly DETAIL_LIST_OFFSET_LG: number = 1;

  /**
   * The offset of detail list for MD device.
   */
  static readonly DETAIL_LIST_OFFSET_MD: number = 1;

  /**
   * The span of detail list for LG device.
   */
  static readonly DETAIL_LIST_SPAN_LG: number = 9;

  /**
   * The span of detail list for MD device.
   */
  static readonly DETAIL_LIST_SPAN_MD: number = 6;

  /**
   * The span of detail list for SM device.
   */
  static readonly DETAIL_LIST_SPAN_SM: number = 3;

  /**
   * The span of side list for SM device.
   */
  static readonly SIDE_LIST_SPAN_SM: number = 1;

  /**
   * The span of side list for MD device.
   */
  static readonly SIDE_LIST_SPAN_MD: number = 2;

  /**
   * The span of side list for LG device.
   */
  static readonly SIDE_LIST_SPAN_LG: number = 2;

  /**
   * The span of top component for LG device.
   */
  static readonly TOP_SPAN_LG: number = 12;

  /**
   * The span of top component for MD device.
   */
  static readonly TOP_SPAN_MD: number = 8;

  /**
   * The span of top component for SM device.
   */
  static readonly TOP_SPAN_SM: number = 4;

  /**
   * The columns for LG device.
   */
  static readonly COLUMN_LG: number = 12;

  /**
   * The columns for MD device.
   */
  static readonly COLUMN_MD: number = 8;

  /**
   * The columns for SM device.
   */
  static readonly COLUMN_SM: number = 4;

  /**
   * The columns of grid columns gap except SM device.
   */
  static readonly GRID_COLUMNS_GAP_NORMAL: number = 24;

  /**
   * The columns of grid columns gap for SM device.
   */
  static readonly GRID_COLUMNS_GAP_SM: number = 12;

  /**
   * The gutter for all devices.
   */
  static readonly GUTTER_X: number = vp2px(24);

  /**
   * The break point value.
   */
  static readonly BREAK_POINTS_VALUE: Array<string> = ['320vp', '600vp', '840vp'];

  /**
   * Three item template of Grid.
   */
  static readonly GRID_TEMPLATE_THREE: string = '1fr 1fr 1fr';

  /**
   * Two item template of Grid.
   */
  static readonly GRID_TEMPLATE_TWO: string = '1fr 1fr';

  /**
   * Break point is sm.
   */
  static readonly BREAK_POINT_SM: string = 'sm';

  /**
   * Break point is lg.
   */
  static readonly BREAK_POINT_LG: string = 'lg';

  /**
   * The placeholder of search component.Currently, component interfaces do not support the Resource type.
   * Therefore, you need to define constants. The default prompt in the search box does not support
   * internationalization.
   */
  static readonly SEARCH_PLACEHOLDER: string = '搜索...';

  /**
   * Search font family.
   */
  static readonly SEARCH_FONT_FAMILY: string = 'serif';

  /**
   * The font weight of text in the index list.
   */
  static readonly INDEX_LIST_FONT_WEIGHT: number = 400;

  /**
   * Size of index list and detail list.
   */
  static readonly LIST_SIZE: number = 4;

  /**
   * 排行榜类别
   */
  static readonly RANKING_LIST: Array<string> = ['飙升', '新歌', '原创', '热歌'];

  /**
   * The font weight of text in the detail list.
   */
  static readonly DETAIL_LIST_FONT_WEIGHT: number = 500;

  /**
   * The font weight of text in the tab.
   */
  static readonly TAB_ITEM_FONT_WEIGHT: number = 500;

  /**
   * Size of tab bar.
   */
  static readonly TAB_BAR_SIZE: number = 5;

  /**
   * Tab layout weight.
   */
  static readonly TAB_LAYOUT_WEIGHT: number = 1;

  /**
   * The font weight of title.
   */
  static readonly TITLE_FONT_WEIGHT: number = 500;

  /**
   * The font weight of subtitle.
   */
  static readonly SUBTITLE_FONT_WEIGHT: number = 400;

  /**
   * Size of detail item.
   */
  static readonly DETAIL_ITEM_SIZE: number = 6;

  /**
   * The percentage of the full width.
   */
  static readonly FULL_WIDTH_PERCENT: string = '100%';

  /**
   * The percentage of the full height.
   */
  static readonly FULL_HEIGHT_PERCENT: string = '100%';

  /**
   * The percentage of the half height.
   */
  static readonly HALF_HEIGHT_PERCENT: string = '45%';
}


/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json'
}
