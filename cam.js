s0.initCam(1)
// initialize a webcam in source buffer s0

src(s0)
// .brightness(-0.2).contrast(0.9).saturate(0.9)
// .pixelate(10,4000)
// .color(1.05,1,0.90)
// .out()
// .rotate(0, 0.2)
  // .repeat(5, 3, 0.5)
  // .saturate(3.0)
 // .color(1.0, 0.7, -1)
  // .scrollX(0, -0.1)
  // .diff(noise( ({time}) => Math.sin(time/10)*50 , ({time}) => Math.sin(time/2)/500 ))
//  .kaleid(3)
  // .diff(src(s0).saturate().hue(0.2))
  // .brightness(-0.2).contrast(0.8)
  .out()

  s0.resize(4096,1024)



  .out()


  resize(800,600)


  s0.clear()




voronoi(5,0.3,0.3).out(o0)




osc( [1,10,50,100,250,500].fast(2) ).kaleid(20).out(o0) // frequency
osc( ({time}) => Math.sin(time/10) * 100 ).kaleid(19).out(o1) // frequency 2
osc( 10, [-10,-1,-0.1,0,0.1,1,10], 0 ).kaleid(21).out(o2) // sync
osc(10,0.1, ({time}) => Math.sin(time/10) * 1 ) // offset
  .modulate(o1,0.05)
  .modulate(o2,0.05)
  .modulate(o3,0.05)
  .kaleid(20)
  .add(noise(3,10))
  .out(o3)
render(o3)




vid = document.createElement('img')
// vid.autoplay = true
// vid.loop = true
// get path to video using getPaths() representing current directory in atom
vid.src = '/Users/Srinivasan/Downloads/livecodenyclogo.svg'

// use video within hydra
s0.init({src: vid})
src(s0)
  .rotate(0, 0.2)
  // .repeat(5, 3, 0.5)
  .saturate(0.8)
//  .color(1.0, 0.7, -1)
  .scrollX(0, -0.1)
  .diff(osc(10, 1, 3))
//  .kaleid(3)
  .diff(src(s0).saturate(0).hue(0.5))
  .out()
