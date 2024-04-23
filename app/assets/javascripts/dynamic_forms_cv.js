var addEducationButton = document.querySelector('#add-education');

addEducationButton.addEventListener('click', function() {
    // const actionName = document.getElementById('cv-form').method
    // fetch(`/cv/education/add?method=${actionName}`, {
    //     method: "GET",
    //     headers: {
    //         "Accept": "text/vnd.turbo-stream.html",
    //     },
    // })
    
    fetch(`/cv/education/add`)
        .then(response => response.text())
        .then(html => {
            const formsContainer = addEducationButton.closest('form');
            const newForm = document.createElement('div');
            newForm.innerHTML = html;

            formsContainer.insertBefore(newForm, addEducationButton);
    });



    // const formsContainer = addEducationButton.closest('form');
    
    // // Найдем последнюю форму образования, чтобы скопировать ее
    // // -> Использовать рендер?
    // const lastEducationForm = formsContainer.querySelector('.education-form');

    // const newForm = lastEducationForm.cloneNode(true);
    // // Очистим значения в новой форме, чтобы она не дублировала старые данные
    // // -> Поля должны быть для опреденного обьекта
    // formsContainer.insertBefore(newForm, addEducationButton);
});

document.addEventListener('click', function(event) {
    if (event.target.classList.contains('remove-education')) {
        fetch(`/cv/education/remove?id=${event.target.querySelector('input').value}`)
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('.education-form');
                formToRemove.remove();
        });
    }
});