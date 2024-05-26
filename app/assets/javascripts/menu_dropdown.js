var menu_button = document.getElementById("menu-button")
var menu_dropdown = document.getElementById("menu-dropdown")

menu_button.addEventListener('click', function(){
    if (menu_dropdown.style.display == 'none'){
        menu_dropdown.style.display = 'block'
    } else {
        menu_dropdown.style.display = 'none'
    }
})