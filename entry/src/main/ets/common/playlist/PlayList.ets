
import { songList, SongListType } from '../../model/SongList'
import MyDataSource from '../../model/SongModule'
import { DetailItemData } from '../bean/DetailItemData'
import { playlistDetailType } from '../bean/DetailListItem'

@Component
export default struct PlayList {
  @Consume coverHeight: number
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm'
  @StorageProp('fontSize') fontSize: number = 0
  @Link musicDetailItems: playlistDetailType;

  @Builder
  PlayAll() {
    Row() {
      Image($r("app.media.ic_play_all")).height(23).width(23)
      Text($r('app.string.play_all'))
        .maxLines(1)
        .padding({ left: 10 })
        .fontColor('#000000')
        .fontSize(this.fontSize)
      Text(this.musicDetailItems.tracks && this.musicDetailItems.tracks.length ? '('+String(this.musicDetailItems.tracks.length)+')' : '')
      Blank()
      Image($r('app.media.ic_order_play'))
        .width(24)
        .height(24)
        .margin({ right: 16 })
      Image($r('app.media.ic_sort_list')).height(24).width(24)
    }
    .height(60)
    .width('100%')
    .backgroundColor('#fff')
    .padding({ left: 12, right: 12 })
    .borderRadius({ topRight: 20, topLeft: 20 })
    .position({ x: 0, y: 0 })
  }

  @Builder
  SongItem(title: string, label: Resource, singer: string) {
    Row() {
      Column() {
        Text(title)
          .fontColor('#000000')
          .fontSize(this.fontSize)
          .margin({ bottom: 4 })
        Row() {
          Image(label)
            .width(16)
            .height(16)
            .margin({ right: 4 })
          Text(singer)
            .opacity(0.38)
            .fontColor('#000000')
            .fontSize(this.fontSize - 4)
        }
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
      Image($r('app.media.ic_list_more')).height(24).width(24)
    }
    .height(60)
    .width('100%')
  }

  build() {
    Column() {
      this.PlayAll()
      Scroll() {
        List() {
        // new MyDataSource(songList)
          ForEach(this.musicDetailItems.tracks, (item: DetailItemData) => {
            ListItem() {
              Column() {
                this.SongItem(item.al.name, $r('app.media.ic_SQ'),
                  item.ar.map((e)=> {
                    return [e.name];
                  }).join("/")
                )
                Divider()
                  .strokeWidth(0.5)
                  .color('#000')
                  .opacity(0.1)
              }.padding({ left: 14, right: 14 })
            }
          }, (item: SongListType) => item.id.toString())
        }
        .width('100%')
        .height('100%')
        .lanes(this.currentBreakpoint === 'lg' ? 2 : 1)
      }
      .backgroundColor('#fff')
      .margin({ top: 50 })
    }
    .width('100%')
    .height('100%')
    .padding({
      top: this.currentBreakpoint === 'sm' ? 0 : 50,
      bottom: this.currentBreakpoint === 'sm' ? this.coverHeight + 48 : 48
    })
  }
}