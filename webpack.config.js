import path from 'path';

export default {
  entry: {
    pivot: './src/js/pivot.js',
    icons: './src/js/icons.js',
  },
  output: {
    filename: '[name].js',
    path: path.resolve('dist/js'),
  },
  mode: 'production',
};