const webpack = require('webpack');
const path = require('path');

const isProd = process.env.NODE_ENV === 'production';
const isTest = process.env.NODE_ENV === 'test';

const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");

const CopyWebpackPlugin = require('copy-webpack-plugin');
const { WebpackManifestPlugin } = require('webpack-manifest-plugin');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

const source_path = __dirname;
const output_path = path.join(__dirname, '..', 'priv', 'static');

const plugins = [
  new MiniCssExtractPlugin({
    filename: "css/[name].css"
  }),
  new CopyWebpackPlugin({
    patterns: [
      { from: path.join(source_path, 'static') }
    ]
  }),
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
];

if (isTest) {
  plugins.push(
    new BundleAnalyzerPlugin()
  );
}

if (isProd) {
  plugins.push(
    new WebpackManifestPlugin({
      fileName: 'cache_manifest.json',
      basePath: source_path,
      publicPath: output_path
    })
  );
};

module.exports = {
  devtool: isProd ? false : 'eval-source-map',
  mode: isProd ? 'production' : 'development',
  performance: {
    hints: isTest ? 'warning' : false
  },
  plugins,
  context: source_path,
  entry: {
    app: [
      './css/app.scss',
      './js/app.js'
    ],
  },

  output: {
    path: output_path,
    filename: 'js/[name].js',
    chunkFilename: 'js/[name].js',
    publicPath: '/'
  },

  resolve: {
    modules: [
      'deps',
      'node_modules'
    ],
    extensions: ['.js', '.scss']
  },

  module: {
    rules: [{
      test: /\.js$/,
      exclude: /node_modules/,
      use: [
        'babel-loader',
      ]
    },
    {
      test: /.s?css$/,
      use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
    },
    {
      test: /\.(woff2?|eot|ttf|otf|svg)(\?.*)?$/,
      loader: 'url-loader',
      options: {
        limit: 1000,
        name: 'fonts/[name].[hash:7].[ext]'
      }
    }]
  },

  optimization: {
    minimizer: [
      `...`,
      new CssMinimizerPlugin(),
    ],
  },
};
