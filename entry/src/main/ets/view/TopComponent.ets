import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Category top component.
 */
@Component
export struct TopComponent {
  build() {
    Column() {
      this.Title()

      Search({ placeholder: CommonConstants.SEARCH_PLACEHOLDER })
        .height($r('app.float.search_height'))
        .border({ radius: $r('app.float.search_radius') })
        .placeholderFont({
          size: $r('app.float.search_text_size'),
          weight: CommonConstants.SEARCH_WEIGHT,
          family: CommonConstants.SEARCH_FONT_FAMILY,
          style: FontStyle.Normal
        })
        .textFont({ size: $r('app.float.search_text_size') })
        .placeholderColor($r('app.color.search_placeholder'))
        .margin({
          top: $r('app.float.search_margin_top'),
          bottom: $r('app.float.search_margin_bottom')
        })
    }
  }

  @Builder Title() {
    Column() {
      Text($r('app.string.title'))
        .fontSize($r('app.float.title_font_size'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
        .textAlign(TextAlign.Start)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .alignItems(HorizontalAlign.Start)
    .margin({
      top: $r('app.float.title_margin_top'),
      left: $r('app.float.title_margin_left')
    })
  }
}