var addEducationButton = document.querySelector('#add-education')
var addExperienceButton = document.querySelector('#add-experience')
var addLanguageButton = document.querySelector('#add-language')

var csrfToken = document.querySelector('meta[name="csrf-token"]').content

var addFormFields = function(model_name, button){ return function(){
    var index = document.getElementsByClassName(`${model_name}-form`).length
    var url = `/cv/${model_name}/new?index=${index}`
    fetch(url, {
        method: 'GET',
        headers: {
          'X-CSRF-Token': csrfToken
        }
    })
        .then(response => response.text())
        .then(html => {
            var formsContainer = button.closest('div')
            var newForm = document.createElement('div')
            newForm.classList += `${model_name}-form-block`
            newForm.innerHTML = html

            formsContainer.insertBefore(newForm, button)
    })
}}

var deleteFormFields = function(model_name, event, indetificator){
    var url = `/cv/${model_name}`
    url = indetificator ? url + `?id=${indetificator}` : url
    fetch(url, {
        method: 'DELETE', 
        headers: {
            'X-CSRF-Token': csrfToken,
        }
    })
        .then(response => response.text())
        .then(html => {
            var block_name = `div.${model_name}-form`
            const formToRemove = event.target.closest(block_name)
            formToRemove.remove()
    })
}

addEducationButton.addEventListener('click', addFormFields('education', addEducationButton))
addExperienceButton.addEventListener('click', addFormFields('experience', addExperienceButton))
addLanguageButton.addEventListener('click', addFormFields('language', addLanguageButton))

document.addEventListener('click', function(event){
    var indetificator_block = event.target.closest('div').querySelector('input[type="hidden"]')
    var indetificator = indetificator_block ? indetificator_block.value : null

    if (event.target.classList.contains('remove-education')) { deleteFormFields('education', event, indetificator) }
    else if (event.target.classList.contains('remove-experience')) { deleteFormFields('experience', event, indetificator) }
    else if (event.target.classList.contains('remove-language')) { deleteFormFields('language', event, indetificator) }
})
