let Game = {
  game: document.getElementById("game"),
  waiting: document.getElementById("waiting"),
  fullGame: document.getElementById("full_game"),
  xName: document.getElementById("x_name"),
  oName: document.getElementById("o_name"),
  xTurn: document.getElementById("x_turn"),
  oTurn: document.getElementById("o_turn"),

  init(socket) {
    socket.connect()

    let gameName = game.getAttribute("data-name")
    let gameChannel = socket.channel("game:" + gameName)

    gameChannel.params.player = window.currentPlayer

    gameChannel.join()
      .receive("ok", resp => {
      })
      .receive("error", reason => {
        this.show(this.fullGame)
      })

    gameChannel.on("new_player", (resp) => {
      if (resp.x && resp.o) {
        this.updateBoard(resp)
        this.updateStats(resp)
        this.hide(this.waiting)
        this.show(this.game)
        this.show(this.stats)
      } else {
        this.show(this.waiting)
      }
    })

    gameChannel.on("update_board", (resp) => {
      this.updateBoard(resp)
    })

    gameChannel.on("player_left", (resp) => {
      this.hide(this.stats)
      this.hide(this.game)
      this.show(this.waiting)
    })

    game.addEventListener("click", (e) => {
      e.preventDefault()
      let index = e.target.getAttribute("data-index")
      gameChannel.push("put", {index: index})
    })
  },

  show(element) {
    element.classList.remove("hidden")
  },

  hide(element) {
    element.classList.add("hidden")
  },

  updateBoard(resp) {
    let data = resp.board.data
    for (let i = 0; i < data.length; i++) {
      document.getElementById("index_" + i).innerHTML = data[i]
    }
    this.showNext(resp.next)
  },

  updateStats(game) {
    this.xName.innerHTML = game.x
    this.oName.innerHTML = game.o
  },

  showNext(symbol) {
    if (symbol == "x") {
      this.hide(this.oTurn)
      this.show(this.xTurn)
    } else {
      this.hide(this.xTurn)
      this.show(this.oTurn)
    }
  }
}

export default Game
