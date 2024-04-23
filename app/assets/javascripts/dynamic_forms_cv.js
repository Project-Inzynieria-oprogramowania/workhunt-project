// Adding 
var addEducationButton = document.querySelector('#add-education');

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

// Destroing
document.addEventListener('click', function(event) {
    if (event.target.classList.contains('remove-education')) {
        var indetificator = event.target.querySelector('input').value
        var url = indetificator ? `/cv/education/remove?id=${inputValue}` : `/cv/education/remove`
        fetch(url, {method: 'DELETE'})
            .then(response => response.text())
            .then(html => {
                const formToRemove = event.target.closest('.education-form');
                formToRemove.remove();
        });
    }
});