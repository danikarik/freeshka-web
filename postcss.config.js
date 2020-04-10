const tailwindcss = require("tailwindcss")
const cssnano = require("cssnano")
const purgecss = require("@fullhuman/postcss-purgecss")

function minify() {
  return [
    cssnano({ preset: "default" }),
    purgecss({
      content: ["./app/**/*.html.erb", "./app/helpers/**/*.rb", "./app/javascript/**/*.js"],
      defaultExtractor: (content) => content.match(/[\w-/:]+(?<!:)/g) || [],
    }),
  ]
}

module.exports = {
  plugins: [
    tailwindcss("./tailwind.config.js"),
    require("postcss-import"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
    ...(process.env.RAILS_ENV === "production" ? minify() : []),
  ],
}
