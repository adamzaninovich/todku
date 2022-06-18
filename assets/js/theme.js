let Theme = {
  light: null,
  dark: null,
  page: null,

  set: function(theme) {
    this.page.dataset.theme = theme
    localStorage.setItem('theme', theme)
  },

  init: function(light, dark, pageID) {
    this.light = light;
    this.dark = dark;
    this.page = document.getElementById(pageID)

    if (localStorage.getItem('theme') === null) {
      // when theme isn't saved, use the OS theme
      let page = document.getElementById("page");

      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        page.dataset.theme = window.Theme.dark
      } else {
        page.dataset.theme = window.Theme.light
      }
    } else {
      window.Theme.set(localStorage.getItem('theme'))
    }
  }
}

export default Theme
