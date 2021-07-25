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
      animation: {
        scrollText: 'scrollText 20s infinite linear',
      },
      backgroundImage: theme => ({
        'circle-pattern': "url('/images/background-image-circle.svg')",
       }),
      colors: {
        woodsmoke: '#0d0e0e',
        concrete: '#f3f3f3'
      },
      fontSize: {
        '14xl': '16rem',
        '20xl': '24rem'
      },
      keyframes: {
        scrollText: {
          'from': { transform: 'translateX(0%)' },
          'to': { transform: 'translateX(-50%)' },
        }
      },
      lineHeight: {
        '16': '4rem',
        '18.5': '4.62rem',
        '27.5': '6.875rem',
      },
      translate: {
        0: '0 !important'
      },
      zIndex: {
        '1': '1',
        '2': '2',
        '3': '3',
        '4': '4',
        '5': '5',
        '6': '6',
        '7': '7',
        '8': '8',
        '9': '9'
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
