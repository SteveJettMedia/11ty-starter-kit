#!/bin/bash

# Initialize Git
git init;
cat << EOF > .gitignore 
coverage  
dist 
node_modules  
package-lock.json  
*.log  
.*  
!*/*.babelrc.js  
!.dockerignore  
!.editorconfig  
.eslintignore  
.eslintrc  
.gitignore  
!.gitlab-ci.yml  
!.npmignore  
!.storybook  
!.npmrc  
.prettierignore
EOF

# Import NPM Packages
npm init -y;
cat << EOF > scripts.txt
    "watch": "webpack --watch",
    "start": "webpack serve --open --config webpack.dev.js",
    "build": "webpack --config webpack.prod.js"
EOF

# Automatically add scripts to package.json (need to fix)
# awk 'NR==7{$0=$0","}1' package.json > temp && mv temp package.json
# awk 'NR==7{$0=$0"\n\"watch\": \"webpack --watch\",\n\"start\": \"webpack serve --open --config webpack.dev.js\",\n\"build\": \"webpack --config webpack.prod.js\""}1' package.json > temp && mv temp package.json

# Development Packages
# npm install webpack webpack-cli webpack-dev-server webpack-merge html-webpack-plugin html-loader css-loader style-loader eslint --save-dev;
npm install --save-dev webpack webpack-cli webpack-dev-server webpack-merge html-webpack-plugin html-loader css-loader style-loader eslint;

# Production Packages
npm install html-webpack-plugin --save-dev;

# Linting Packages
npm install --save-dev --save-exact prettier;
npx install-peerdeps --dev eslint-config-airbnb-base -y;

# Create Folder & File Structure
mkdir src  src/assets src/assets/css src/assets/js src/assets/fonts src/assets/img src/components dist;
touch src/index.js src/index.html  webpack.common.js webpack.dev.js webpack.prod.js;

cat << EOF > ./src/index.html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body></body>
</html>
EOF

cat << EOF > ./src/assets/css/styles.css
*,
*::before,
*::after {
  box-sizing: border-box;
}

body {
  margin: 0;
  padding: 0;
}

img {
  width: 100%;
}

h1,
h2,
h3 {
  margin-top: 0;
}

:root {
  --ff-body: "", sans-serif;
  --ff-heading: "", sans-serif;

  --clr-primary-400: hsl(60 100% 50%);
  --clr-neutral-900: hsl(0 0% 0%);
  --clr-neutral-100: hsl(0 0% 100%);

  --gs-900: #323232;
  --gs-700: #4a4a4a;
  --gs-500: #8a8a8a;
  --gs-300: #d7d7d7;
  --gs-150: #f1f1f1;
  --gs-100: #fafafa;

  --fs-xl: clamp(3.5rem, 12vw + 1rem, 12rem);
  --fs-600: 2rem;
  --fs-400: 1rem;

  --section-padding: 10rem;

  /* ------------------------------- CODE STITCH ------------------------------ */

  --primary: #ff6a3e;
  --primaryLight: #ffba43;
  --secondary: #ffba43;
  --secondaryLight: #ffba43;
  --headerColor: #1a1a1a;
  --bodyTextColor: #4e4b66;
  --bodyTextColorWhite: #fafbfc;
  /* 13px - 16px */
  --topperFontSize: clamp(0.8125rem, 1.6vw, 1rem);
  /* 31px - 49px */
  --headerFontSize: clamp(1.9375rem, 3.9vw, 3.0625rem);
  --bodyFontSize: 1rem;
  /* 60px - 100px top and bottom */
  --sectionPadding: clamp(3.75rem, 7.82vw, 6.25rem) 1rem;
}

@media (min-width: 40em) {
  :root {
    --fs-600: 3rem;
    --fs-400: 1.125rem;
  }
}

/* -------------------------------------------------------------------------- */
/*                         CODE STITCH UTILITY STYLES                         */
/* -------------------------------------------------------------------------- */

.cs-topper {
  font-size: var(--topperFontSize);
  line-height: 1.2em;
  text-transform: uppercase;
  text-align: inherit;
  letter-spacing: 0.1em;
  font-weight: 700;
  color: var(--primary);
  margin-bottom: 0.25rem;
  display: block;
}

.cs-title {
  font-size: var(--headerFontSize);
  font-weight: 900;
  line-height: 1.2em;
  text-align: inherit;
  max-width: 43.75rem;
  margin: 0 0 1rem 0;
  color: var(--headerColor);
  position: relative;
}

.cs-text {
  font-size: var(--bodyFontSize);
  line-height: 1.5em;
  text-align: inherit;
  width: 100%;
  max-width: 40.625rem;
  margin: 0;
  color: var(--bodyTextColor);
}

/* -------------------------------------------------------------------------- */
/*                              MY UTILITY STYLES                             */
/* -------------------------------------------------------------------------- */

.container {
  width: 80%;
  max-width: 750px;
  margin: 0 auto;
}

.row {
  /* flex container, parent */
  display: flex;
  justify-content: space-between;
  overflow: hidden;
}

.col {
  /* child */
  width: 100%;
}

.crop-to-fit {
  flex-shrink: 0;
  min-width: 100%;
  min-height: 100%;
}
EOF

cat << EOF > ./src/index.js
import './assets/css/styles.css';

const hello = 'Hello World!';
const appendedElement = document.createElement('h1');
appendedElement.textContent = hello;
document.body.appendChild(appendedElement);
EOF

# Webpack Configuration


cat << EOF > webpack.common.js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin'); // eslint-disable-line

module.exports = {
  entry: {
    app: './src/index.js',
  },
  devtool: 'inline-source-map',
  devServer: {
    static: './dist',
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
      filename: 'index.html',
      title: 'Production',
      inject: 'body',
    }),
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
    clean: true,
  },
  optimization: {
    runtimeChunk: 'single',
  },
  module: {
    rules: [
      {
        test: /\.html$/i,
        loader: 'html-loader',
      },
      {
        test: /\.css$/i,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: 'asset/resource',
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: 'asset/resource',
      },

    ],
  },
};
EOF

cat << EOF > webpack.dev.js
const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common, {
  mode: 'development',
  devtool: 'inline-source-map',
  devServer: {
    static: './dist',
  },
});
EOF

cat << EOF > webpack.prod.js
const { merge } = require('webpack-merge');
const common = require('./webpack.common');

module.exports = merge(common, {
  mode: 'production',
  devtool: 'source-map',
});
EOF

# Linting Config & Ignore Files

cat << EOF > .eslintrc.js
module.exports = {
    "env": {
        "browser": true,
        "es2021": true
    },
    "extends": "airbnb-base",
    "overrides": [
        {
            "env": {
                "node": true
            },
            "files": [
                ".eslintrc.{js,cjs}"
            ],
            "parserOptions": {
                "sourceType": "script"
            }
        }
    ],
    "parserOptions": {
        "ecmaVersion": "latest",
        "sourceType": "module"
    },
    "rules": {
    }
}
EOF

cat << EOF > .eslintignore;
coverage  
dist 
node_modules  
package-lock.json  
*.log  
.*  
!*/*.babelrc.js  
!.dockerignore  
!.editorconfig  
!.eslintignore  
!.eslintrc  
!.gitignore  
!.gitlab-ci.yml  
!.npmignore  
!.storybook  
!.npmrc  
!.prettierignore
EOF

cat << EOF > .prettierignore;
coverage  
dist 
node_modules  
package-lock.json  
*.log  
.*  
!*/*.babelrc.js  
!.dockerignore  
!.editorconfig  
!.eslintignore  
!.eslintrc  
!.gitignore  
!.gitlab-ci.yml  
!.npmignore  
!.storybook  
!.npmrc  
!.prettierignore
EOF

node --eval "fs.writeFileSync('.prettierrc','{}\n')"
# npm init @eslint/config;

echo "dev environment has been created, initializing first commit…"

git add .;
git commit -m "First Commit";

npm run start
