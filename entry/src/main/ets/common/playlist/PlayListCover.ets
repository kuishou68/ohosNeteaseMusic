
import { optionList, OptionListType } from '../../model/SongList'
import { playlistDetailType } from '../bean/DetailListItem'

@Component
export default struct PlayListCover {
  @State imgHeight: number = 0
  @StorageProp('coverMargin') coverMargin: number = 0
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  @StorageProp('fontSize') fontSize: number = 0
  @Link musicDetailItems: playlistDetailType;

  @Builder
  CoverImage() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Image(this.musicDetailItems.coverImgUrl) // $r('app.media.pic_album'))
        .width(this.currentBreakpoint == 'sm' ? '120vp' : '170vp')
        .height(this.currentBreakpoint == 'sm' ? '120vp' : '170vp')
        .borderRadius(8)
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.imgHeight = newArea.height as number
        })
      Text(this.musicDetailItems.playCount) // $r('app.string.collection_num'))
        .letterSpacing(1)
        .fontColor('#fff')
        .fontSize(this.fontSize - 4)
        .translate({ x: 10, y: '-100%' })
    }
  }

  @Builder
  CoverIntroduction() {
    Column() {
      Text(this.musicDetailItems.name)
        .opacity(0.9)
        .fontWeight(500)
        .fontColor('#556B89')
        .fontSize($r('app.float.Grid_item_text_size'))
        .margin({ bottom: 10 })

      Text(this.musicDetailItems.description)
        .opacity(0.6)
        .width('170vp')
        .fontWeight(400)
        .fontColor('#556B89')
        .fontSize($r('app.float.Grid_item_text_size'))
    }
    .width('100%')
    .height(this.currentBreakpoint === 'sm' ? this.imgHeight : 70)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding({ left: this.currentBreakpoint === 'sm' ? 20 : 0 })
    .margin({
      top: this.currentBreakpoint === 'sm' ? 0 : 50,
      bottom: this.currentBreakpoint === 'sm' ? 0 : 20
    })
  }

  @Builder
  CoverOptions() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(optionList, (item: OptionListType) => {
        Column({ space: 4 }) {
          Image(item.image).height(30).width(30)
          Text(item.key === "playCount" ? this.musicDetailItems[item.key] : item.text)
            .fontColor('#556B89')
            .fontSize(this.fontSize - 1)
        }
      })
    }
    .height(70)
    .padding({
      left: this.currentBreakpoint === 'sm' ? 20 : 0,
      right: this.currentBreakpoint === 'sm' ? 20 : 0
    })
  }

  build() {
    if (this.currentBreakpoint === 'sm') {
      Column() {
        GridRow() {
          GridCol({ span: { sm: 4, md: 10 }, offset: { sm: 0, md: 1, lg: 1 } }) {
            this.CoverImage()
          }

          GridCol({ span: { sm: 8, md: 10 }, offset: { sm: 0, md: 2, lg: 2 } }) {
            this.CoverIntroduction()
          }

          GridCol({ span: { sm: 12, md: 10 }, offset: { sm: 0, md: 2, lg: 2 } }) {
            this.CoverOptions()
          }.padding({
            top: this.currentBreakpoint === 'sm' ? 15 : 0,
            bottom: this.currentBreakpoint === 'sm' ? 15 : 0
          })
        }
        .margin({ left: this.coverMargin, right: this.coverMargin })
        .padding({ top: this.currentBreakpoint === 'sm' ? 50 : 70 })
      }
    } else {
      Column() {
        GridRow() {
          GridCol({ span: { sm: 4, md: 10 }, offset: { sm: 0, md: 1, lg: 1 } }) {
            this.CoverImage()
          }

          GridCol({ span: { sm: 8, md: 10 }, offset: { sm: 0, md: 2, lg: 2 } }) {
            this.CoverIntroduction()
          }

          GridCol({ span: { sm: 12, md: 10 }, offset: { sm: 0, md: 2, lg: 2 } }) {
            this.CoverOptions()
          }.margin({
            top: this.currentBreakpoint === 'sm' ? 15 : 60,
            bottom: this.currentBreakpoint === 'sm' ? 15 : 0
          })
        }
        .margin({ left: this.coverMargin, right: this.coverMargin })
        .padding({ top: this.currentBreakpoint === 'sm' ? 50 : 70 })
      }
      .height('100%')
    }
  }
}