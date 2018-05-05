const webpack = require('webpack');
const path = require('path');

const isProd = process.env.NODE_ENV === 'production';
const isTest = process.env.NODE_ENV === 'test';

const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const autoprefixer = require('autoprefixer');
const ManifestPlugin = require('webpack-manifest-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
const UglifyJSPlugin = require('uglifyjs-webpack-plugin')

const source_path = __dirname;
const output_path = path.join(__dirname, '..', 'priv', 'static');

const css_loaders = [
  {
    loader: 'css-loader?sourceMap'
  },
  {
    loader: 'postcss-loader?sourceMap'
  },
  {
    loader: 'sass-loader?sourceMap'
  }
];

const plugins = [
  new ExtractTextPlugin('css/[name].css'),
  new CopyWebpackPlugin([{ from: path.join(source_path, 'static') }]),
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
    new UglifyJSPlugin({
      test: /\.js($|\?)/i,
      sourceMap: true,
      uglifyOptions: {
        compress: true
      }
    }),
    new ManifestPlugin({
      fileName: 'cache_manifest.json',
      basePath: source_path,
      publicPath: output_path
    })
  );
};

module.exports = {
  devtool: isProd ? false : 'eval-source-map',
  performance: {
    hints: isTest ? 'warning' : false
  },
  plugins,
  context: source_path,
  entry: {
    // session: [
    //   './css/session.scss'
    // ],
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
      test: /\.scss$/,
      exclude: /node_modules/,
      loaders: ExtractTextPlugin.extract({
        fallback: 'style-loader',
        use: css_loaders
      })
    },
    {
      test: /\.(woff2?|eot|ttf|otf|svg)(\?.*)?$/,
      loader: 'url-loader',
      options: {
        limit: 1000,
        name: 'fonts/[name].[hash:7].[ext]'
      }
    }]
  }
};
