module Ejercicios where
  import Data.Char (ord)

-- Escribir una función numCbetw2 que devuelva cuatos caracteres hay entre dos caracteres dados (sin incluirlos).
-- No es necesario utilizar recursividad para resolverlo, se debe utilizar la función ord

  numCbetw2 :: Char -> Char -> Int
  numCbetw2 x y
    | x == y = 0
    | ord x > ord y = ord x - ord y - 1
    | otherwise = ord y - ord x - 1

-- Escribir una funcion recursiva, addRange, que devuelva el sumatorio desde un valor entero hasta otro (incluyendo ambos).
-- En este caso no se puede utilizar el ajuste de patrones para especificar el caso base, hay que utlizar if

  addRange :: Int -> Int -> Int
  addRange x y = if x < y then x + addRange (succ x) y else if x > y then y + addRange (succ y) x else x

-- Escribir una funcion max', que devuelva el mayor de sus dos argumentos enteros

  max' :: Int -> Int -> Int
  max' x y = if x >= y then x else y

-- Escribir una funcion leapyear que diga si un año es bisiesto o no lo es, para hacerlo debes saber que los años bisiestos son multiplo de 4
-- Pero atencion los multiplos de 100 no son bisiestos pero los multiplos de 400 si

  leapyear :: Int -> Bool
  leapyear x
    | x `mod` 4 == 0 = True
    | x `mod` 100 == 0 = if x `mod` 400 == 0 then True else False

-- Escribir una funcion daysAmonth que calcule el numero de dias de un mes (Se debe usar el leapyear y el selector multiple)

  daysAmonth :: Int -> Int -> Int
  daysAmonth month year
    | leapyear year = 29
    | month == 4 || month == 6 || month == 9 || month == 11 = 30
    | otherwise = 31
