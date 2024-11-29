#!/bin/bash

echo "Введите ваше имя:"
read name
echo "Введите ваш возраст:"
read age

echo "Привет, $name! Через год тебе будет $((age + 1)) лет."
