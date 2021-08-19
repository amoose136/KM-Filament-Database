
module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parserOptions: {
    parser: '@babel/eslint-parser',
    requireConfigFile: false,
  },
  extends: [
    '@nuxtjs',
    'plugin:nuxt/recommended',
    'prettier'
  ],
  plugins: [
  ],


  // add your custom rules here
  rules: {
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    "no-mixed-spaces-and-tabs": [0],
    "no-tabs": 0,
    "skipBlankLines": 0,
    "ignoreComments": 0,
    "no-trailing-spaces": [2, { "skipBlankLines": true }]
  }
}


