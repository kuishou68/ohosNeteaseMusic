
import PlayListCover from './PlayListCover'
import PlayList from './PlayList'
import { playlistDetailType } from '../bean/DetailListItem';

@Component
export default struct Content {
  @Provide coverHeight: number = 0
  @Link musicDetailItems: playlistDetailType;

  build() {
    GridRow() {
      GridCol({ span: { sm: 12, md: 6, lg: 4 } }) {
        PlayListCover({
          musicDetailItems: $musicDetailItems
        })
          .onAreaChange((oldArea: Area, newArea: Area) => {
            this.coverHeight = newArea.height as number
          })
      }
      .backgroundColor('#e4ecf7')

      GridCol({ span: { sm: 12, md: 6, lg: 8 } }) {
        PlayList()
      }
      .borderRadius(40)
    }
    .height('100%')
  }
}