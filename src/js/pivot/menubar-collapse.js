import { closeButton } from "./close-button";

/**
 * menubar collapse
 */
export const initMenubarCollapse = () => {
    const menubar = document.querySelector('nav [role="menubar"]');
    if (!menubar) return;
    
    const button = closeButton();
    menubar.appendChild(button);

    if (window.innerWidth < 768) {
        menubar.setAttribute('aria-expanded', 'false');
    }

    button.addEventListener('click', () => {
        const isVisible = menubar.getAttribute('aria-expanded') !== 'false';
        menubar.setAttribute('aria-expanded', !isVisible);
    });
};