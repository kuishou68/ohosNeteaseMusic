import type { DetailItemData } from './DetailItemData';

/**
 * Detail list item info.
 */
export class DetailListItem {
  /**
   * Detail list item index.
   */
  index: number;

  /**
   * Detail list item title.
   */
  name: Resource;

  /**
   * Detail list item data.
   */
  songs: Array<DetailItemData>; // tracks:
}