import { closeButton } from "./close-button";

/**
 * menubar collapse
 */
export const initMenubarCollapse = () => {
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