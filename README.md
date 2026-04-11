# Домашнее задание к занятию «Введение в Terraform» - Муравский Артем

Версия terraform
![terraform version](img/screen1.png)

1. В `.gitignore` присутствует имя файла `personal.auto.tfvars`, соответственно в нем и можно хранить "чувствительную" информацию.
  
  Секретное содержимое из файла состояния: `"result": "pcT28LiI4XSnNwBt"`
  
  Ошибки в раскомментированном фрагменте:
  - для блока `resource` присутствует только одна метка (тип ресурса) `docker_image`, необходимо добавить вторую метку (имя ресурса), например `nginx`;
  
  - для блока `resource` с типом `docker_container` во второй метке (название ресурса) неверно указано значение `1nginx`, так как может начинаться только с буквы или символа подчеркивания, исправляем на `nginx`;
  
  - для аргумента `name` в блоке `resource "docker_container" "nginx"` неправильно указано значение `example_${random_password.random_string_FAKE.resulT}`, а конкретно нет такой переменной `random_password.random_string_FAKE.resulT`, исправляем на `random_password.random_string.resulT`, но тут тоже ошибка в `resulT` присутствует заглавная буква `T`, итоговый вариант `example_${random_password.random_string.result}`

  Исправленный фрагмент кода
  ![fixed code](img/screen2.png)
  
  Результат выполнения `docker ps`
  ![docker ps](img/screen3.png)
  
  Переименование контейнера на `hello_world`
  ![docker rename](img/screen4.png)
  
  При указании ключа `-auto-approve`, команда `terraform apply` применяется без подтверждения в интерактивном режиме, по сути подтверждается автоматически. Опасность заключается в отсутствии контроля планируемых к выполнению действий с инфраструктурой, которое осуществляется с помощью команды `terraform plan` без этого ключа и включает в себя дальнейшее интерактивное подтверждение. Вследствии этого возможны отличающиеся от ожидаемых изменения в инфраструктуре. Находит применение при автоматизации или, до определенного случая, ленивыми девопсами :)
  
  Результат выполнения `docker ps` после выполнения `terraform apply -auto-approve`
  ![docker ps](img/screen5.png)
  
  Содержимое файла `terraform.tfstate` после выполнения команды  `terraform destroy`
  ![tfstate](img/screen6.png)
  
  Образ `nginx:latest` не удалился после выполнения команды `terraform destroy`, так как в соответствующем блоке `resource.docker_image.nginx` аргументу `keep_locally` установлено значение `true`.
  
  Пункт из [документации](https://library.tf/providers/kreuzwerker/docker/latest/docs/resources/image)
  ![doc1](img/screen7.png)
