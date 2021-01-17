osc(10000, 0.7, 0.8)
.saturate(0.1)
.kaleid(3).
rotate(0, 0.1).out()

// WINTER FINGERS -- EMPIRE
osc(10000, 2, 3)
.saturate(0.1)
.kaleid(12).
rotate(0, 0.1).out()


/// EVENING RITUALS
vid = document.createElement('video')
vid.autoplay = true
vid.loop = true
// get path to video using getPaths() representing current directory in atom
vid.src = atom.project.getPaths()[0]+ '/assets/streetcar.webm';

// use video within hydra
s0.init({src: vid})
src(s0)
  // .rotate(0, 0.2)
  .repeat(4, 0.5)
  .saturate(0.001)
 .color(1.0, 0.7, -1)
  .scrollX(0, -0.1)
  .diff(osc(1000, 0.3, 2))
//  .kaleid(3)
  // .brightness(0.00001)
  .contrast(0.1)
  .diff(src(s0).saturate(5).contrast(0.3).hue(1))
  .out()
