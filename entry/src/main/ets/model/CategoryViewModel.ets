import { CommonConstants } from '../common/constants/CommonConstants';
import { SideListItem } from '../common/bean/SideListItem';
import { TabItem } from '../common/bean/TabItem';
import { DetailListItem } from '../common/bean/DetailListItem';
import { DetailItemData } from '../common/bean/DetailItemData';
import musicTopListViewModel, { musicTopListData, } from './MusicTopListViewModel';
import { CommonConstants as Const, ContentType } from '../../ets/common/constants/CommonConstants';
import promptAction from '@ohos.promptAction';
import Logger from '../common/util/Logger';


/**
 * Category ability view model.
 */
export class CategoryViewModel {
  /**
   * Get index list data on the left.
   *
   * @return {Array<IndexListItem>} indexListItems
   */
  // getSideListData(): Array<SideListItem> {
  //   let indexListItems: Array<SideListItem> = [];
  //   let rankingList: Array<string> = CommonConstants.RANKING_LIST;
  //   // LIST_SIZE
  //   for (let index = 0; index <= rankingList.length; index++) {
  //     let indexListItem = new SideListItem();
  //     // 'app.string.list_item_text'
  //     indexListItem.title = $r(`${rankingList[index]}`, index);
  //     indexListItems.push(indexListItem);
  //   }
  // }

  /**
   * Get tab item data.
   *
   * @return {Array<TabItem>} tabItems
   */
  getTabItems(): Array<TabItem> {
    let tabItems: Array<TabItem> = [];
    for (let index = 0; index < CommonConstants.TAB_BAR_SIZE; index++) {
      let tabItem = new TabItem();
      tabItem.index = index;
      tabItem.title = $r('app.string.tab_text');
      tabItem.imageOriginal = $r('app.media.ic_tab_normal');
      tabItem.imageActivated = $r('app.media.ic_tab_activated');
      tabItems.push(tabItem);
    }
    // let tabItems: Array<TabItem> = [
    //   {
    //     index: 0,
    //     title: "推荐",
    //     imageOriginal: $r('app.media.ic_tab_normal'),
    //     imageActivated: $r('app.media.ic_tab_activated'),
    //     // @ts-ignore
    //     tabContent: new Ranking()
    //   },
    //   {
    //     index: 1,
    //     title: "排行榜",
    //     imageOriginal: $r('app.media.ic_tab_normal'),
    //     imageActivated: $r('app.media.ic_tab_activated'),
    //     tabContent: ""
    //   },
    //   {
    //     index: 2,
    //     title: "播放",
    //     imageOriginal: $r('app.media.ic_tab_normal'),
    //     imageActivated: $r('app.media.ic_tab_activated'),
    //     tabContent: ""
    //   },
    //   {
    //     index: 3,
    //     title: "电台",
    //     imageOriginal: $r('app.media.ic_tab_normal'),
    //     imageActivated: $r('app.media.ic_tab_activated'),
    //     tabContent: ""
    //   },
    //   {
    //     index: 4,
    //     title: "我的",
    //     imageOriginal: $r('app.media.ic_tab_normal'),
    //     imageActivated: $r('app.media.ic_tab_activated'),
    //     tabContent: ""
    //   },
    // ];
    return tabItems;
  }

  /**
   * Get detail list item info.
   *
   * @return {Array<DetailListItem>} detailListItems
   */
  getDetailListItems(): Array<DetailListItem> {
    let detailListItems: Array<DetailListItem> = [];
    for (let i = 0; i < CommonConstants.LIST_SIZE; i++) {
      let detailListItem = new DetailListItem();
      detailListItem.index = i;
      // detailListItem.title = $r('app.string.detail_list_item_text');
      // detailListItem.detailItemData = this.getDetailItems();
      detailListItems.push(detailListItem);
    }
    Logger.error("detailListItems", JSON.stringify(detailListItems));
    return detailListItems;
  }

  /**
   * Get detail item info.
   *
   * @return {Array<DetailItemData>} gridData
   */
  private getDetailItems(): Array<DetailItemData> {
    let detailData: Array<DetailItemData> = [];
    for (let i = 0; i < CommonConstants.DETAIL_ITEM_SIZE; i++) {
      let gridItemData = new DetailItemData();
      // gridItemData.content = $r('app.string.grid_item_text');
      detailData.push(gridItemData);
    }
    return detailData;
  }
}

let categoryViewModel = new CategoryViewModel();

export default categoryViewModel as CategoryViewModel;
