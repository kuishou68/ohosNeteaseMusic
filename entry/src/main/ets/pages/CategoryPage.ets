import { DetailListComponent } from '../view/DetailListComponent';
import { SideListComponent } from '../view/SideListComponent';
import { TopComponent } from '../view/TopComponent';
import { CommonConstants } from '../common/constants/CommonConstants';
import type { TabItem } from '../common/bean/TabItem';
import promptAction from '@ohos.promptAction';
import CategoryViewModel from '../viewmodel/CategoryViewModel';
import musicTopListViewModel, { musicTopListData, ResponseResult, } from  '../viewmodel/MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import Logger from '../common/util/Logger';

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
  scroller: Scroller;

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
        }
        Logger.info("this.sideListData", JSON.stringify(this.sideListData))
        Logger.info("this.scrollerItemId", this.scrollerItemId);
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
        ForEach(CategoryViewModel.getTabItems(), (item: TabItem, index: number) => {
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
                  sideItemId: this.scrollerItemId,
                  scroller: this.scroller
                })
                  .margin( {
                    top: $r('app.float.detail_list_text_margin_top')
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
          }
          .tabBar(this.TabBottom(item, index))
        }, (item, index) => index + JSON.stringify(item))
      }
      .layoutWeight(CommonConstants.TAB_LAYOUT_WEIGHT)
      .vertical(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG)
      .barWidth(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG ?
        $r('app.float.tab_bar_width') : CommonConstants.FULL_WIDTH_PERCENT)
      .barHeight(this.currentBreakpoint === CommonConstants.BREAK_POINT_LG ?
        CommonConstants.HALF_HEIGHT_PERCENT : $r('app.float.tab_bar_height'))
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.categoryTabIndex = index;
      })
    }
    .backgroundColor($r('app.color.category_background'))
  }

  @Builder TabBottom(item: TabItem, index: number) {
    Column() {
      Image(this.categoryTabIndex === index ? item.imageActivated : item.imageOriginal)
        .height($r('app.float.tab_image_size'))
        .width($r('app.float.tab_image_size'))
        .margin({
          top: $r('app.float.tab_margin_top'),
          bottom: $r('app.float.tab_margin_bottom')
        })

      Text(item.title)
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .height($r('app.float.tab_text_height'))
        .fontSize($r('app.float.tab_text_font_size'))
        .fontWeight(CommonConstants.TAB_ITEM_FONT_WEIGHT)
        .fontColor(this.categoryTabIndex === index ?
          $r('app.color.tab_text_activated') : $r('app.color.tab_text_normal'))
        .textAlign(TextAlign.Center)
        .margin({
          bottom: $r('app.float.tab_text_margin_bottom')
        })
    }
    .justifyContent(FlexAlign.Center)
    .height(CommonConstants.FULL_HEIGHT_PERCENT)
    .width(CommonConstants.FULL_WIDTH_PERCENT)
  }
}