C-Like language parser written using flex/bison
```
    13 |for( int a = 2 a < 3; a = a + 3) // Неверная запись цикла for()
...... !...............^
Error: syntax error, unexpected ID, expecting ';' at line 13
                                                                      
    13 |for( int a = 2 a < 3; a = a + 3) // Неверная запись цикла for()
...... !................................^
Error: syntax error, unexpected ')', expecting ';' at line 13
                                                                      
    20 |            qwe === 2; // Неверная запись оператора присваивания
...... !..................^
Error: syntax error, unexpected ASSIGN at line 20
                                                                      
    27 |for(;;); // Многострочная ошибка
...... !^^^
Error: syntax error, unexpected FOR, expecting ';' at line 27
                                                                      
    29 |bool bool; // Неверное объявление переменной
...... !.....^^^^
Error: syntax error, unexpected BOOL, expecting ID at line 29
                                                                      
    34 |    b = b ** 2; // Неверное арифметическое выражение
...... !...........^
Error: syntax error, unexpected '*' at line 34
                                                                      
    51 |return (print("OK"); // Неверная последовательность открывающих и закрывающих скобок
...... !...................^
Error: syntax error, unexpected ';', expecting ')' at line 51
```