var slider = document.getElementById('slider-field')
var header = document.getElementById('header')
var slider_images = document.querySelectorAll('.slide')

function slider_resize(){
  var slider_height = `calc(100vh - ${header ? header.offsetHeight : 0}px)`

  slider.style.height = slider_height
  slider_images.forEach(image => {
    image.style.transition = 'none'
    image.style.height = slider_height
  })

  // Force the re-layout to immediately apply the new dimensions
  slider.offsetHeight

  slider_images.forEach(image => {
    image.style.transition = ''
  })  
}

slider_resize()

window.addEventListener('resize', slider_resize)