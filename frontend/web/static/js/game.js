let Game = {
  init(socket) {
    socket.connect()

    let gameName = game.getAttribute("data-name")
    let gameChannel = socket.channel("game:" + gameName)

    gameChannel.params.player = window.currentPlayer

    gameChannel.join()
      .receive("ok", resp => {
      })
      .receive("error", reason => {
      })
  }
}

export default Game
