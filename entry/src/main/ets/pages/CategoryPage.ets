import { DetailListComponent } from '../view/DetailListComponent';
import { SideListComponent } from '../view/SideListComponent';
import { TopComponent } from '../view/TopComponent';
import { CommonConstants } from '../common/constants/CommonConstants';
import type { TabItem } from '../common/bean/TabItem';
import promptAction from '@ohos.promptAction';
import CategoryViewModel from '../model/CategoryViewModel';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from '../model/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import Logger from '../common/util/Logger';

import BreakpointSystem from '../model/MediaData'


/**
 * This module template implements Category functions.
 * The left and right sides of the page are linked. Click the left option and
 * the right list will slide to the specified position, and vice versa.
 * Developers can add corresponding data as needed after creating a template.
 */
@Entry
@Component
struct CategoryPage {
  @State sideListData: Array<object> = []; // 侧边栏列表
  @State categoryTabIndex: number = 1;
  @State currentBreakpoint: string = CommonConstants.BREAK_POINT_SM;
  @State scrollerIndex: number = 1;
  @State scrollerItemId: string = "";
  @State musicDetailListItems: object = {};
  scroller: Scroller;

  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  // @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'

  // 建自定义组件的新实例后，在执行其build()函数之前执行
  aboutToAppear(){
    this.changeMusicCategory();
  }
  changeMusicCategory() {
    musicTopListViewModel.getMusicTopListList(Const.TOP_LIST)
      // @ts-ignore
      .then((data: ResponseResult) => {
        let { sideListData=[], scrollerIndex=1 } = this;
        let { list=[] } = data;
        // @ts-ignore
        if(list && list.length > 0) {
          // @ts-ignore
          this.sideListData = [...list];
          // @ts-ignore
          this.scrollerItemId = sideListData[scrollerIndex].id;
          Logger.error("this.scrollerItemId====>", JSON.stringify(this.scrollerItemId));
        }
        // Logger.info("this.sideListData", JSON.stringify(this.sideListData))
        // Logger.info("this.scrollerItemId", this.scrollerItemId);
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
      Tabs({
        index: this.categoryTabIndex,
        barPosition: this.currentBreakpoint === CommonConstants.BREAK_POINT_LG ?
          BarPosition.Start : BarPosition.End
      }) {
        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#E67C92')
        }
        .tabBar(this.TabBuilder(0, "推荐")) // this.TabBottom(item, index))

        TabContent() {
          GridRow({
            columns: {
              sm: CommonConstants.COLUMN_SM,
              md: CommonConstants.COLUMN_MD,
              lg: CommonConstants.COLUMN_LG
            },
            breakpoints: {
              value: CommonConstants.BREAK_POINTS_VALUE,
              reference: BreakpointsReference.WindowSize
            },
            gutter: { x: CommonConstants.GUTTER_X }
          }) {
            GridCol({
              span: {
                sm: CommonConstants.TOP_SPAN_SM,
                md: CommonConstants.TOP_SPAN_MD,
                lg: CommonConstants.TOP_SPAN_LG
              }
            }) {
              // 头部标题包括搜索
              TopComponent()
            }

            GridCol({
              span: {
                sm: CommonConstants.SIDE_LIST_SPAN_SM,
                md: CommonConstants.SIDE_LIST_SPAN_MD,
                lg: CommonConstants.SIDE_LIST_SPAN_LG
              }
            }) {
              // 侧边栏列表
              SideListComponent({
                sideListBreakpoint: this.currentBreakpoint,
                sideList: $sideListData,
                sideListIndex: $scrollerIndex,
                sideItemId: $scrollerItemId,
                musicDetailItems: $musicDetailListItems,
                scroller: this.scroller = new Scroller(),
              })
            }

            GridCol({
              span: {
                sm: CommonConstants.DETAIL_LIST_SPAN_SM,
                md: CommonConstants.DETAIL_LIST_SPAN_MD,
                lg: CommonConstants.DETAIL_LIST_SPAN_LG
              }
            }) {
              // 侧边栏详情
              DetailListComponent({
                detailListBreakpoint: this.currentBreakpoint,
                sideListIndex: $scrollerIndex,
                sideItemId: $scrollerItemId,
                musicDetailItems: $musicDetailListItems,
                scroller: this.scroller
              }).margin({
                top: $r('app.float.detail_list_text_margin_top'),
                left: $r('app.float.title_margin_left')
              })
            }
          }
          .margin({
            left: $r('app.float.grid_row_margin_left'),
            right: $r('app.float.grid_row_margin_right')
          })
          .onBreakpointChange((currentBreakpoint: string) => {
            this.currentBreakpoint = currentBreakpoint;
          })
        }.tabBar(this.TabBuilder(1, '排行榜'))

        TabContent() {
          // Column().width('100%').height('100%').backgroundColor('#00CB87')

        }.tabBar(this.TabBuilder(2, '播放'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#007DFF')
        }.tabBar(this.TabBuilder(3, '电台'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#FFBF00')
        }.tabBar(this.TabBuilder(4, '我的'))

        // ForEach(CategoryViewModel.getTabItems(), (item: TabItem, index: number) => {
        // TabContent() {
        // }.tabBar(this.TabBottom(item, index)))
        // }, (item, index) => index + JSON.stringify(item))
      }
      .layoutWeight(CommonConstants.TAB_LAYOUT_WEIGHT)
      .vertical(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG)
      .barWidth(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG ?
        $r('app.float.tab_bar_width') : CommonConstants.FULL_WIDTH_PERCENT)
      .barHeight(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG ?
        CommonConstants.FULL_HEIGHT_PERCENT : $r('app.float.tab_bar_height'))
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.categoryTabIndex = index;
      })
    }
    .backgroundColor($r('app.color.category_background'))
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(16)
        .fontWeight(this.categoryTabIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.categoryTabIndex === index ? 1 : 0)
    }.width('100%')
  }

  // @Builder TabBottom(item: TabItem, index: number) {
  //   Column() {
  //     Image(this.categoryTabIndex === index ? item.imageActivated : item.imageOriginal)
  //       .height($r('app.float.tab_image_size'))
  //       .width($r('app.float.tab_image_size'))
  //       .margin({
  //         top: $r('app.float.tab_margin_top'),
  //         bottom: $r('app.float.tab_margin_bottom')
  //       })
  //
  //     Text(item.title)
  //       .width(CommonConstants.FULL_WIDTH_PERCENT)
  //       .height($r('app.float.tab_text_height'))
  //       .fontSize($r('app.float.tab_text_font_size'))
  //       .fontWeight(CommonConstants.TAB_ITEM_FONT_WEIGHT)
  //       .fontColor(this.categoryTabIndex === index ?
  //         $r('app.color.tab_text_activated') : $r('app.color.tab_text_normal'))
  //       .textAlign(TextAlign.Center)
  //       .margin({
  //         bottom: $r('app.float.tab_text_margin_bottom')
  //       })
  //   }
  //   .justifyContent(FlexAlign.Center)
  //   .height(CommonConstants.FULL_HEIGHT_PERCENT)
  //   .width(CommonConstants.FULL_WIDTH_PERCENT)
  // }
}