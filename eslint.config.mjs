export default [
  {
    files: ['src/js/**/*.js'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        browser: true,
        node: true,
      },
    },
    rules: {
      'no-console': 'off',
      'no-unused-vars': 'warn',
    },
  },
];