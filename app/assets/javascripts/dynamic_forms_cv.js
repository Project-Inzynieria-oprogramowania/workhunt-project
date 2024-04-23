// Adding 
var addEducationButton = document.querySelector('#add-education');
var addExperienceButton = document.querySelector('#add-experience');
var addLanguageButton = document.querySelector('#add-language');

addEducationButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('education-form').length;
    fetch(`/cv/education/add?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addEducationButton.closest('form');
            const newForm = document.createElement('div');
            newForm.innerHTML = html;

            formsContainer.insertBefore(newForm, addEducationButton);
    });
});

addExperienceButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('experience-form').length;
    fetch(`/cv/experience/add?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addExperienceButton.closest('form');
            const newForm = document.createElement('div');
            newForm.innerHTML = html;

            formsContainer.insertBefore(newForm, addExperienceButton);
    });
});

addLanguageButton.addEventListener('click', function() {
    var index = document.getElementsByClassName('language-form').length;
    fetch(`/cv/language/add?index=${index}`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addLanguageButton.closest('form');
            const newForm = document.createElement('div');
            newForm.innerHTML = html;

            formsContainer.insertBefore(newForm, addLanguageButton);
    });
});

// Destroing
document.addEventListener('click', function(event) {
    var indetificator = event.target.querySelector('input').value
    if (event.target.classList.contains('remove-education')) {
        var url = indetificator ? `/cv/education/remove?id=${indetificator}` : `/cv/education/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('.education-form');
                formToRemove.remove();
        });
    } else if (event.target.classList.contains('remove-experience')) {
        var url = indetificator ? `/cv/experience/remove?id=${indetificator}` : `/cv/experience/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('.experience-form');
                formToRemove.remove();
        });
    } else if (event.target.classList.contains('remove-language')) {
        var url = indetificator ? `/cv/language/remove?id=${indetificator}` : `/cv/language/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('.language-form');
                formToRemove.remove();
        });
    }
});