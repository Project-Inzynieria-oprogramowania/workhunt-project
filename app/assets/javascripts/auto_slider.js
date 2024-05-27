var slides_count = document.getElementsByClassName('slide').length
var counter = 0
var auto_slide_interval_function

document.getElementById(`sr${counter}`).checked = true

var radios = document.querySelectorAll('input[name="slider-radio-button"]')
radios.forEach(function(radio, index) {
    radio.addEventListener('change', function() {
        counter = index
        clearInterval(auto_slide_interval_function)
        autoSlider()
    })
})

function autoSlider() {
    auto_slide_interval_function = setInterval(function() {
        counter++
        counter = counter % slides_count
        document.getElementById(`sr${counter}`).checked = true
    }, 5000)
}

if (auto_slide_interval_function) { clearInterval(auto_slide_interval_function) }
autoSlider()