/**
 * set theme
 */
export const setTheme = (theme) => {
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;

  // theme can be 'light' or 'dark' only, defaults to 'light'
  document.documentElement.dataset.theme = theme === 'dark' ? 'dark' : 'light';
  // set aria-label
  themeToggleButton.setAttribute('aria-label', theme === 'dark' ? 'Turn off dark mode' : 'Turn on dark mode');

  const themeIcon = themeToggleButton.querySelector('svg');
  if (!themeIcon) return;

  // set svg icon class if any
  theme === 'dark' ? themeIcon.classList.add('moon') : themeIcon.classList.remove('moon');
};

export const initThemeToggleButtonEventListener = () => {
  let prefersDarkMode = false;
  if (window.matchMedia) {
    prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
  }
  
  setTheme(prefersDarkMode ? 'dark' : 'light');
  
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;
  
  themeToggleButton.addEventListener('click', () => {
    // toggle between 'light' and 'dark' mode
    setTheme(document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark');
  });
};