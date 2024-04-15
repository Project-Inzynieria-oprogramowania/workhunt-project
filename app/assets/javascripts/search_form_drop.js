document.addEventListener('DOMContentLoaded', function() {
    let drop_form = document.getElementById('search-drop-block')
    document.getElementById('search-form').onclick = function(){
        if (drop_form.style.display == 'none'){
            drop_form.style.display = ''
        } else {
            drop_form.style.display = 'none'
        }
    }
});