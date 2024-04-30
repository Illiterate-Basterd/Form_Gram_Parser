###C-Like language parser written using flex/bison

Compile using Makefile

Current output on ```./Parser Test.mlng```:
```
     5 |int a = b = c = "str" = d; // Неверное использование оператора присваивания
...... !......................^
Error: syntax error, unexpected ASSIGN, expecting ';' at line 5
                                                                      
     9 |char test(char , float c); // Неверное объявление параметров функции
...... !...............^
Error: syntax error, unexpected ',', expecting ID at line 9
                                                                      
    17 |for( int a = 2 a < 3; a = a + 3 ) // Неверная запись цикла for()
...... !...............^
Error: syntax error, unexpected ID, expecting ';' at line 17
                                                                      
    17 |for( int a = 2 a < 3; a = a + 3 ) // Неверная запись цикла for()
...... !................................^
Error: syntax error, unexpected ')', expecting ';' at line 17
                                                                      
    24 |            qwe === 2; // Неверная запись оператора присваивания
...... !..................^
Error: syntax error, unexpected ASSIGN at line 24
                                                                      
    31 |for(;;); // Многострочная ошибка
...... !^^^
Error: syntax error, unexpected FOR, expecting ';' at line 31
                                                                      
    33 |bool bool; // Неверное объявление переменной
...... !.....^^^^
Error: syntax error, unexpected BOOL, expecting ID at line 33
                                                                      
    38 |    b = b ** 2; // Неверное арифметическое выражение
...... !...........^
Error: syntax error, unexpected '*' at line 38
                                                                      
    55 |return (print("OK"); // Неверная последовательность открывающих и закрывающих скобок
...... !...................^
Error: syntax error, unexpected ';', expecting ')' at line 55
```