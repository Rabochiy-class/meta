# META
Файлы конфигурация и сценариев для деплоя сервисов разными стратегиями с минимальными (надеемся) затратами.

## Создание SSL сертификата
Создаем сертификат для нашего домена (сейчас у продакшена это https://streamsync.ru/):

```shell
certbot --standalone -d streamsync.ru
```

## Обновление SSL сертификата
### Ручное
Сетртификат от CA LetsEncrypt действителен только 90 дней, после чего его требуется обновить. Стоит также
учитывать rate-limit квоту LetsEncrypt в 20 генераций в 7 дней.

Для обновления сертификата требуются свободные порты 80 и 443, так что перед обновлением контейнеры будут
остановлены, после чего подняты по завершению.

```shell
certbot renew --pre-hook "docker-compose -f ./docker-compose-reverse.yml down" --post-hook "docker-compose -f ./docker-compose-reverse.yml up -d"
```

### Планирование
Так же, для автоматизации, можно добавить задачу в `crontab`. Открываем cron файл:

```shell
crontab -e
```

И добавляем ежедненвую генерацию:
```shell
@daily certbot renew --pre-hook "docker-compose -f ./docker-compose-reverse.yml down" --post-hook "docker-compose -f ./docker-compose-reverse.yml up -d"
```
