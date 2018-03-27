# Haskellproblems
Solução de problemas com abordagem funcional.</br>

Cada arquivo é um módulo para a resolução de um problema específico.</br>


Problema do Puzzle-8:
=====================
Resolução de um quadro de 9 casas com peças numeradas de 1 a 8, e um espaço vazio. O objetivo é reorganizar o quadro deslizando as peças até ficarem ordenadas.</br>

<table>
  <tr><td>+-+-+-+</td><td>+-+-+-+</td></tr>
  <tr><td>+-+-+-+</td><td>+-+-+-+</td></tr>
  <tr><td>+-+-+-+</td><td>+-+-+-+</td></tr>
</table>


+-+-+-+                              +-+-+-+</br>
|1|2| |                              |1|2|3|</br>
+-+-+-+                              +-+-+-+</br>
|3|4|5|     ----------------->       |4|5|6|</br>
+-+-+-+                              +-+-+-+</br>
|6|7|8|                              |7|8| |</br>
+-+-+-+                              +-+-+-+</br>


Passos Iniciais:
================
1 - Colocar o conteúdo de um arquivo em um compilador local ou online, como em: https://repl.it/languages/haskell;</br>
2 - Executar o módulo;</br>
3 - na linha de comando executar o comando seguido de uma String com o problema a ser resolvido, ex:
> puzzle8 "12 345678"

