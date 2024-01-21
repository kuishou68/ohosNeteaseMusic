import { httpRequestGet } from '../common/util/HttpUtil';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import Logger from '../../ets/common/util/Logger'

/**
 * 获取音乐分类
 */
class MusicTopListViewModel{
  getMusicTopListList(path: string): Promise<musicTopListData[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${path}`;
      // url += '?currentPage=' + currentPage + '&pageSize=' + pageSize;
      httpRequestGet(url).then((data) => {
        // Logger.error('data-->', JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          resolve(data);
        } else {
          Logger.error('getMusicTopListList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getMusicTopListList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let musicTopListViewModel = new MusicTopListViewModel();

export default musicTopListViewModel as MusicTopListViewModel;

export class musicTopListData{
  name: string;
  updateFrequency: string;
  coverImgUrl: string;

  constructor() {
    this.name = "排行榜";
    this.updateFrequency = "";
    this.updateFrequency = "";
  }
}

export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  code: string;

  /**
   * Message returned by the network request.
   */
  msg: string | Resource;

  /**
   * Data returned by the network request.
   */
  data: string | Object | ArrayBuffer;

  list: Array<object> | Array<string> | object;

  constructor() {
    this.code = '';
    this.msg = '';
    this.data = '';
    this.list = [];
  }
}