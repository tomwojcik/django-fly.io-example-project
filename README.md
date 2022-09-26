# django-fly.io-example-project
Example Django app for deployment on Fly.io

It assumes that you have:
- installed `flyctl` https://fly.io/docs/hands-on/install-flyctl/
- signed up using the UI https://fly.io/app/sign-up
- authorized cli using `flyctl auth login` https://fly.io/docs/hands-on/sign-in/
- a working local docker setup

## What is it that you see

See it live at https://hello-django.fly.dev/. If it's not available anymore, it means I needed my free app for something else.
On page load it will +1 the counter to prove that the DB state is persistent. 

If you want to run it locally, just run `make up`.

## Fly Configuration

Warning! Free tier does not run at edge, so you should be running all connected apps within the same region. As I'm from Poland and I care about GDPR, I've decided to choose `fra (Frankfurt, Germany)`.

## Secrets

In .env.example you can find db secrets that will be automatically added once you attach the DB to the app. For this simple project you can safely assume that the local env is as close to prod as it gets.

## Want to try it yourself?

1. Clone the repository.
2. Create "an empty app".
```cli
$ flyctl apps create
```
3. Check the dashboard, make sure you can see the app there.
4. Create the DB. 
```cli
$ flyctl postgres create
```
5. Attach the app (even though nothing has been deployed yet) to the DB. This allows you to run migrations on the first deploy.
```cli
$ flyctl postgres attach --app <app-name> <app-name-db>
```
6. Edit `ALLOWED_HOSTS` in settings. You need to replace `hello-django.fly.dev` with the host of your app. In other words, just replace `hello-django` with your app name.
```cli
ALLOWED_HOSTS = ["0.0.0.0", "localhost", "127.0.0.1", "hello-django.fly.dev"]
```
7. Edit name of your app in `fly.toml` file. `app` needs to match your actual app name.
8. The final step is the deployment. Run manually and see what happens. It should build the docker image, push it to fly registry, deploy, run release command (`migrate`). Next deployments should happen automatically on push (on Github only, see `.github`).
```cli
$ flyctl deploy
```

You're live.

You can read more about my experience with Fly at https://tomwojcik.com/posts/2022-09-02/django-app-on-fly
