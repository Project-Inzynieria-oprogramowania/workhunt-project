// Adding 
var addEducationButton = document.querySelector('#add-education');
var addExperienceButton = document.querySelector('#add-experience');
var addLanguageButton = document.querySelector('#add-language');

addEducationButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('education-form').length
    fetch(`/cv/education/new?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addEducationButton.closest('div')
            const newForm = document.createElement('div')
            newForm.classList += 'education-form-block'
            newForm.innerHTML = html

            formsContainer.insertBefore(newForm, addEducationButton)
    });
});

addExperienceButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('experience-form').length
    fetch(`/cv/experience/new?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addExperienceButton.closest('div')
            const newForm = document.createElement('div')
            newForm.classList += 'experience-form-block'
            newForm.innerHTML = html

            formsContainer.insertBefore(newForm, addExperienceButton)
    });
});

addLanguageButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('language-form').length
    fetch(`/cv/language/new?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addLanguageButton.closest('div')
            const newForm = document.createElement('div')
            newForm.classList += 'language-form-block'
            newForm.innerHTML = html

            formsContainer.insertBefore(newForm, addLanguageButton)
    });
});

// Destroing
document.addEventListener('click', function(event) {
    var indetificator = event.target.querySelector('input').value
    if (event.target.classList.contains('remove-education')) {
        var url = indetificator ? `/cv/education?id=${indetificator}` : `/cv/education/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('div.education-form-block')
                formToRemove.remove()
        });
    } else if (event.target.classList.contains('remove-experience')) {
        var url = indetificator ? `/cv/experience?id=${indetificator}` : `/cv/experience/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('div.experience-form-block')
                formToRemove.remove()
        });
    } else if (event.target.classList.contains('remove-language')) {
        var url = indetificator ? `/cv/language?id=${indetificator}` : `/cv/language/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('div.language-form-block')
                formToRemove.remove()
        });
    }
});