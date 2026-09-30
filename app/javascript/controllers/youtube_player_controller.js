import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "player",
    "playButton",
    "gameTitle",
    "trackTitle",
    "repeatButton"
  ]

  static values = {
    playlist: Array
  }

  connect() {
    this.currentIndex = 0
    this.repeatEnabled = false
    this.loadYouTubeAPI()
  }

  loadYouTubeAPI() {
    // すでにAPIが読み込まれている場合
    if (window.YT && window.YT.Player) {
      this.createPlayer()
      return
    }

    // APIのscriptがまだ存在しない場合だけ追加
    if (!document.querySelector('script[src="https://www.youtube.com/iframe_api"]')) {
      const tag = document.createElement("script")
      tag.src = "https://www.youtube.com/iframe_api"
      document.head.appendChild(tag)
    }

    // YouTube APIの読み込み完了後に実行される
    window.onYouTubeIframeAPIReady = () => {
      this.createPlayer()
    }
  }

  createPlayer() {
    this.player = new YT.Player(this.playerTarget, {
      events: {
      onReady: (event) => {
        event.target.playVideo()
      },
        onStateChange: (event) => this.onStateChange(event)
      }
    })
  }

  // リピートボタン押下
  toggleRepeat() {
    this.repeatEnabled = !this.repeatEnabled

    if (this.repeatEnabled) {
      this.repeatButtonTarget.textContent = "🔁 リピート ON"

      this.repeatButtonTarget.classList.remove(
        "bg-[#151522]",
        "text-[#b8b8c8]",
        "border-white/5"
      )

      this.repeatButtonTarget.classList.add(
        "bg-[rgba(96,216,168,0.08)]",
        "text-[#60d8a8]",
        "border-[rgba(96,216,168,0.25)]"
      )
    } else {
      this.repeatButtonTarget.textContent = "🔁 リピート OFF"

      this.repeatButtonTarget.classList.remove(
        "bg-[rgba(96,216,168,0.08)]",
        "text-[#60d8a8]",
        "border-[rgba(96,216,168,0.25)]"
      )

      this.repeatButtonTarget.classList.add(
        "bg-[#151522]",
        "text-[#b8b8c8]",
        "border-white/5"
      )
    }
  }

  // 再生ボタン動作
  togglePlayback() {
    const state = this.player.getPlayerState()

    if (state === YT.PlayerState.PLAYING) {
      this.player.pauseVideo()
    } else {
      this.player.playVideo()
    }
  }

  // 次の曲動作（最後の曲で押下した場合は再シャッフル実施）
  nextTrack() {
  if (this.currentIndex >= this.playlistValue.length - 1) {
    this.shufflePlaylist()
    this.currentIndex = 0
  } else {
    this.currentIndex += 1
  }
    const nextTrack = this.playlistValue[this.currentIndex]
    this.player.loadVideoById(nextTrack.video_id)
    this.trackTitleTarget.textContent = nextTrack.title
    this.gameTitleTarget.textContent = nextTrack.game_title
  }

  // 楽曲シャッフル
  shufflePlaylist() {
  const playlist = [...this.playlistValue]

  for (let i = playlist.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))

    const temp = playlist[i]
    playlist[i] = playlist[j]
    playlist[j] = temp
  }

  this.playlistValue = playlist
}

  // ステータス変更イベント
  onStateChange(event) {
    if (event.data === YT.PlayerState.PLAYING) {
      this.playButtonTarget.textContent = "Ⅱ 停止"
    }

    if (
      event.data === YT.PlayerState.PAUSED ||
      event.data === YT.PlayerState.ENDED ||
      event.data === YT.PlayerState.CUED
    ) {
      this.playButtonTarget.textContent = "▶ 再生"
    }

    // 楽曲終了時の判定
    if (event.data === YT.PlayerState.ENDED) {
      // リピートがONなら最初から、OFFなら次の曲再生
      if (this.repeatEnabled) {
        this.player.seekTo(0)
        this.player.playVideo()
      } else {
        this.nextTrack()
      }
    }
  }
}