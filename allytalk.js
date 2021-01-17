// create an html5 video element
vid = document.createElement('video')
vid.autoplay = true
vid.loop = true
// get path to video using getPaths() representing current directory in atom
vid.src = atom.project.getPaths()[0] + '/assets/iu.webm'
// use video within hydra


s0.init({src: vid})
src(s0)
  .rotate(0, 0.2)
  .repeat(5, 3, 0.5)
  // .saturate(0.1)
 .color(1.0, 0.7, -1)
  .scrollX(0, -0.1)
  // .diff(osc(2, 0.3, 2))
  .invert(1.0)
 .kaleid(4)
  // .luma(-3,0.1)
  .add(src(s0))
  .rotate(0,0.4)
  .out()
