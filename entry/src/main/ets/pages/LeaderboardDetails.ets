import router from '@ohos.router';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import Header from '../common/playlist/Header'
import Player from '../common/playlist/Player'
import Content from '../common/playlist/Content'
import { DataModel } from '../common/bean/DetailListItem';
import musicTopListViewModel from '../model/MusicTopListViewModel';
import Logger from '../common/util/Logger';
import promptAction from '@ohos.promptAction';

/**
 * 排行榜详情
 */
@Entry
@Component
struct LeaderboardDetails {
  @State currentBreakpoint: string = Const.BREAK_POINT_SM;
  @State sideItemId: string = "";
  @State musicDetailItems: object = {};

  onPageShow() {
    const params: any = router.getParams(); // 获取传递过来的参数对象
    Logger.error("params====>", JSON.stringify(params));
    this.sideItemId = params.id;
    if(this.sideItemId){
      this.getMusicItem();
    }
  }

  // 获取分类歌曲列表
  getMusicItem(){
    musicTopListViewModel.playlistDetail(Const.PLAY_LIST_DETAIL, this.sideItemId)
      // @ts-ignore
      .then((data: ResponseResult) => {
        // Logger.error("data=======>", JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          let { playlist={} } = data;
          this.musicDetailItems = playlist;
          Logger.error("musicDetailItems====>", JSON.stringify(this.musicDetailItems));
        } else {
          Logger.error('getMusicTopItem failed', JSON.stringify(data));
        }
      })
      .catch((err: string | Resource) => {
        promptAction.showToast({
          message: err,
          duration: Const.ANIMATION_DURATION
        });
      });
  }

  build(){
    Stack({ alignContent: Alignment.Bottom }) {
      Stack({ alignContent: Alignment.Top }) {
        Header({
          musicDetailItems: $musicDetailItems
        })
        Content({
          musicDetailItems: $musicDetailItems
        })
      }
      Player()
    }
    .width('100%')
    .backgroundColor(this.currentBreakpoint === 'sm' ? '#e4ecf7' : '#f6f9fc')
  }
}