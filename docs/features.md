# Основные возможности и особенности

Основные особенности пакета:
- использования фреймворка unittest для создания тестов (есть поддержка параметризации с помощью subTests)
- возможность добавления дополнительных проверок (проверка названия файла с решением, проверка возможности импортировать файл решения, как python модуль)
- настройка уровня детализации в сообщениях об ошибке (трейсбек, дополнительное сообщение к упавшему тесту, перечисление всех пройденных тестов)
- совместимость с новым API Coursera
- возможность получать решение в виде zip архива
- возможность устанавливать порог прохождения тестов 
- возможность отправки в качестве решения части кода 
- возможность скопировать содержимое файла с решением в любой файл внутри сабгрейдера
- возможность объединения нескольких сабгрейдеров в одном грейдере
- возможности для кастомизации и расширения функционала 