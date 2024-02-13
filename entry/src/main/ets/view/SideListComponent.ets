import { CommonConstants } from '../common/constants/CommonConstants';
import type { SideListItem } from '../common/bean/SideListItem';
import Logger from '../common/util/Logger';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from  '../viewmodel/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import promptAction from '@ohos.promptAction';


/**
 * Category side list component.
 */
@Component
export struct SideListComponent {
  scroller: Scroller;
  @Prop sideListBreakpoint: string;
  @Link sideList: Array<object>;
  @Link sideListIndex: number;
  @Link sideItemId: string;
  @Link musicDetailItems: object

  // 建自定义组件的新实例后，在执行其build()函数之前执行
  aboutToAppear(){
    Logger.info("详情页sideItemId-->", JSON.stringify(this.sideItemId));
    if(this.sideItemId){
      this.getMusicItem();
    }
  }

  // 获取分类歌曲列表
  getMusicItem(){
    musicTopListViewModel.getMusicTopItem(Const.PLAY_LIST_DETAIL, this.sideItemId)
      // @ts-ignore
      .then((data: ResponseResult) => {
        // Logger.error("data=======>", JSON.stringify(data));
        if (data.code === Const.HTTP_CODE_200) {
          // let { playlist={} } = data;
          // @ts-ignore
          this.musicDetailItems = data.playlist;

          Logger.info("musicDetailListItems-->", JSON.stringify(this.musicDetailItems))
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
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      List() {
        ForEach(this.sideList, (item: SideListItem, index: number) => {
          ListItem() {
            Text(item.name)
              .fontSize($r('app.float.List_item_text_size'))
              .fontWeight(CommonConstants.INDEX_LIST_FONT_WEIGHT)
              .fontColor(this.sideListIndex === index ?
                $r('app.color.tab_text_activated') : $r('app.color.list_text_normal'))
              .textAlign(TextAlign.Start)
              .margin({
                top: $r('app.float.List_item_text_margin_top'),
                bottom: $r('app.float.side_list_text_margin_bottom'),
                left: this.sideListBreakpoint === CommonConstants.BREAK_POINT_SM ?
                  $r('app.float.text_margin_left_xs') : $r('app.float.text_margin_left_normal')
              })
              .width(CommonConstants.FULL_WIDTH_PERCENT)
              .onClick(() => {
                this.sideListIndex = index;
                this.sideItemId = item.id;
                this.getMusicItem();
                Logger.error("侧边栏sideItemId", JSON.stringify(this.sideItemId));
                // 当前选中side
                this.scroller.scrollToIndex(this.sideListIndex);
              })
          }
        }, (item, index) => index + JSON.stringify(item))
      }
      .constraintSize({
        minWidth: $r('app.float.side_minWidth')
      })
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height(CommonConstants.FULL_HEIGHT_PERCENT)
      .margin({ top: $r('app.float.side_list_margin_top') })

      Divider()
        .vertical(true)
        .color($r('app.color.divider'))
        .strokeWidth(CommonConstants.DIVIDER_STROKE_WIDTH)
        .margin({ bottom: $r('app.float.divider_margin_bottom') })
    }
  }
}