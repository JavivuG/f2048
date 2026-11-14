# f2048 — movimiento del 2048 en ensamblador MIPS

Subrutina en ensamblador MIPS que aplica un movimiento del juego 2048 sobre un tablero de 4x4: desplaza las fichas y suma las que son iguales.

> Trabajo de la asignatura **Fundamentos de Computadores** · Grado en Ingeniería Informática · Universidad de Valladolid · Curso 2021-2022

## Qué hace

- Recibe en `$a0` la dirección de la matriz de 4x4 y en `$a1` el código ASCII de la tecla pulsada.
- Acepta `W`/`w` (arriba), `A`/`a` (izquierda), `S`/`s` (abajo) y `D`/`d` (derecha).
- Para cada dirección desplaza las fichas, suma las parejas iguales adyacentes y vuelve a desplazar para cerrar los huecos.
- Devuelve `0` en `$v0` si el movimiento es válido y `1` si la tecla no corresponde a ningún movimiento.

## Tecnologías

- Ensamblador MIPS.

## Aspectos técnicos destacados

- **Convenio de llamada MIPS**: cada subrutina reserva espacio en la pila y guarda los registros `$s` que usa y `$ra` antes de llamar a otras.
- **Descomposición en subrutinas**: `MoverDerecha`, `MoverIzquierda`, `MoverArriba`, `MoverAbajo` y `SumaDerecha`, `SumaIzquierda`, `SumaArriba`, `SumaAbajo`, combinadas como mover, sumar y mover.
- **Acceso a la matriz encapsulado**: todas las lecturas y escrituras pasan por `LeeAij` y `EscAij` (dirección, fila, columna y valor).

## Estructura del repositorio

```text
f2048/
└── f2048.asm   # Subrutina f2048 y sus subrutinas auxiliares
```

## Requisitos

- Un simulador MIPS (por ejemplo, MARS); el repositorio no indica cuál se usó.
- El resto del programa del juego: el repositorio solo contiene `f2048`. Las subrutinas `LeeAij` y `EscAij` y el programa principal que muestra el tablero y lee las teclas no están incluidos.

## Cómo ejecutar

Sin verificar. `f2048.asm` no se puede ensamblar solo, porque llama a `LeeAij` y `EscAij`, que no están en el repositorio. Para probarlo, ensámblalo junto al programa principal y a esas subrutinas en el simulador y llama a `f2048` con `$a0` apuntando a la matriz y `$a1` con la tecla.

El fichero está codificado en ISO-8859-1, así que algunos acentos de los comentarios pueden verse mal en editores configurados en UTF-8.

## Autoría

Javier García (JavivuG), único autor de los commits del repositorio.

---

Forma parte de [UVa-Projects](https://github.com/JavivuG/UVa-Projects).
