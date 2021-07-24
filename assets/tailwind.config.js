module.exports = {
  purge: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamlily: {
      sans: [
        'Calibre',
        'ui-sans-serif',
        'system-ui',
        '-apple-system',
        'BlinkMacSystemFont',
        '"Segoe UI"',
        'Roboto',
        '"Helvetica Neue"',
        'Arial',
        '"Noto Sans"',
        'sans-serif',
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
        '"Noto Color Emoji"',
      ],
    },
    extend: {
      colors: {
        woodsmoke: '#0d0e0e',
        concrete: '#f3f3f3'
      },
      translate: {
        0: '0 !important'
      }
    },
  },
  variants: {
    extend: {
      width: ['group-hover'],
      borderWidth: ['group-hover', 'hover', 'focus'],
      borderColor: ['group-hover', 'hover', 'focus'],
      display: ['hover', 'focus', 'group-hover'],
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ],
}
