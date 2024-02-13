import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailListItem } from '../common/bean/DetailListItem';
import type { DetailItemData } from '../common/bean/DetailItemData';
import CategoryViewModel from '../viewmodel/CategoryViewModel';
import Logger from '../common/util/Logger';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from  '../viewmodel/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import promptAction from '@ohos.promptAction';

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
            // .backgroundColor($r('app.color.grid_text_background'))
            .backgroundImage(item.al.picUrl)
          }, (item, index) => index + JSON.stringify(item))
        }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

