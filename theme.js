const themeToggle = document.querySelector('.theme-toggle');
const savedTheme = localStorage.getItem('theme');
const body = document.body;

function updateTheme(mode) {
  body.classList.toggle('dark', mode === 'dark');
  themeToggle.textContent = mode === 'dark' ? 'Light mode' : 'Dark mode';
  themeToggle.setAttribute('aria-pressed', mode === 'dark');
  themeToggle.setAttribute('aria-label', mode === 'dark' ? 'Switch to light mode' : 'Switch to dark mode');
}

function loadTheme() {
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const theme = savedTheme || (prefersDark ? 'dark' : 'light');
  updateTheme(theme);
}

themeToggle?.addEventListener('click', () => {
  const isDark = body.classList.contains('dark');
  const nextTheme = isDark ? 'light' : 'dark';
  localStorage.setItem('theme', nextTheme);
  updateTheme(nextTheme);
});

loadTheme();
