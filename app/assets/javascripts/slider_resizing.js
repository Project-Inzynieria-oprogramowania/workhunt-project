var slider = document.getElementById('slider-field');
var viewportHeight = window.innerHeight;
slider.style.height = (viewportHeight - 68) + 'px';
  
var slideImages = document.querySelectorAll('.slide');
slideImages.forEach(image => {
  image.style.height = (viewportHeight - 68) + 'px';
});