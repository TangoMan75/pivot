import { closeButtonTemplate } from './close-button.js';
import { generateUUID } from './generate-uuid.js';
import { setCloseEventListener, removeElement } from './remove-element.js';

/**
 * display toast
 */
export const toast = (objToast) => {
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
  toastElement.innerHTML = `<header>${closeButtonTemplate(objToast.id)}${objToast.icon}&nbsp;${objToast.title}</header><p role="alertdialog">${objToast.message ? objToast.message : ''}</p><footer>${objToast.footer ?? ''}</footer>`;

  setCloseEventListener(toastElement.querySelector('button'));
  toastContainer.appendChild(toastElement);

  if (objToast.duration > 0) {
    setTimeout(() => {
      removeElement(toastElement);
    }, objToast.duration);
  }
};

/**
 * init eventListeners for toasts
 */
export const initToastsEventListeners = () => {
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
};