/**
 * Tab item info.
 */
export class TabItem {
  /**
   * Tab item index.
   */
  index: number;

  /**
   * Tab item title.
   */
  title: string | Resource;

  /**
   * Image activated.
   */
  imageActivated: Resource;

  /**
   * Image original.
   */
  imageOriginal: Resource;
  /**
   * 页面组件
   */
  tabContent: string | Resource;
}