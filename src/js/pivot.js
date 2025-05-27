/**
 * TangoMan Pivot CSS
 *
 * @author  "Matthias Morin" <mat@tangoman.io>
 * @version 0.1.0
 * @license MIT
 * @link    https://picocss.com
 * @link    https://github.com/TangoMan75/pivot
 */

import { initCloseButtonsEventListeners } from './pivot/remove-element.js';
import { initAnimatedElementsEventListeners } from './pivot/animate.js';
import { initTabsEventListeners } from './pivot/tabs.js';
import { initThemeToggleButtonEventListener } from './pivot/theme-toggle.js';
import { initToastsEventListeners } from './pivot/toast.js';
import { initMenubarCollapse } from './pivot/menubar-collapse.js';
import { navbarScroll } from './pivot/navbar-scroll.js';

initAnimatedElementsEventListeners();
initCloseButtonsEventListeners();
initMenubarCollapse();
initTabsEventListeners();
initThemeToggleButtonEventListener();
initToastsEventListeners();
navbarScroll();
