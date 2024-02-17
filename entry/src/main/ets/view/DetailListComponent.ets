import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailListItem } from '../common/bean/DetailListItem';
import type { DetailItemData } from '../common/bean/DetailItemData';
import CategoryViewModel from '../viewmodel/CategoryViewModel';
import Logger from '../common/util/Logger';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from  '../viewmodel/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import promptAction from '@ohos.promptAction';
import { AVPlayer } from './AVPlayer';

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
          let { avPlayerUrl } = new AVPlayer();
          Logger.error("musicDetail.url===>", JSON.stringify(musicDetail.url));
          avPlayerUrl(musicDetail.url);
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

