class ToastElement extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
    this.duration = 0;
    this.type = '';
    this.icon = '';
    this.title = '';
    this.message = '';
    this.footer = '';
    this.fonticon = '';
    this.classListString = '';
  }

  static get observedAttributes() {
    return ['duration', 'type', 'icon', 'title', 'message', 'footer', 'fonticon', 'class'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (oldValue !== newValue) {
      this[name] = newValue;
      this.render();
    }
  }

  connectedCallback() {
    this.render();
    this.setupCloseListener();
    if (duration > 0)  {
      this.setupTimeout();
    }
  }

  disconnectedCallback() {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
    }
  }

  render() {
    if (!this.isConnected) return;

    this.duration = parseInt(this.duration, 10) || 0;

    switch (this.type) {
      case 'danger':
        this.icon = this.icon || '🚨';
        this.title = this.title || 'Danger';
        this.classListString = 'alert alert--danger';
        break;
      case 'warning':
        this.icon = this.icon || '⚠️';
        this.title = this.title || 'Warning';
        this.classListString = 'alert alert--warning';
        break;
      case 'success':
        this.icon = this.icon || '✅';
        this.title = this.title || 'Success';
        this.classListString = 'alert alert--success';
        break;
      case 'info':
      default:
        this.icon = this.icon || 'ℹ️';
        this.title = this.title || 'Info';
        this.classListString = 'alert alert--info';
        break;
    }

    if (this.fonticon) {
      this.icon = this.fonticon;
    }

    this.shadowRoot.innerHTML = `
      <style>
        div>header>span {
          margin-right: 1rem;
        }
        div>p {
          margin-bottom: 1rem;
        }
      </style>
      <div class="${this.classListString}">
        <header>
          <button class="close" role="button" aria-label="Close"></button>
          <span>${this.icon}</span>${this.title}
        </header>
        <p>${this.message || ''}</p>
        <footer>${this.footer || ''}</footer>
      </div>
    `;
  }

  setupCloseListener() {
    const closeButton = this.shadowRoot.querySelector('button.close');
    if (closeButton) {
      closeButton.addEventListener('click', () => {
        this.remove();
      });
    }
  }

  setupTimeout() {
    this.timeoutId = setTimeout(() => {
      this.remove();
    }, this.duration);
  }
}

customElements.define('toast', ToastElement);

export function toast(options) {
  let toastContainer = document.getElementById('toast-container');
  if (!toastContainer) {
    toastContainer = document.createElement('div');
    toastContainer.id = 'toast-container';
    document.body.appendChild(toastContainer);
  }

  const toastEl = document.createElement('toast');

  for (const key in options) {
    if (Object.prototype.hasOwnProperty.call(options, key)) {
      toastEl.setAttribute(key, options[key]);
    }
  }
  toastContainer.appendChild(toastEl);
}