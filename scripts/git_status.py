#!/usr/bin/env python3
import os
import sys
# Настроим путь
path = os.getcwd()+"\\"
if len(sys.argv) >= 2:
    path = sys.argv[1]
# Проверим существует ли папка .git
if not os.path.exists(path + "/.git"):
    print("Ошибка: " + path + " не является GIT деррикторией")
    exit(1)
bash_command = ["cd " + path, "git status"]  # путь заменен на переменную
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(path + prepare_result.replace("/", "\\"))