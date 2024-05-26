var button = document.getElementById("notifications-button")
var notifications_container = document.getElementById("notifications-container")

button.addEventListener('click', function(){
    if (notifications_container.style.display == 'none'){
        notifications_container.style.display = 'block'

        var notification_ids = Array.from(document.querySelectorAll('.notification-block[data-id]')).map(function(notification) {
            return notification.dataset.id
        })

        fetch(`/notifications/marks_as_read?notification_ids=[${notification_ids}]`, {
            method: 'PATCH',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            }
        })
    } else {
        notifications_container.style.display = 'none'
    }
})