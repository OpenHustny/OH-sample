const idle=$r('app.media.idle')
const animate=$r('app.media.move')
@Entry
@Component
struct Index {
  @State message: string = '进击的猫猫虫'
  @State dogX:number=20
  @State dogY:number=20
  @State arc:number=0
  @State targetX:number=0
  @State targetY:number=0
  @State diRect:number=0
  @State type:Resource=idle
  speed=2
  promise:number
  hearTo(x:number,y:number){
    //去往目的地
  }
  build() {
    Row() {
      Image(this.type)
      .width(70)
      .height(60)
        .rotate({
          x: 0,
          y: 1,
          z: 0,
          centerX: '50%',
          centerY: '50%',
          angle: this.diRect
        })
        .position({x:this.dogX,y:this.dogY})
      Column() {

      }
      .width('100%')
    }
    .height('100%')
    .onClick((event?: ClickEvent)=>{
      if(event){
        clearInterval(this.promise)
        this.targetX=event.x
        this.targetY=event.y
        this.type=animate

        if(this.targetX>this.dogX) {
          this.diRect = 180
        }
        else{
          this.diRect=0
        }

        this.arc=Math.atan2(this.targetY-this.dogY,this.targetX-this.dogX)

        this.promise=setInterval(()=>{
          this.dogX+=this.speed*Math.cos(this.arc)
          this.dogY+=this.speed*Math.sin(this.arc)
          if(Math.abs(this.dogX-this.targetX)<=1&&Math.abs(this.dogY-this.targetY)<=1){
            this.type=idle
            clearInterval(this.promise)
          }

        },10)
        // this.dogX=event.x
        // this.dogY=event.y

      }

    })
  }
}