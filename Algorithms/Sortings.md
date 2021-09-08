# Сортировки

### Сортировка вставками

Инвариант - поле i-го шага отсортирован префикс [0, i]



```pseudocode
for i=0..n-1:
	j = i
	while j > 0 && a[j] < a[j - 1]:
		swap(a[j], a[j - 1])
		j--
```

Время работы: $n^2$

### Сортировка слиянием (Merge Sort)

> Разделяй и властвуй!

Делим напоплоам, потом делаем merge? Далее - рекурсивно.





### Мастер теорема

Если 
$$
T(n) \leq b\times T \left( \frac{n}{a} \right) + n^c
$$

$$
T(n) = \begin{cases}
n^{log_a b}, c < log_a b \\
n^c, c > log_a b \\
n^c \times {\log n}, c = 
\end{cases}
$$
