C-Like language parser written using flex/bison
```
     7 |char test(char, float c); // Неверное объявление параметров функции
...... !...............^
Error: syntax error, unexpected ',', expecting ID at line 7
                                                                      
    15 |for( int a = 2 a < 3; a = a + 3) // Неверная запись цикла for()
...... !...............^
Error: syntax error, unexpected ID, expecting ';' at line 15
                                                                      
    15 |for( int a = 2 a < 3; a = a + 3) // Неверная запись цикла for()
...... !................................^
Error: syntax error, unexpected ')', expecting ';' at line 15
                                                                      
    22 |            qwe === 2; // Неверная запись оператора присваивания
...... !..................^
Error: syntax error, unexpected ASSIGN at line 22
                                                                      
    29 |for(;;); // Многострочная ошибка
...... !^^^
Error: syntax error, unexpected FOR, expecting ';' at line 29
                                                                      
    31 |bool bool; // Неверное объявление переменной
...... !.....^^^^
Error: syntax error, unexpected BOOL, expecting ID at line 31
                                                                      
    36 |    b = b ** 2; // Неверное арифметическое выражение
...... !...........^
Error: syntax error, unexpected '*' at line 36
                                                                      
    53 |return (print("OK"); // Неверная последовательность открывающих и закрывающих скобок
...... !...................^
Error: syntax error, unexpected ';', expecting ')' at line 53
```