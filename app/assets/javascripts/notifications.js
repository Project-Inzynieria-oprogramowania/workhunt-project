var button = document.getElementById("notifications-button")
var notifications_container = document.getElementById("notifications-container")

button.addEventListener('click', function(){
    if (notifications_container.style.display == 'none'){
        notifications_container.style.display = 'block'
        fetch('/notifications/marks_as_read', {
            method: 'PATCH',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            }
        })
    } else {
        notifications_container.style.display = 'none'
    }
})