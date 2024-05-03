# Fill the Greenhouse
## Introduction
Software Design and Development (COMP 225) semester-long project;
[blurb about gameplay]

## Setup
Node.js is required to install dependencies and run scripts via npm (Node only used for build, game is not run on it)

After cloning the repo, run npm install from your project directory. Then, you can start the local development server by running npm start.

After starting the development server with npm start, you can edit any files in the src folder and webpack will automatically recompile and reload your server (available at http://localhost:8080 by default).

If you want to customize your build like we did, like adding a new webpack loader or plugin (i.e. for loading CSS or fonts), you can modify the webpack/base.js file for cross-project changes, or you can modify and/or create new configuration files and target them in specific npm tasks inside of `package.json'.

## References
Phaser Template: https://github.com/photonstorm/phaser3-project-template

Video with Template: https://www.youtube.com/watch?v=6CR9pKJI2Lc

Phaser 3 Notes: https://rexrainbow.github.io/phaser3-rex-notes/docs/site/

Piskel: https://www.piskelapp.com/
