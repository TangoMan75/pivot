/**
 * TangoMan Pivot CSS
 *
 * @author  "Matthias Morin" <mat@tangoman.io>
 * @version 0.1.0
 * @license MIT
 * @link    https://picocss.com
 * @link    https://github.com/TangoMan75/pivot
 */

import { copyToClipboard } from './pivot/copy-to-clipboard.js';
import { toast } from './pivot/toast.js';

import { fontawesome } from './icons/fontawesome.js';
import { brands } from './icons/brands.js';

function iconTemplate(icon) {
  return `<li><span class="fa-${icon.type} ${icon.name}"></span>&nbsp;&nbsp;<a href="https://fontawesome.com/icons/${icon.shortname}" target="_blank" rel="noopener noreferer nofollow">fa-${icon.type} ${icon.name}</a></li>`;
}

function iconListTemplate(icons) {
  return `
  <ul class="no-decoration">${icons.map((icon) => iconTemplate(icon)).join('')}</ul>
  `;
}

function columnTemplate(column) {
  return `
  <div class="grid">
    ${column.map((icons) => iconListTemplate(icons)).join('')}
  </div>
  `;
}

function articleTemplate(article) {
  return `
    <article id="${article.title.toLowerCase()}">
        <header>
            <h3>📍 ${article.title}</h3>
        </header>
        ${article.columns.map((column) => columnTemplate(column)).join('')}
        <footer>
            <a class="no-decoration" href="#top">⬆️ Top</a>
        </footer>
    </article>
  `;
}

function formatColumns(icons, type = 'solid') {
  const objIcons = icons.map((icon) => ({
    type,
    name: icon,
    shortname: icon.replace('fa-', ''),
  }));

  const numberOfColumns = 2;
  const itemsPerColumn = 12;
  const columns = [[]];
  let j = 0;
  for (let i = 0; i < objIcons.length; i += itemsPerColumn) {
    if (columns[j].length === numberOfColumns) {
      j++;
      columns[j] = [];
    }
    columns[j].push(objIcons.slice(i, i + itemsPerColumn));
  }

  return columns;
}

/**
 * load FontAwesome icons from json
 */
const solidContainer = document.querySelector('#solid');
if (solidContainer) {
  const columns = formatColumns(fontawesome);
  solidContainer.outerHTML = articleTemplate({
    title: 'Solid',
    columns,
  });
}

/**
 * load FontAwesome icons from json
 */
const brandsContainer = document.querySelector('#brands');
if (brandsContainer) {
  const columns = formatColumns(brands, 'brands');
  brandsContainer.outerHTML = articleTemplate({
    title: 'Brands',
    columns,
  });
}

/**
 * init eventListeners for icons
 */
[...document.querySelectorAll('.fa-solid, .fa-brands')].forEach((element) => element.addEventListener('click', (event) => {
  copyToClipboard(event.target.classList);
  toast({
    fonticon: `${event.target.classList}`,
    title: `${event.target.classList}`,
    message: `<strong>"${event.target.classList}"</strong> copied to clipboard !`,
  });
}));
