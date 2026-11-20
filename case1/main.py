"""Кейс-задача № 1. Дан одномерный массив А размерности N. 
Найти сумму отрицательных элементов, расположенных между максимальным и минимальным."""

M = [7, -5, 8, -34, -9, 5, 21, 13]

max_num = max(M)
min_num = min(M)

max_ind = M.index(max_num)
min_ind = M.index(min_num)

left = min(max_ind, min_ind)
right = max(max_ind, min_ind)

total = 0

for i in range(left + 1, right):
    if M[i] < 0:
        total += M[i]

print("Массив:", M)
print("Максимум:", max_num, "на позиции:", max_ind)
print("Минимум:", min_num, "на позиции:", min_ind)
print("сумма отрицательных между ними", total)
