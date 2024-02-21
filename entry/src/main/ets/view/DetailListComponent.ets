import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailListItem } from '../common/bean/DetailListItem';
import type { DetailItemData } from '../common/bean/DetailItemData';
import CategoryViewModel from '../model/CategoryViewModel';
import Logger from '../common/util/Logger';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from '../model/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import promptAction from '@ohos.promptAction';
import { AVPlayer } from './AVPlayer';
import media from '@ohos.multimedia.media';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';

/**
 * Category detail list component.
 */
@Component
export struct DetailListComponent {
  scroller: Scroller;
  @Prop detailListBreakpoint: string;
  @Link sideListIndex: number;
  @Link sideItemId: string;
  @Link musicDetailItems: object;

  build() {
    List({ scroller: this.scroller }) {
      // CategoryViewModel.getDetailListItems()
      ForEach([this.musicDetailItems], (item: DetailListItem) => {
        ListItem() {
          CategoryListItem({
            detailListItem: item,
            currentBreakpoint: this.detailListBreakpoint
          })
        }
      }, (item, index) => index + JSON.stringify(item))
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .onScrollIndex((firstIndex: number) => {
      this.sideListIndex = firstIndex;
    })
  }
}

@Component
struct CategoryListItem {
  private avPlayer;
  private count: number = 0;
  private detailListItem: DetailListItem;
  @Prop currentBreakpoint: string;

  // 获取音乐URL
  getMusicUrl(item){
    musicTopListViewModel.getMusicUrl(Const.SONG_URL, item.id)
      // @ts-ignore
      .then((data: ResponseResult) => {
        // Logger.error("data=======>", JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          Logger.info("音乐详情-->", JSON.stringify(data.data[0]))
          let musicDetail = data.data[0];
          // let AVPlayer = new AVPlayer();
          Logger.error("musicDetailUrl===>", JSON.stringify(musicDetail.url));
          this.avPlayerUrl(musicDetail.url);
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



    // 注册avplayer回调函数
    setAVPlayerCallback() {
      // seek操作结果回调函数
      this.avPlayer.on('seekDone', (seekDoneTime) => {
        console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
      })
      // error回调监听函数,当avPlayer在操作过程中出现错误时调用reset接口触发重置流程
      this.avPlayer.on('error', (err) => {
        console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
        this.avPlayer.reset(); // 调用reset重置资源，触发idle状态
      })
      // this.avPlayer.on('audioInterrupt', )
      // 状态机变化回调函数
      this.avPlayer.on('stateChange', async (state, reason) => {
        switch (state) {
          case 'idle': // 成功调用reset接口后触发该状态机上报
            console.info('AVPlayer state idle called.');
            this.avPlayer.release(); // 调用release接口销毁实例对象
            break;
          case 'initialized': // avplayer 设置播放源后触发该状态上报
            console.info('AVPlayerstate initialized called.');
            this.avPlayer.prepare().then(() => {
              console.info('AVPlayer prepare succeeded.');
            }, (err) => {
              console.error(`Invoke prepare failed, code is ${err.code}, message is ${err.message}`);
            });
            break;
          case 'prepared': // prepare调用成功后上报该状态机
            console.info('AVPlayer state prepared called.');
            this.avPlayer.play(); // 调用播放接口开始播放
            break;
          case 'playing': // play成功调用后触发该状态机上报
            console.info('AVPlayer state playing called.');
            // if (this.count !== 0) {
            //   console.info('AVPlayer start to seek.');
            //   this.avPlayer.seek(this.avPlayer.duration); //seek到音频末尾
            // } else {
            //   this.avPlayer.pause(); // 调用暂停接口暂停播放
            // }
            this.count++;
            break;
          case 'paused': // pause成功调用后触发该状态机上报
            console.info('AVPlayer state paused called.');
            this.avPlayer.play(); // 再次播放接口开始播放
            break;
          case 'completed': // 播放结束后触发该状态机上报
            console.info('AVPlayer state completed called.');
            this.avPlayer.stop(); //调用播放结束接口
            break;
          case 'stopped': // stop接口成功调用后触发该状态机上报
            console.info('AVPlayer state stopped called.');
            this.avPlayer.reset(); // 调用reset接口初始化avplayer状态
            break;
          case 'released':
            console.info('AVPlayer state released called.');
            break;
          default:
            console.info('AVPlayer state unknown called.');
            break;
        }
      })
    }

    // 以下demo为使用fs文件系统打开沙箱地址获取媒体文件地址并通过url属性进行播放示例
    async avPlayerUrl(url) {
      Logger.error("musicUrl===>", JSON.stringify(url));
      // 创建avPlayer实例对象
      this.avPlayer = await media.createAVPlayer();
      // 创建状态机变化回调函数
      this.setAVPlayerCallback();
      // 重置播放
      this.avPlayer.reset();
      Logger.error("avPlayer===>", JSON.stringify(this.avPlayer));
      this.avPlayer.url = url;
    }

  build() {
    Column() {
      Text(this.detailListItem.name)
        .height($r('app.float.detail_list_text_height'))
        .fontSize($r('app.float.detail_list_text_size'))
        .fontColor($r('app.color.list_item_text'))
        .fontWeight(CommonConstants.DETAIL_LIST_FONT_WEIGHT)
        .align(Alignment.Start)

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.detailListItem.tracks, (item: DetailItemData) => {
          Text(item.name)
            .width(CommonConstants.HALF_HEIGHT_PERCENT)
            .height($r('app.float.detail_list_item_height'))
            .margin(5)
            .textAlign(TextAlign.Center)
            .fontSize($r('app.float.Grid_item_text_size'))
            .fontWeight(CommonConstants.TAB_ITEM_FONT_WEIGHT)
            .align(Alignment.Center)
            .borderRadius($r('app.float.grid_item_radius'))
            .fontColor($r('app.color.start_window_background'))
            .backgroundImage(item.al.picUrl ? item.al.picUrl : $r('app.color.grid_text_background'))
            .onClick(() => {
              Logger.error("当前歌曲===>", JSON.stringify(item));
              this.getMusicUrl(item);
            })
          }, (item, index) => index + JSON.stringify(item))
        }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

