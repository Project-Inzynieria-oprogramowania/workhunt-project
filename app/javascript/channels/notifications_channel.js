import consumer from "channels/consumer"

var notifications_container = document.getElementById("notifications-container")
var notification_counter_block = document.getElementById("notification-counter-block")
var notification_counter = document.getElementById("notification-counter")

consumer.subscriptions.create("NotificationsChannel", {
    connected() {
        console.log(`Connected to the notifications channel (ID: ${this.identifier})`);
    },

    disconnected() {
        console.log("Disconnected from the notifications channel")
    },

    received(data) {
        alert(`Received data: ${JSON.stringify(data)}`);
        console.log(data)
        console.log("Received data:", data);
        // var notification_block = document.createElement("div")
        // notification_block.classList.add("notification-block")
        // notification_block.classList.add("unread")
        // notification_block.dataset.id = data.id
        // var notification_content = `<p>${data.message}</p>`
        // if (data.link) { notification_content = `<a href="${data.link}">${notification_content}</a>` }
        // notification_block.innerHTML = notification_content
        // notifications_container.prepend(notification_block)

        // var current_count = parseInt(notification_counter.textContent) || 0
        // if (!data.read){ current_count += 1 }

        // if (current_count !== 0){
        //     if (notification_counter) {
        //         notification_counter.textContent = current_count
        //     } else {
        //         notification_counter = document.createElement("p")
        //         notification_counter.id = "notification-counter"
        //         notification_counter.textContent = current_count
        //         notification_counter_block.prepend(notification_block)
        //     }
        // }        
    }
})