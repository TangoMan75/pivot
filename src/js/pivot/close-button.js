import { htmlStringToNode } from './html-string-to-node';

/**
 * close button
 */
export const closeButtonTemplate = (targetId) => {
    let ariaControls = '';
    if (targetId) {
        ariaControls = ` aria-controls="${targetId}"`;
    }

    return `<button class="close" tabindex="-1" role="button" aria-label="Close"${ariaControls}></button>`;
};

export const closeButton = (targetId) => {
    return htmlStringToNode(closeButtonTemplate(targetId));
};