# 11ty Starter Kit

A command-line tool that instantly scaffolds a production-ready Eleventy (11ty) project with modern tooling, linting, and best practices built-in.

## 🚀 Features

- **Eleventy 2.0** - Fast and flexible static site generator
- **Nunjucks Templating** - Powerful template engine with includes and layouts
- **Rollup Bundling** - Modern JavaScript bundling with code splitting
- **ESLint & Prettier** - Automated code quality and formatting
- **Hot Reloading** - Live browser refresh during development
- **Organized Structure** - Logical folder organization for scalability
- **NPM Scripts** - Pre-configured build, dev, and lint commands

## 📋 Prerequisites

- Node.js 14+ and npm
- macOS or Linux (for the installation script)
- Basic command line knowledge

## 🛠️ Installation

### Method 1: Global Installation (Recommended)

Install the 11ty-clean-slate command globally on your system:

```bash
curl -fsSL https://raw.githubusercontent.com/SteveJettMedia/11ty-starter-kit/main/11ty-clean-slate \
  | sudo tee /usr/local/bin/11ty-clean-slate > /dev/null \
  && sudo chmod +x /usr/local/bin/11ty-clean-slate
```

### Method 2: Direct Download

Download and run the script directly:

```bash
curl -O https://raw.githubusercontent.com/SteveJettMedia/11ty-starter-kit/main/11ty-clean-slate
chmod +x 11ty-clean-slate
./11ty-clean-slate my-project
```

## 💻 Usage

### Create a New Project

```bash
11ty-clean-slate my-awesome-site
```

Or if no project name is provided, it will default to "eleventy-starter":

```bash
11ty-clean-slate
```

### What Happens Next

The script will automatically:
1. Create a new directory with your project name
2. Set up the complete folder structure
3. Generate all configuration files
4. Create starter templates and assets
5. Install all npm dependencies
6. Display next steps

## 📁 Project Structure

After running the script, you'll get this structure:

```
my-awesome-site/
├── src/                    # Source files
│   ├── _data/             # Global data files
│   ├── _includes/         # Reusable partials
│   ├── _layouts/          # Page layouts
│   ├── assets/            # Static assets
│   │   ├── css/          # Stylesheets
│   │   ├── js/           # JavaScript files
│   │   └── images/       # Image assets
│   └── index.njk          # Homepage template
├── _site/                 # Built site (gitignored)
├── .eleventy.js           # Eleventy configuration
├── rollup.config.js       # Rollup bundler config
├── package.json           # Project dependencies
├── .eslintrc.js          # ESLint rules
├── .prettierrc           # Prettier formatting
├── .gitignore            # Git ignore rules
└── README.md             # Project documentation
```

## 🎯 Available Commands

Once your project is created, navigate to the directory and use these commands:

### Development
```bash
npm start
```
- Starts the development server at http://localhost:8080
- Watches for file changes
- Live reloads the browser
- Runs Rollup in watch mode

### Production Build
```bash
npm run build
```
- Builds optimized static files to `_site/`
- Minifies JavaScript
- Ready for deployment

### Code Quality
```bash
# Check for linting errors
npm run lint

# Auto-format code
npm run format

# Clean build directory
npm run clean
```

## 🎨 Customization

### Modify Templates
- Edit `src/index.njk` for the homepage
- Add new pages in `src/` with `.njk`, `.md`, or `.html` extensions
- Create layouts in `src/_layouts/`
- Add reusable components in `src/_includes/`

### Styling
- Main stylesheet: `src/assets/css/style.css`
- Add more CSS files and they'll be automatically copied
- CSS is passed through without processing (add your own preprocessor if needed)

### JavaScript
- Entry point: `src/assets/js/main.js`
- Bundled output: `_site/assets/js/bundle.js`
- Supports ES6+ modules and npm packages
- Automatic minification in production

### Configuration
- Eleventy config: `.eleventy.js`
- Rollup config: `rollup.config.js`
- Add Eleventy plugins, filters, and shortcodes as needed

## 🚢 Deployment

The generated `_site/` directory contains your static site ready for deployment to:

- **Netlify**: Drop the folder or connect your git repo
- **Vercel**: `vercel --prod`
- **GitHub Pages**: Use GitHub Actions to build and deploy
- **S3/CloudFront**: Upload the `_site/` contents
- **Any static host**: FTP, rsync, or CI/CD pipeline

### Example Netlify Configuration
Create a `netlify.toml` in your project root:

```toml
[build]
  command = "npm run build"
  publish = "_site"

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
```

## 🔧 Advanced Usage

### Adding Eleventy Plugins

Edit `.eleventy.js`:

```javascript
const pluginRss = require("@11ty/eleventy-plugin-rss");

module.exports = function(eleventyConfig) {
  eleventyConfig.addPlugin(pluginRss);
  // ... rest of config
};
```

### Using Environment Variables

Create a `.env` file (already gitignored):

```env
API_KEY=your-secret-key
SITE_URL=https://example.com
```

Access in templates via a data file:

```javascript
// src/_data/env.js
require('dotenv').config();

module.exports = {
  apiKey: process.env.API_KEY,
  siteUrl: process.env.SITE_URL
};
```

### Adding Collections

```javascript
// In .eleventy.js
eleventyConfig.addCollection("posts", function(collectionApi) {
  return collectionApi.getFilteredByGlob("src/posts/*.md");
});
```

## 🐛 Troubleshooting

### Installation Issues

If the global installation fails:
- Ensure you have proper permissions (use `sudo` if needed)
- Check that `/usr/local/bin` is in your PATH
- Try the direct download method instead

### Build Errors

- Clear the cache: `npm run clean`
- Delete `node_modules` and reinstall: `rm -rf node_modules && npm install`
- Check for syntax errors in templates
- Ensure all required files exist

### Port Already in Use

If port 8080 is busy, change it in `.eleventy.js`:

```javascript
return {
  // ... other config
  serverOptions: {
    port: 8081
  }
};
```

## 📚 Resources

- [Eleventy Documentation](https://www.11ty.dev/docs/)
- [Nunjucks Templating](https://mozilla.github.io/nunjucks/)
- [Rollup.js Guide](https://rollupjs.org/guide/en/)
- [ESLint Rules](https://eslint.org/docs/rules/)
- [Prettier Options](https://prettier.io/docs/en/options.html)

## 🤝 Contributing

Found a bug or want to add a feature? Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This starter kit is open source and available under the MIT License.

---

Built with ❤️ by [SteveJettMedia](https://github.com/SteveJettMedia)
