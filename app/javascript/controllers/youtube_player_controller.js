import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "player",
    "playButton",
    "gameTitle",
    "trackTitle"
  ]

  static values = {
    playlist: Array
  }

  connect() {
    this.currentIndex = 0
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

    if (event.data === YT.PlayerState.ENDED) {
        this.nextTrack()
      }
  }
}