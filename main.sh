#!/bin/bash
generate_number() {
  num=()
  for i in {0..9}; do
    num+=($i)
  done
  for i in {0..3}; do
    index=$(( $RANDOM % ${#num[@]} ))
    number+=${num[$index]}
    unset 'num[$index]'
  done
}
check_number() {
  guess=$1
  bulls=0
  cows=0
  for (( i=0; i<4; i++ )); do
    if [[ ${guess:i:1} -eq ${number:i:1} ]]; then
      (( bulls++ ))
    elif [[ ${number[@]} =~ ${guess:i:1} ]]; then
      (( cows++ ))
    fi
  done
  echo "Быки: $bulls, Коровы: $cows"
}
generate_number
echo "Запускается игра Быки и Коровы"
echo "Введите 4-значное с попарно различными цифрами:"
while true; do
  read -s guess
  if [[ $guess =~ ^[0-9]{4}$ ]]; then
    check_number $guess
    if [[ $bulls -eq 4 ]]; then
      echo "Вы угадали число!"
      break
    else
      echo "Попробуйте еще раз:"
    fi
  fi
done