import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ChatChannel", room: "room_name" }, {
  connected() {
    console.log("Connected to the chat room")
  },

  disconnected() {
    console.log("Disconnected from the chat room")
  },

  received(data) {
    console.log("Received message: ", data.message)
    // Ajoute ici la logique pour afficher le message dans le chat
  },

  speak(message, senderId, senderType, receiverId) {
    this.perform('speak', { message: message, sender_id: senderId, sender_type: senderType, receiver_id: receiverId })
  }
});
