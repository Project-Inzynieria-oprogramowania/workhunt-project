document.addEventListener('DOMContentLoaded', function() {
    let flashContainer = document.getElementById('flashContainer')

    setTimeout(function() {
        if (flashContainer) {
            flashContainer.style.display = 'none'
        }
    }, 5000);
});