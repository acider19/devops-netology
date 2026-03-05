# Задание

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

2. Ответьте на вопросы.
- Какому тегу соответствует коммит 85024d3?
- Сколько родителей у коммита b8d720? Напишите их хеши.
- Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24.
- Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) (вместо троеточия перечислены аргументы).
- Найдите все коммиты, в которых была изменена функция globalPluginDirs.
- Кто автор функции synchronizedWriters?

В качестве решения ответьте на вопросы и опишите, как были получены эти ответы.

# Решение

1. Выполняем `git show aefea` получаем вывод:
```
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md
```
Полный хэш: `aefead2207ef7e2aa5dc81a34aedf0cad4c32545`
Комментарий: `Update CHANGELOG.md`

2. Ответы:
- Тегу `v0.12.23`
    Узнаем с помощью команды `git show -s --format=%d 85024d3`

- Два родителя (merge commit). Хеш 1: `56cd7859e0` и хеш 2: `9ea88f22fc`
    Узнаем с помощью команды `git show -s --format=%p b8d720`

- Выполняем `git log v0.12.23..v0.12.24 --format="%h %s"`
    ```
    33ff1c03bb v0.12.24
    b14b74c493 [Website] vmc provider links
    3f235065b9 Update CHANGELOG.md
    6ae64e247b registry: Fix panic when server is unreachable
    5c619ca1ba website: Remove links to the getting started guide's old location
    06275647e2 Update CHANGELOG.md
    d5f9411f51 command: Fix bug when using terraform login on Windows
    4b6d06cc5d Update CHANGELOG.md
    dd01a35078 Update CHANGELOG.md
    225466bc3e Cleanup after v0.12.23 release
```

- Выполняем `git log -S 'func providerSource' --format='%h' | tail -n 1` и получаем коммит `8c928e8358`

- Сначала выполняем `git grep "func GlobalPluginDirs"`, получаем `internal/command/cliconfig/plugins.go:func GlobalPluginDirs() []string {`, тем самым определяем файл, где находится функция, затем выполняем `git log -L :GlobalPluginDirs:internal/command/cliconfig/plugins.go -s --format="%h %ad" --date=short` и получаем список коммитов
    ```
    7c4aeac5f3 2024-11-05
    78b1220558 2020-01-13
    52dbf94834 2017-08-09
    41ab0aef7a 2017-08-09
    66ebff90cd 2017-05-03
    8364383c35 2017-04-13
    ```
- Выполнем `git log -S "synchronizedWriters" --format="%an" | tail -n 1` получаем автора `Martin Atkins`