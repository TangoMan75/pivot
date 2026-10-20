/**
 * The `setTabEventListener` function attaches a click event listener to an
 * element. When the element is clicked, the function retrieves the tabpanel
 * element specified by the tab `aria-controls` attribute and hides every other
 * panels.
 */
export const setTabEventListener = (tab, tabs) => {
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
export const initTabsEventListeners = () => {
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