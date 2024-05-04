var submitButtonCVs = document.querySelector('#cvs-search-submit')
var submitButtonVacancies = document.querySelector('#vacancies-search-submit')
var body = document.querySelector('body')

var render_search_results = function(url){
    var formData = new FormData(document.querySelector('form.search'))
    fetch(url, {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
    })
        .then(response => response.text())
        .then(html => {
            var resultsToRemove = document.querySelector('#search-results')
            resultsToRemove.remove()

            var newResults = document.createElement('div')
            newResults.id = 'search-results'
            newResults.innerHTML = html
            body.insertAdjacentElement('beforeend', newResults)
    })
}
if (submitButtonCVs) { submitButtonCVs.addEventListener('click', render_search_results(`/cvs/search`)) }
if (submitButtonVacancies) { submitButtonVacancies.addEventListener('click', render_search_results(`/vacancies/search`)) }