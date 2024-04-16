var drop_form = document.getElementById('search-drop-block')
document.getElementById('search-form-default').addEventListener('click', function(event) {
    if (event.target.id !== 'search-form-default') {
        return
    }

    if (drop_form.style.display == 'none'){
        drop_form.style.display = ''
    } else {
        drop_form.style.display = 'none'
    }
})