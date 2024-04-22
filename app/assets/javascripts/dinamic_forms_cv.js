const addEducationButton = document.querySelector('.add-education');

addEducationButton.addEventListener('click', function() {
    const formsContainer = addEducationButton.closest('form');
    
    // Найдем последнюю форму образования, чтобы скопировать ее
    // -> Использовать рендер?
    const lastEducationForm = formsContainer.querySelector('.education-form');

    const newForm = lastEducationForm.cloneNode(true);
    // Очистим значения в новой форме, чтобы она не дублировала старые данные
    // -> Поля должны быть для опреденного обьекта
    formsContainer.insertBefore(newForm, addEducationButton);
});

document.addEventListener('click', function(event) {
    if (event.target.classList.contains('remove-education')) {
        const formToRemove = event.target.closest('.education-form');
        formToRemove.remove();
    }
});