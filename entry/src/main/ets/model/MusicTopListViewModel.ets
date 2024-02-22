import { httpRequestGet } from '../common/util/HttpUtil';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import Logger from '../../ets/common/util/Logger'

/**
 * 榜单
 */
class MusicTopListViewModel{
  // 获取音乐分类
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
  // 根据分类查询详情
  getMusicTopItem(path:string, id:string, limit:number, offset:number): Promise<musicTopItemData[]>{
    // Logger.error("id----->", id);
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${path}?id=${id}&limit=${limit}&offset=${offset}`;
      // console.log("url------>", url);
      httpRequestGet(url).then((data) => {
      // Logger.error('data------->', JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          resolve(data);
        } else {
          Logger.error('getMusicTopItem failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getMusicTopItem failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
  // 获取音乐URL
  getMusicUrl(path:string, id: string): Promise<musicUrlData>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${Const.SERVER}/${path}?id=${id}`;
      console.log("url------>", url);
      httpRequestGet(url).then((data) => {
        Logger.error('data------->', JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          resolve(data);
        } else {
          Logger.error('getMusicTopItem failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getMusicTopItem failed', JSON.stringify(err));
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

export class musicTopItemData{
  playlist: object;

  constructor() {
    this.playlist = {};
  }
}

export class musicUrlData{
  musicUrl: Array<object>;

  constructor() {
    this.musicUrl = [];
  }
}

export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  code: string | number;

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