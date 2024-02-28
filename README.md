# Yii2 Docker Template

Basic template of docker-compose.yml for Yii2 advanced

## How to use

1. Make the necessary changes to `env.example`, it is usually enough to change `APP_NAME`.


2. Rename `env.example` to `.env`.


3. Change the database connection configuration in the file `common/config/main-local.php` or `environments/dev/common/config/main-local.php`:

```php
    ...
    'components' => [
        'db' => [
            'class' => \yii\db\Connection::class,
            'dsn' => 'mysql:host=mysql;dbname=app-db',
            'username' => 'root',
            'password' => 'root',
            'charset' => 'utf8mb4',
        ],
        'mailer' => [
            'class' => \yii\symfonymailer\Mailer::class,
            'viewPath' => '@common/mail',
            'useFileTransport' => false,
            'transport' => [
                'dsn' => 'smtp://mailcatcher:1025',
            ],
        ],
        ...

```


4. Run docker compose:

```bash
docker compose -f docker-compose.yml -p {APP_NAME} -d
```


5. Available domains

- http://{APP_NAME}.localhost - frontend
- http://admin.{APP_NAME}.localhost - backend
- http://pma.{APP_NAME}.localhost - phpMyAdmin
- http://mail.{APP_NAME}.localhost - MailCatcher