# circle-ci-base

contains node + docker + docker-compose

## development

If you want to test the build on an apple silicon chip you need to provide a build platform `linux/amd64`:

```
❯ docker build --platform linux/amd64 -f main.dockerfile -t eyesquare/base-images:main-8.0.0 .
```