import router from '@ohos.router';
import { playlistDetailType } from '../bean/DetailListItem';

@Component
export default struct Header {
  @Link musicDetailItems: playlistDetailType;

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(20)
        .height(20)
        .margin({ left: 16 })
        .onClick(() => {
          router.back()
        })
      Text(this.musicDetailItems.name)
        .fontSize($r('app.float.Grid_item_text_size'))
        .fontWeight(500)
        .fontColor('#556B89')
        .opacity(0.9)
        .letterSpacing(2)
        .padding({ left: 10 })

      Blank()
      Image($r("app.media.ic_more"))
        .width(20)
        .height(20)
        .margin({ right: 16 })
    }
    .width('100%')
    .height(50)
    .zIndex(2)
  }
}