const idle=$r('app.media.idle')
const animate=$r('app.media.move')
@Entry
@Component
struct Index {
  @State message: string = '进击的猫猫虫'
  //初始坐标
  @State dogX:number=20
  @State dogY:number=20
  //移动角度
  @State arc:number=0
  //目标坐标
  @State targetX:number=0
  @State targetY:number=0
  //移动方向
  @State diRect:number=0
  //gif类型：idle和animate
  @State type:Resource=idle
  //移速
  speed=2
  promise:number
  build() {
    Row() {
      Image(this.type)
        .width(70)
        .height(60)
        .rotate({
          //图片角度的翻转
          x: 0,
          y: 1,
          z: 0,
          centerX: '50%',
          centerY: '50%',
          angle: this.diRect
        })
        .position({x:this.dogX,y:this.dogY})

    }
    .width('100%')
    .height('100%')
    .onClick((event?: ClickEvent)=>{
      if(event){
        clearInterval(this.promise)
        //设置目标坐标
        this.targetX=event.x
        this.targetY=event.y
        this.type=animate
        //设置移动方向
        if(this.targetX>this.dogX) {
          this.diRect = 180
        }
        else{
          this.diRect=0
        }
        //计算移动角度
        this.arc=Math.atan2(this.targetY-this.dogY,this.targetX-this.dogX)
        //设置计时器，使图片向目标坐标进行移动
        this.promise=setInterval(()=>{
          this.dogX+=this.speed*Math.cos(this.arc)
          this.dogY+=this.speed*Math.sin(this.arc)
          if(Math.abs(this.dogX-this.targetX)<=1&&Math.abs(this.dogY-this.targetY)<=1){
            this.type=idle
            clearInterval(this.promise)
          }
        },10)


      }

    })
  }
}