/******/ (function() { // webpackBootstrap
/******/ 	"use strict";

;// ./src/js/pivot/generate-uuid.js
/**
 * generate random UUID
 */
const generateUUID = () => 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
  const r = Math.random() * 16 | 0;
  const v = c === 'x' ? r : (r & 0x3 | 0x8);
  return v.toString(16);
});
;// ./src/js/pivot/toast.js


/**
 * Escape HTML characters to prevent XSS
 * @param {string} text - Text to escape
 * @returns {string} Escaped text
 */
const escapeHtml = (text) => {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
};

/**
 * Dismiss a specific toast
 */
const dismiss = (toast) => {
  toast.style.opacity = '0';
  setTimeout(() => {
    toast.remove();
  }, 300);
}

/**
 * display toast
 */
const toast = (config) => {
  if (!config) return;

  const icons = { info: 'ℹ️', success: '✅', warning: '⚠️', danger: '🚨' };
  const defaultConfig = { type: 'info', position: 'right', duration: 3000 };
  const toastConfig = { ...defaultConfig, ...config, ...{ id: generateUUID() } };
  if (config.type === null) toastConfig.type = defaultConfig.type;
  if (config.position === null) toastConfig.position = defaultConfig.position;
  if (config.duration === null) toastConfig.duration = defaultConfig.duration;
  toastConfig.icon = toastConfig.fonticon ? `<span class="${toastConfig.fonticon}"></span>` : icons[toastConfig.type] || icons[defaultConfig.type];
  toastConfig.title = toastConfig.title || toastConfig.type.charAt(0).toUpperCase() + toastConfig.type.slice(1);

  let toastContainer = document.getElementById(`toast-container-${toastConfig.position}`);
  if (!toastContainer) {
    toastContainer = document.createElement('div');
    toastContainer.id = `toast-container-${toastConfig.position}`;
    toastContainer.className = `toast-container ${toastConfig.position}`;
    document.body.appendChild(toastContainer);
  }

  const toastElement = document.createElement('div');
  toastElement.setAttribute('id', toastConfig.id);
  toastElement.setAttribute('role', 'alert');
  toastElement.className = `${toastConfig.type} ${toastConfig.className || ''}`.trim();
  toastElement.innerHTML = `
      <header>
        <span class="close"></span>
        ${toastConfig.icon}&nbsp;${toastConfig.title}
      </header>
      <p role="alertdialog">${escapeHtml(toastConfig.message)}</p>
      ${toastConfig.footer ? `<footer>${toastConfig.footer}</footer>` : ''}
  `;

  toastElement.style.opacity = '0';
  toastElement.style.transition = 'opacity 0.2s';
  toastContainer.appendChild(toastElement);
  requestAnimationFrame(() => {
    toastElement.style.opacity = '1';
  });

  toastElement.addEventListener('click', () => {
    dismiss(toastElement);
  });

  if (toastConfig.duration > 0) {
    setTimeout(() => {
      dismiss(toastElement);
    }, toastConfig.duration);
  }
};

/**
 * init eventListeners for toasts
 */
const initToastsEventListeners = () => {
  [...document.querySelectorAll('[data-toast]')].forEach((e) => e.addEventListener('click', () => {
    toast({
      className: e.dataset.toastClassName ?? null,
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
};
;// ./src/js/pivot/remove-element.js
/**
 * The `removeElement` function removes an element from the DOM and
 * its controlled elements recursively. It also applies a fade-out
 * animation before removal.
 */
const removeElement = (element) => {
  if (!element) return;

  element.style.transition = 'opacity 0.5s ease-in-out';
  element.style.opacity = '0';

  setTimeout(() => {
    element.remove();
  }, 500);

  const controlledId = element.getAttribute('aria-controls');
  if (controlledId) {
    const controlledElement = document.getElementById(controlledId);
    if (controlledElement) {
      removeElement(controlledElement);
    }
  }
};

/**
 * The `setCloseEventListener` function attaches a click event listener to an
 * element. When the element is clicked, the function retrieves the element
 * specified by the `aria-controls` attribute and removes it from the DOM.
 */
const setCloseEventListener = (element) => {
  if (element) {
    element.addEventListener('click', (event) => {
      event.stopPropagation();
      const targetId = element.getAttribute('aria-controls');
      if (targetId) {
        removeElement(document.getElementById(targetId));
        return;
      }
  
      // if `aria-controls` is not set, we remove the parent element
      removeElement(element.parentElement);
    });
  }
};

/**
 * init eventListeners for close buttons
 */
const initCloseButtonsEventListeners = () => {
  [...document.getElementsByClassName('close')].forEach((button) => {
    button.setAttribute('tabindex', '-1');
    setCloseEventListener(button);
  });
};
;// ./src/js/pivot/animate.js
/**
 * animate
 */
const animate = (element) => {
  if (!element) return;
  const animation = element.dataset.animation || 'spin';

  element.classList.add(animation);
  element.classList.add('remove-pseudo-elements');

  element.addEventListener('animationend', function handler() {
    element.classList.remove(animation);
    element.classList.remove('remove-pseudo-elements');
    element.removeEventListener('animationend', handler);
  });
};

/**
 * init eventListeners for animated elements
 */
const initAnimatedElementsEventListeners = () => {
  [...document.getElementsByClassName('animate')].forEach((element) => {
    element.addEventListener('click', () => {
      animate(element);
    });
  });
};
;// ./src/js/pivot/tabs.js
/**
 * The `setTabEventListener` function attaches a click event listener to an
 * element. When the element is clicked, the function retrieves the tabpanel
 * element specified by the tab `aria-controls` attribute and hides every other
 * panels.
 */
const setTabEventListener = (tab, tabs) => {
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
};

/**
 * init eventListeners for tabs
 */
const initTabsEventListeners = () => {
  [...document.querySelectorAll('[role=tablist]')].forEach((tablist) => {
    if (!tablist) return;
    
    const tabs = [...tablist.querySelectorAll('[role="tab"]')];
    let selectedIndex = 0;
    for (let i = 0; i < tabs.length; i++) {
      if (tabs[i].getAttribute('aria-selected') === 'true' || tabs[i].getAttribute('selected') === 'true') {
        selectedIndex = i;
        break;
      }
    }

    for (let i = 0; i < tabs.length; i++) {
      tabs[i].setAttribute('aria-selected', i === selectedIndex ? 'true' : 'false');
      tabs[i].setAttribute('tabindex', '0');

      const panelId = tabs[i].getAttribute('aria-controls');
      const panel = panelId ? document.getElementById(panelId) : null;
      if (!panel) return;

      panel.style.display = i === selectedIndex ? 'block' : 'none';
      panel.setAttribute('aria-hidden', i === selectedIndex ? 'false' : 'true');
      panel.setAttribute('aria-labelledby', tabs[i].getAttribute('id'));

      if (tabs[i].getAttribute('disabled') !== 'true' && tabs[i].getAttribute('aria-disabled') !== 'true') {
        setTabEventListener(tabs[i], tabs);
      }
    };
  });
};
;// ./src/js/pivot/theme-toggle.js
const setTheme = (theme = 'light') => {
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;

  document.documentElement.dataset.theme = theme;
  themeToggleButton.setAttribute('aria-label', theme === 'dark' ? 'Turn off dark mode' : 'Turn on dark mode');
  localStorage.setItem('theme-preference', theme);

  const themeIcon = themeToggleButton.querySelector('svg');
  if (!themeIcon) return;

  theme === 'dark' ? themeIcon.classList.add('moon') : themeIcon.classList.remove('moon');
};

const initThemeToggleButtonEventListener = () => {
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
;// ./src/js/pivot/close-button.js
/**
 * close button
 */
const closeButtonTemplate = (targetId) => {
    let ariaControls = '';
    if (targetId) {
        ariaControls = ` aria-controls="${targetId}"`;
    }

    return `<button class="close" tabindex="-1" role="button" aria-label="Close"${ariaControls}></button>`;
};

const closeButton = (targetId) => {
    const parser = new DOMParser();
    const doc = parser.parseFromString(closeButtonTemplate(targetId), 'text/html');
    return doc.body.firstChild;
};
;// ./src/js/pivot/menubar-collapse.js


/**
 * menubar collapse
 */
const initMenubarCollapse = () => {
    const menubars = document.querySelectorAll('[role="menubar"]');
    if (!menubars) return;

    menubars.forEach((menubar) => {
        const button = closeButton();
        if (menubar.firstChild) {
            menubar.insertBefore(button, menubar.firstChild);
        } else {
            // if menubar is empty for some reason, append the button directly
            menubar.appendChild(button);
        }

        // collapse menubar on small screens
        if (window.innerWidth < 768) {
            menubar.setAttribute('aria-expanded', 'false');
        }

        button.addEventListener('click', () => {
            const isVisible = menubar.getAttribute('aria-expanded') !== 'false';
            menubar.setAttribute('aria-expanded', !isVisible);
        });
    });
};
;// ./src/js/pivot/navbar-scroll.js
/**
 * navbar scroll
 */
const navbarScroll = () => {
  const header = document.getElementById('header');
  if (!header) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 100) {
      header.classList.add('fixed');
    } else {
      header.classList.remove('fixed');
    }
  });
};
;// ./src/js/pivot.js
/**
 * TangoMan Pivot CSS
 *
 * @author  "Matthias Morin" <mat@tangoman.io>
 * @version 0.1.0
 * @license MIT
 * @link    https://picocss.com
 * @link    https://github.com/TangoMan75/pivot
 */










window.toast = toast;

initAnimatedElementsEventListeners();
initCloseButtonsEventListeners();
initMenubarCollapse();
initTabsEventListeners();
initThemeToggleButtonEventListener();
initToastsEventListeners();
navbarScroll();

/******/ })()
;