
import http from '@ohos.net.http';
import axios from '@ohos/axios';
import { ResponseResult } from '../../viewmodel/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../constants/CommonConstants';
import Logger from './Logger';

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGet(url: string) {
  // let serverData: ResponseResult = new ResponseResult();
  return axios.get(url).then((res) => {
    Logger.error("res-->", JSON.stringify(res));
    let { data } = res;
    // if (data.code == Const.HTTP_CODE_200) {
    //     let result = `${data}`;
    //     let resultJson: ResponseResult = JSON.parse(result);
    //     serverData.list = resultJson.list;
    //     serverData.code = resultJson.code;
    //     serverData.msg = resultJson.msg;
    // } else {
    //   serverData.msg = `${$r('app.string.http_error_message')}&${data.code}`;
    // }
    // console.log("serverData-->", JSON.stringify(serverData));
    return data;
  })
  // let httpRequest = http.createHttp();
  // Logger.error("--url->", url);
  // let responseResult = httpRequest.request(url, {
  //   method: http.RequestMethod.GET,
  //   header: {
  //     'Content-Type': ContentType.JSON
  //   },
  //   readTimeout: Const.HTTP_READ_TIMEOUT,
  //   connectTimeout: Const.HTTP_READ_TIMEOUT,
  //   extraData: {}
  // });
  // let serverData: ResponseResult = new ResponseResult();
  // Logger.info("responseResult", JSON.stringify(responseResult));
  // Logger.info("serverData-->", JSON.stringify(serverData));
  // // Processes the data and returns.
  // return responseResult.then((value: http.HttpResponse) => {
  //   Logger.error("value-->", JSON.stringify(value));
  //   if (value.responseCode === Const.HTTP_CODE_200) {
  //     // Obtains the returned data.
  //     Logger.error("value.result-->", JSON.stringify(value.result));
  //     let result = `${value.result}`;
  //     let resultJson: ResponseResult = JSON.parse(result);
  //     if (resultJson.code === Const.SERVER_CODE_SUCCESS) {
  //       serverData.data = resultJson.data;
  //     }
  //     serverData.code = resultJson.code;
  //     serverData.msg = resultJson.msg;
  //   } else {
  //     serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
  //   }
  //   return serverData;
  // }).catch(() => {
  //   serverData.msg = $r('app.string.http_error_message');
  //   return serverData;
  // })
}