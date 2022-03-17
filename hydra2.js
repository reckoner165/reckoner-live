var imEL = document.createElement('img'); // <img />
imEL.src = '/Users/Srinivasan/Desktop/sky1.png';    // <img src=" " />
s0.init(
  {
    src: imEL , // variable that holds element
    dynamic: false   // set true for video
  }
);

var imEL2 = document.createElement('img'); // <img />
imEL2.src = '/Users/Srinivasan/Desktop/pod1.png';    // <img src=" " />
s2.init(
  {
    src: imEL2 , // variable that holds element
    dynamic: false   // set true for video
  }
);




shape(4,0.2,0.001)
// .repeat(19,19)
.layer(src(s0).scale(1))
.mult(osc(14,1,2).contrast(0.2))
.mask(src(s2)
  .scale(1.3,0.05,1)
  .contrast(10)
  .scrollY(({time}) => Math.sin(time)*-0.07 )
  .mult(shape(4,0.8,0.01))
,0.00001, 0.5)
.scrollX(1,-0.25)
.mult(shape(4,0.8,0.01)
        // .rotate( ({time}) => 2*time%360 )
        .scrollX(1,-0.25))
.out(o0)
