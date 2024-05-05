var drop_form = document.getElementById('search-drop-block')
var drop_button = document.getElementById('search-form-default')
var arrows = document.querySelector('#search-form-default img')
document.getElementById('search-form-default').addEventListener('click', function(event) {
    if (event.target.id !== 'search-form-default') {
        return
    }

    if (drop_form.style.display == 'none'){
        drop_form.style.display = ''
        drop_button.style.backgroundColor = '#844da0'
        drop_button.style.borderRadius = '0px 0px 0px 0px'
        drop_button.style.color = '#e1c1f1'
        arrows.style.transform = 'rotate(180deg)'
    } else {
        drop_form.style.display = 'none'
        drop_button.style.backgroundColor = '#663C7B'
        drop_button.style.borderRadius = '0px 0px 10px 10px'
        drop_button.style.color = '#E0ACFA'
        arrows.style.transform = ''
    }
})