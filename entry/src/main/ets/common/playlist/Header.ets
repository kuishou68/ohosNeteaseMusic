
@Component
export default struct Header {
  @StorageProp('fontSize') fontSize: number = 0

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(20)
        .height(20)
        .margin({ left: 16 })
      Text($r('app.string.play_list'))
        .fontSize(this.fontSize + 4)
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