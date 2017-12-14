var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: './src/index.coffee',
  // scripts: './src/**/*.coffee',
  // views: './src/**/*.cjsx',
  output: {
    filename: 'simple-gallery-flux.js',
    path: path.resolve(__dirname, 'dist')
  },
  resolve: {
    extensions: ['.js', '.cjsx', '.coffee']
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee-loader', 'cjsx-loader']},
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.js$/, loader: 'babel-loader' }
    ],
    // rules: [
    //   {
    //     test: /\.css$/,
    //     use: [
    //       'style-loader',
    //       'css-loader'
    //     ]
    //   }
    // ]
  }
};
