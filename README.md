# META
Файлы конфигурация и сценариев для деплоя сервисов разными стратегиями с минимальными (надеемся) затратами.

## Запуск

Production запуск подразумевает использование Nginx с reverse proxy. Команда для запуска (с пересборкой):

```shell
docker compose -f docker-compose-reverse.yml up --build
```

Для отключения:

```shell
docker compose -f docker-compose-reverse.yml down --build
```

## Создание SSL сертификата
Создаем сертификат для нашего домена (сейчас у продакшена это https://streamsync.ru/):

```shell
certbot certonly --standalone -d streamsync.ru
```

## Обновление SSL сертификата
### Ручное
> Команда из [Создание SSL сертификата](#создание-ssl-сертификата) автоматически устанавливает задачу для renew, информация ниже для
> общего развития :)

Сетртификат от CA LetsEncrypt действителен только 90 дней, после чего его требуется обновить. Стоит также
учитывать rate-limit квоту LetsEncrypt в 20 генераций в 7 дней.

Для обновления сертификата требуются свободные порты 80 и 443, так что перед обновлением контейнеры будут
остановлены, после чего подняты по завершению.

```shell
certbot renew --pre-hook "docker compose -f ./docker-compose-reverse.yml down" --post-hook "docker compose -f ./docker-compose-reverse.yml up -d"
```

### Планирование
Так же, для автоматизации, можно добавить задачу в `crontab`. Открываем cron файл:

```shell
crontab -e
```

И добавляем ежедненвую генерацию:
```shell
@daily certbot renew --pre-hook "docker compose -f ./docker-compose-reverse.yml down" --post-hook "docker compose -f ./docker-compose-reverse.yml up -d"
```
