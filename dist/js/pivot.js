/**
 * TangoMan Pivot CSS
 *
 * @author  "Matthias Morin" <mat@tangoman.io>
 * @version 0.1.0
 * @license MIT
 * @link    https://picocss.com
 * @link    https://github.com/TangoMan75/pivot
 */

/**
 * navbar scroll
 */
window.addEventListener('scroll', () => {
  const header = document.getElementById('header');
  const scrollPosition = window.scrollY;
  if (scrollPosition > 100) {
    header.classList.add('fixed');
  } else {
    header.classList.remove('fixed');
  }
});

/**
 * set theme
 */
const setTheme = (theme = 'light') => {
  const themeIcon = themeToggle.querySelector('svg');
  document.documentElement.dataset.theme = theme === 'light' ? 'light' : 'dark';
  themeToggle.setAttribute('aria-label', theme === 'light' ? 'Turn on dark mode' : 'Turn off dark mode');
  theme === 'light' ? themeIcon.classList.remove('moon') : themeIcon.classList.add('moon');
}

/**
 * init theme toggle
 */
const themeToggle = document.getElementById('theme-toggle');
themeToggle.addEventListener('click', () => {
  setTheme(document.documentElement.dataset.theme === 'light' ? 'dark' : 'light');
});

setTheme(document.documentElement.dataset.theme);

/**
 * generate random UUID
 */
function generateUUID() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
    const r = Math.random() * 16 | 0;
    const v = c === 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

/**
 * The `removeElement` function removes an element from the DOM and
 * its controlled elements recursively. It also applies a fade-out 
 * animation before removal.
 */
function removeElement(element) {
  if (!element) return;

  element.style.transition = 'opacity 0.5s ease-in-out';
  element.style.opacity = '0';
  setTimeout(() => {
    element.remove();
  }, 500);

  let controlledId = element.getAttribute('aria-controls');
  if (controlledId) {
    const controlledElement = document.getElementById(controlledId);
    if (controlledElement) {
      removeElement(controlledElement);
    }
  }
}

/**
 * The `setCloseEventListener` function attaches a click event listener to an 
 * element. When the element is clicked, the function retrieves the element
 * specified by the `aria-controls` attribute and removes it from the DOM.
 */
function setCloseEventListener(element) {
  if (!element) return;

  element.addEventListener('click', (event) => {
    event.stopPropagation();

    let targetId = element.getAttribute('aria-controls');
    if (targetId) {
      removeElement(document.getElementById(targetId));
      
      return;
    }

    // if aria-controls is not set, we remove the parent element
    removeElement(element.parentElement);
  });
}

/**
 * The `setTabEventListener` function attaches a click event listener to an
 * element. When the element is clicked, the function retrieves the tabpanel
 * element specified by the tab `aria-controls` attribute and hides every other
 * panels.
 */
function setTabEventListener(tab, tabs) {
  if (!tab) return;

  tab.addEventListener('click', () => {
    const panelId = tab.getAttribute('aria-controls');
    const panel = panelId ? document.getElementById(panelId) : null;

    tab.setAttribute('aria-selected', 'true');
    if (panel) {
      panel.style.display = 'block';
      panel.setAttribute('aria-hidden', 'false');
    }

    tabs.forEach((otherTab) => {
      if (otherTab === tab) return;

      otherTab.setAttribute('aria-selected', 'false');
      const otherPanelId = otherTab.getAttribute('aria-controls');
      const otherPanel = otherPanelId ? document.getElementById(otherPanelId) : null;
      if (otherPanel) {
        otherPanel.style.display = 'none';
        otherPanel.setAttribute('aria-hidden', 'true');
      }
    });
  });
}

/**
 * display toast
 */
function toast(objToast) {
  if (!objToast) return;
  
  let toastContainer = document.getElementById('toast-container');
  if (!toastContainer) {
    toastContainer = document.createElement('div');
    toastContainer.id = 'toast-container';
    document.body.appendChild(toastContainer);
  }
  
  objToast.position = objToast.position ?? 'right';
  toastContainer.classList = objToast.position;

  objToast.id = objToast.id ?? generateUUID();
  objToast.duration = objToast.duration ?? 5000;
  objToast.type = objToast.type ?? 'info';

  switch (objToast.type) {
    case 'danger':
      objToast.icon = objToast.icon ?? '🚨';
      objToast.title = objToast.title ?? 'Danger';
      objToast.classList = objToast.classList ?? 'danger';
      break;
    case 'warning':
      objToast.icon = objToast.icon ?? '⚠️';
      objToast.title = objToast.title ?? 'Warning';
      objToast.classList = objToast.classList ?? 'warning';
      break;
    case 'success':
      objToast.icon = objToast.icon ?? '✅';
      objToast.title = objToast.title ?? 'Success';
      objToast.classList = objToast.classList ?? 'success';
      break;
    case 'info':
    default:
      objToast.icon = objToast.icon ?? 'ℹ️';
      objToast.title = objToast.title ?? 'Info';
      objToast.classList = objToast.classList ?? 'info';
      break;
  }

  if (objToast.fonticon) {
    objToast.icon = `<span class="${objToast.fonticon}"></span>`;
  }

  const toastElement = document.createElement('div');
  toastElement.setAttribute('role', 'alert');
  toastElement.classList = objToast.classList;
  toastElement.setAttribute('id', objToast.id);
  toastElement.innerHTML = `
      <header>
        <button class="close" tabindex="-1" role="button" aria-label="Close" aria-controls="${objToast.id}"></button>
        ${objToast.icon}&nbsp;${objToast.title}
      </header>
      <p role="alertdialog">${objToast.message ? objToast.message : ''}</p>
      <footer>${objToast.footer ?? ''}</footer>
    `;

  setCloseEventListener(toastElement.querySelector('button'));
  toastContainer.appendChild(toastElement);

  if (objToast.duration > 0) {
    setTimeout(() => {
      removeElement(toastElement);
    }, objToast.duration);
  }
}

/**
 * init eventListeners for close buttons
 */
[...document.getElementsByClassName('close')].forEach((button) => {
  button.setAttribute('tabindex', '-1');
  setCloseEventListener(button);
});

/**
 * init eventListeners for toasts
 */
[...document.querySelectorAll('[data-toast]')].forEach((e) => e.addEventListener('click', () => {
  toast({
    duration: e.dataset.toastDuration ?? null,
    fonticon: e.dataset.toastFonticon ?? null,
    footer: e.dataset.toastFooter ?? null,
    icon: e.dataset.toastIcon ?? null,
    message: e.dataset.toast ?? null,
    position: e.dataset.toastPosition ?? null,
    title: e.dataset.toastTitle ?? null,
    type: e.dataset.toastType ?? null,
  });
}));

 /**
 * init eventListeners for tabs
 */
[...document.querySelectorAll('[role=tablist]')].forEach((tablist) => {
  if (!tablist) return;

  const tabs = [...tablist.querySelectorAll('[role="tab"]')];
    let index = 0;
    tabs.forEach((tab) => {
      tab.setAttribute('aria-selected', index === 0 ? 'true' : 'false');
      tab.setAttribute('tabindex', '0');
      const panelId = tab.getAttribute('aria-controls');

      if (panelId) {
        const panel = document.getElementById(panelId);
        panel.style.display = index === 0 ? 'block' : 'none';
        panel.setAttribute('aria-hidden', index === 0 ? 'false' : 'true');
        panel.setAttribute('aria-labelledby', tab.getAttribute('id'));
      }
      index++;

      if (tab.getAttribute('disabled') !== 'true' && tab.getAttribute('aria-disabled') !== 'true') {
        setTabEventListener(tab, tabs);
      }
    });
});

/**
 * animate
 */
const animate = (element) => {
  if (!element) return;
  const animation = element.dataset.animation ?? 'spin';

  element.classList.add(animation);
  element.classList.add('remove-pseudo-elements');
  setTimeout(() => {
    element.classList.remove(animation);
    element.classList.remove('remove-pseudo-elements');
  }, 440);
}

 /**
 * init eventListeners for animated elements
 */
[...document.getElementsByClassName('animate')].forEach((element) => {
    element.addEventListener('click', () => {
        animate(element);
    });
});

