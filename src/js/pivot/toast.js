import { generateUUID } from './generate-uuid.js';

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
export const toast = (config) => {
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
export const initToastsEventListeners = () => {
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