document.addEventListener("turbolinks:load", (e) => {
  if (Notification.permission === "default") {
    Notification.requestPermission()
  }
})
