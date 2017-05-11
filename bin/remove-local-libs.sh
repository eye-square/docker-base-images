#! /usr/local/bin/node

const fs = require('fs');
const package = require(process.env.PACKAGE);

const removeFrom = key => {
  package[key] = Object.keys(package[key])
    .reduce((validPackages, packageName) => {
      if(packageName.indexOf('e2-') === -1){
        validPackages[packageName] = package[key][packageName];
      }
      return validPackages;
    }, {})
}

if(package.dependencies) {
  removeFrom('dependencies');
}
if(package.devDependencies) {
  removeFrom('devDependencies');
}

fs.writeFileSync(process.env.PACKAGE, JSON.stringify(package, null, '  '), {
  // flag: "wx",
});
