var button = document.querySelector('input[type="submit"]')
var input_fields_all = document.querySelectorAll('input, textarea, select')
var input_fields = []
var input_fields_values = {};

input_fields_all.forEach(function(element){
    if (element.type !== 'submit' && element.type !== 'hidden' && element.id != 'user_old_password'){
        input_fields.push(element);
        input_fields_values[element.id] = element.value
    }
})

var check_values = function(){
    result = true
    input_fields.forEach(function(element){
        if (element.value !== input_fields_values[element.id]){
            result = false
        }
    })
    return result
}

input_fields.forEach(function(element) {
    element.addEventListener('input', function(){
        if (check_values()){
            button.disabled = true
            button.classList.add('disable')
        } else {
            button.disabled = false
            button.classList.remove('disable')
        }
    });    
});