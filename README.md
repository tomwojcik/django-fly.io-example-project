# django-fly.io-example-project
Example Django project to test the deployment on Fly.io

It assumes that you have:
- installed `flyctl` https://fly.io/docs/hands-on/install-flyctl/
- signed up using the UI https://fly.io/app/sign-up
- authorized cli using `flyctl auth login` https://fly.io/docs/hands-on/sign-in/
- a working local docker setup

## What is it that you see

It's a very small Django project that allows you to test the deployment process to Fly. You can run it locally with `make up`. The same docker images are used on Fly.

See it live at https://hello-django.fly.dev/. If it's not available anymore, it means I needed my free app for something else.
On page load it will +1 the counter to prove that the DB state is persistent. 


## Fly Configuration

Warning! Free tier does not run at edge, so you should be running all connected apps within the same region. As I'm from Poland and I care about GDPR, I've decided to choose `fra (Frankfurt, Germany)`.

## Secrets

In `.env.example` you can find db secrets that will be automatically added once you attach the DB to the app. For this simple project you can safely assume that the local env is as close to prod as it gets.

## Want to try it yourself?

1. Clone the repository.
2. Create an empty app. This is just a placeholder as we don't deploy anything yet. [docs: flyctl apps create](https://fly.io/docs/flyctl/apps-create/)
```cli
$ flyctl apps create
```
3. Check the dashboard, make sure you can see the app there.
4. Create the DB. It might take a few minutes. [docs: flyctl postgres](https://fly.io/docs/reference/postgres/)
```cli
$ flyctl postgres create
```
5. On deploy, you probably want `python manage.py migrate` to run automatically. This command is already set as a release command in `fly.toml` file in this repository (similar to Heroku release phase task), but the app can't do that if it can't access the DB. Now, even though nothing has been deployed yet, we want to connect the app with the DB. [docs: flyctl postgres attach](https://fly.io/docs/flyctl/postgres-attach/)
```cli
$ flyctl postgres attach --app <app-name> <app-name-db>
```
You should see something like

```cli
The following secret was added to hello-django:
  DATABASE_URL=postgres://hello_django:passwd@hello-django-db.internal:5432/hello_django
```
From now on this DB connection string will be available as an env variable in the Django app. Locally it works the same, see `.env.example`.

6. Edit `ALLOWED_HOSTS` in settings. You need to replace `hello-django.fly.dev` with the host of your app. In other words, just replace `hello-django` with your app name.
```cli
ALLOWED_HOSTS = ["0.0.0.0", "localhost", "127.0.0.1", "hello-django.fly.dev"]
```
7. Edit name of your app in `fly.toml` file. `app` needs to match your actual app name.
8. The final step is the deployment. Run manually and see what happens. It should build the docker image, push it to fly registry, deploy, run release command (`migrate`). Next deployments should happen automatically on push (on Github only, see `.github`). [docs: flyctl deploy](https://fly.io/docs/flyctl/deploy/)
```cli
$ flyctl deploy
```

You're live.

You can read more about my experience with Fly at https://tomwojcik.com/posts/2022-09-02/django-app-on-fly
