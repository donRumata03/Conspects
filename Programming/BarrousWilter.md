# Кодирование. Преобразование и обратное преоразование Борроуза $-$ Уилтера

 Для этой темы: 

​	Кодирование RLE Run Length Encoding

$$
a5'b3'a3'c4'b69
$$
Как записывать? 

1. Число. Можно сначала записать количество чисел в количестве чисел числа, потом количество чисел, потом само число.



> На бирже ставят сервера так, чтобы провода имели одинаковую длину.

Вложенный RLE:
$$
abcccabcccabccccc = (a'b'c3)3'c2
$$

### Ban Banana

Циклические сдвиги:

banbanana

anbananab

nbananaba

bananaban

ananabanb

nanabanba

anabanban

nabanbana

abanbanan

*banbanana*

______

Сортируем всё это.



1. anabanban

   abanbanan

   ananabanb

   anbananab

2. banbanana

   bananaban

3. nbananaba

   nabanbana

   nabanbana
   
   

Теперь, зная только 
n
n
b
b
a
n
a
a
a

и позицию,

Восстановим исходную строчку, сначала найдя первый столбец, потом получим первый столбец, далее - прыгаем туда-сюда, пометив даже одинаковые буквы номерами. 


Почему этот код хорош для кодирования языка?

Например, если есть частые диграфы или даже слова, одинаковые буквы и их послежовательности будут оказываться близко. Если есть частые диграфы "an", то будет часто так, что сдвиг такой: a|n => будут рядом находиться буквы a в конце при таких сдвигах.

Индекс клишированности с помощью эффективности архивации?)



Верно ли, что можно определять принадлежность книги писателю с помощью эффективности архивации книги с книгами одного писателя и другого. Исследования показывают, что корреляция есть, хотя и низкая.