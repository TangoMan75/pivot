export const setTheme = (theme = 'light') => {
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;

  document.documentElement.dataset.theme = theme;
  themeToggleButton.setAttribute('aria-label', theme === 'dark' ? 'Turn off dark mode' : 'Turn on dark mode');
  localStorage.setItem('theme-preference', theme);

  const themeIcon = themeToggleButton.querySelector('svg');
  if (!themeIcon) return;

  theme === 'dark' ? themeIcon.classList.add('moon') : themeIcon.classList.remove('moon');
};

export const initThemeToggleButtonEventListener = () => {
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;

  const savedTheme = localStorage.getItem('theme-preference');
  if (savedTheme) {
    setTheme(savedTheme);
  } else {
    let prefersDarkMode = false;
    if (window.matchMedia) {
      prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    }
    setTheme(prefersDarkMode ? 'dark' : 'light');
  }

  themeToggleButton.addEventListener('click', () => {
    setTheme(document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark');
  });
};