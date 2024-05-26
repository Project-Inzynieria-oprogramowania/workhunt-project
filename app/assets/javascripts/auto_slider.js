document.addEventListener('DOMContentLoaded', function() {
    const slides_count = document.getElementsByClassName('slide').length
    let counter = 0
    let auto_slide_interval_function

    document.getElementById(`sr${counter}`).checked = true

    const radios = document.querySelectorAll('input[name="slider-radio-button"]')
    radios.forEach(function(radio, index) {
        radio.addEventListener('change', function() {
            counter = index
            clearInterval(auto_slide_interval_function)
            autoSlider()
        });
    });

    function autoSlider() {
        auto_slide_interval_function = setInterval(function() {
            counter++
            counter = counter % slides_count
            document.getElementById(`sr${counter}`).checked = true
        }, 5000)
    }

    autoSlider()
})