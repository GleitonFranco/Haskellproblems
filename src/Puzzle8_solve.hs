import Data.List
import qualified Data.Set as Set


-- Definição Conceitual
type Combinacao = String
data Tela = Tela { getPai :: Maybe Tela , getCombinacao :: Combinacao }
type Jogo = [Tela]

instance Eq Tela where
  t1 == t2 = (getCombinacao t1) == (getCombinacao t2)
instance Ord Tela where
  (Tela _ c1) `compare` (Tela _ c2) = c1 `compare` c2


-- Funções para movimentos das peças
trocaCombinacao p1 p2 combinacao = 
  let
    n1 = min p1 p2
    n2 = max p1 p2
    (inicio1,ch1:fim1) = splitAt n1 combinacao
    (inicio2,ch2:fim2) = splitAt n2 combinacao
    meio = intersect fim1 inicio2
  in
    inicio1 ++ ch2:meio ++ ch1:fim2

troca p1 p2 tela = Tela { getPai = (Just tela),  getCombinacao = trocaCombinacao p1 p2 $ getCombinacao tela }

move tela = case getCombinacao tela of
    (' ':xs) -> [troca 0 1 tela, troca 0 3 tela]
    (_:' ':xs) -> [troca 1 0 tela, troca 1 4 tela, troca 1 2 tela]
    (_:_:' ':xs) -> [troca 2 5 tela, troca 2 1 tela]
    (_:_:_:' ':xs) -> [troca 3 0 tela, troca 3 4 tela, troca 3 6 tela]
    (_:_:_:_:' ':xs) -> [troca 4 3 tela, troca 4 1 tela, troca 4 5 tela, troca 4 7 tela]
    (_:_:_:_:_:' ':xs) -> [troca 5 2 tela, troca 5 4 tela, troca 5 8 tela]
    (_:_:_:_:_:_:' ':xs) -> [troca 6 3 tela, troca 6 7 tela]
    (_:_:_:_:_:_:_:' ':xs) -> [troca 7 6 tela, troca 7 4 tela, troca 7 8 tela]
    (_:_:_:_:_:_:_:_:' ':xs) -> [troca 8 5 tela, troca 8 7 tela]
    _ -> [Tela Nothing ""]

multiplica ts = foldr (\t acc -> acc ++ (move t)) [] ts


-- Funções para a Resolução do Problema
combinacaoSolucao =  "12345678 "
resolve (tset,ts) =
  let
    solucoes = filter (\t -> (getCombinacao t) == combinacaoSolucao) ts
  in
    if
      length solucoes > 0
    then
      (tset, [head solucoes])
    else
      let
        tset2 = Set.fromList $ multiplica ts
      in
        resolve (Set.union tset tset2 , Set.toList $ Set.difference tset2 tset)

listaHistorico (Tela Nothing combinacao) = combinacao:[]
listaHistorico (Tela (Just tela) combinacao) = combinacao:(listaHistorico tela)


-- Funções de Impressão
grupo3 :: [a] -> [[a]]
grupo3 [] = []
grupo3 (x:y:z:xs) = [x:y:z:[]] ++ grupo3 xs

printCombinacao combinacao = mapM_ (putStrLn . ('|':) . (++"|\n+-+-+-+") . intersperse '|' ) $ "":(grupo3 combinacao)
printTela tela = printCombinacao $ getCombinacao tela
printHistorico cs = mapM_ printCombinacao cs


-- Função Principal
puzzle8 combinacao0 =
  let telaProblema = Tela Nothing combinacao0
  in printHistorico $ reverse $ listaHistorico $ head $ snd $ resolve (Set.singleton telaProblema, [telaProblema])

main = do
  putStrLn "Puzzle 8 Resolução"
  putStrLn "=================="
  putStrLn "Digite o problema na forma de String com números de 1-8 e um espaço"
  putStrLn "Ex: puzzle8 \"12 345678\""