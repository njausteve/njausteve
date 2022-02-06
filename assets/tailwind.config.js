const colors = require('tailwindcss/colors');

module.exports = {
  content: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js"
  ],
  theme: {
    // colors: {
    //   current: 'currentColor',
    // },
    fontFamily: {
      sans: [
        "Calibre",
        "ui-sans-serif",
        "system-ui",
        "-apple-system",
        "BlinkMacSystemFont",
        '"Segoe UI"',
        "Roboto",
        '"Helvetica Neue"',
        "Arial",
        '"Noto Sans"',
        "sans-serif",
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
        '"Noto Color Emoji"',
      ]
    },
    screens: {
      sm: "576px",
      md: "768px",
      lg: "992px",
      xl: "1200px",
      "2xl": "1400px",
    },
    extend: {
      animation: {
        scrollText: "scrollText 20s infinite linear",
      },
      backgroundImage: (theme) => ({
        "circle-pattern": "url('/images/background-image-circle.svg')",
      }),
      colors: {
        green: colors.emerald,
        yellow: colors.amber,
        purple: colors.violet,
        gray: colors.neutral,
        woodsmoke: "#0d0e0e",
        concrete: "#f3f3f3",
        "the-blue": "#1a27c9",
      },
      fontSize: {
        "14xl": "16rem",
        "20xl": "24rem",
      },
      keyframes: {
        scrollText: {
          from: { transform: "translateX(0%)" },
          to: { transform: "translateX(-50%)" },
        },
      },
      lineHeight: {
        16: "4rem",
        18.5: "4.62rem",
        27.5: "6.875rem",
      },
      translate: {
        0: "0 !important",
      },
      zIndex: {
        1: "1",
        2: "2",
        3: "3",
        4: "4",
        5: "5",
        6: "6",
        7: "7",
        8: "8",
        9: "9",
      },
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require('@tailwindcss/typography')
  ],
};
