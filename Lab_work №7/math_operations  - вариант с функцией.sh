#!/bin/bash

# Функция сложения
add() {
    echo "Результат сложения: $(($1 + $2))"
}

# Функция вычитания
subtract() {
    echo "Результат вычитания: $(($1 - $2))"
}

# Функция умножения
multiply() {
    echo "Результат умножения: $(($1 * $2))"
}

# Функция деления
divide() {
    if [ "$2" -eq 0 ]; then
        echo "Ошибка: деление на ноль невозможно!"
    else
        echo "Результат деления: $(($1 / $2))"
    fi
}

# Запрос чисел
echo "Введите первое число:"
read num1
if ! [[ "$num1" =~ ^-?[0-9]+$ ]]; then # проверочка
    echo "Ошибка: Введите корректное число!"
    exit 1
fi

echo "Введите второе число:"
read num2
if ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then # проверочка
    echo "Ошибка: Введите корректное число!"
    exit 1
fi

# Запрос операции
echo "Выберите операцию (add, subtract, multiply, divide):"
read operation

# Выполнение операции
case "$operation" in
    add)
        add "$num1" "$num2"
        ;;
    subtract)
        subtract "$num1" "$num2"
        ;;
    multiply)
        multiply "$num1" "$num2"
        ;;
    divide)
        divide "$num1" "$num2"
        ;;
    *)
        echo "Ошибка: Неизвестная операция '$operation'. Пожалуйста, выберите add, subtract, multiply или divide."
        exit 1
        ;;
esac
