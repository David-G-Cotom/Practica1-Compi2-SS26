grammar Latinus;

// GRAMMAR
inicio: seccion_declaraciones? seccion_funciones? funcion_main FINIS_UPPER PUNTO_COMA;

seccion_declaraciones: VARIABILES MAYOR declaraciones_globales
                        | VARIABILES CORCHETE_ABIERTO declaraciones_globales CORCHETE_CERRADO;

seccion_funciones: MUNERA declaraciones_funciones;

declaraciones_funciones: declaraciones_funciones funcion
                        | funcion;

funcion: ACTIO ID PARENTESIS_ABIERTO lista_parametros? PARENTESIS_CERRADO LLAVE_ABIERTO contenido_funcion LLAVE_CERRADO FINIS_LOWER PUNTO_COMA
        | RATIO tipo_dato ID PARENTESIS_ABIERTO lista_parametros? PARENTESIS_CERRADO LLAVE_ABIERTO contenido_funcion LLAVE_CERRADO FINIS_LOWER PUNTO_COMA;

lista_parametros: lista_parametros COMA parametro
                | parametro;

parametro: ESTO ID DOS_PUNTOS tipo_dato;

contenido_funcion: seccion_declaraciones? bloque_codigo;

bloque_codigo: bloque_codigo instruccion
                | instruccion;

instruccion: SI sentencia_if
            | sentencia_while
            | sentencia_for
            | asignacion
            | transferencia;

transferencia: PERGE PUNTO_COMA
                | INTERRUMPE PUNTO_COMA
                | REDDERE PUNTO_COMA
                | REDDERE expr PUNTO_COMA;

asignacion: ID IGUAL expr PUNTO_COMA
            | ID CORCHETE_ABIERTO expr CORCHETE_CERRADO IGUAL expr PUNTO_COMA;

sentencia_if: PARENTESIS_ABIERTO expr PARENTESIS_CERRADO LLAVE_ABIERTO bloque_codigo LLAVE_CERRADO fin_if;

fin_if: FINIS_LOWER PUNTO_COMA
        | ALITER continuar_else;

continuar_else: sentencia_if
                | LLAVE_ABIERTO bloque_codigo LLAVE_CERRADO FINIS_LOWER PUNTO_COMA;

sentencia_while: DUM PARENTESIS_ABIERTO expr PARENTESIS_CERRADO LLAVE_ABIERTO bloque_codigo LLAVE_CERRADO FINIS_LOWER PUNTO_COMA
                | FACERE LLAVE_ABIERTO bloque_codigo LLAVE_CERRADO DUM PARENTESIS_ABIERTO expr PARENTESIS_CERRADO PUNTO_COMA;

sentencia_for: PER PARENTESIS_ABIERTO variable expr PUNTO_COMA inc_dec PARENTESIS_CERRADO LLAVE_ABIERTO bloque_codigo LLAVE_CERRADO;

inc_dec: ID INCREMENTO
        | ID DECREMENTO;

declaraciones_globales: declaraciones_globales declaracion
                        | declaracion;

declaracion: variable
            | arreglo
            | estructura;

variable: ESTO ID DOS_PUNTOS tipo_dato expr? PUNTO_COMA;

tipo_dato: NUMERUS | TEXTUM | DECIMALIS | LITTERA | VERUM | FALSUS | ID;

arreglo: SERIES ID (CORCHETE_ABIERTO expr CORCHETE_CERRADO)? DOS_PUNTOS tipo_dato expr? PUNTO_COMA;

estructura: STRUCTURA ID LLAVE_ABIERTO lista_campo_estructura LLAVE_CERRADO FINIS_LOWER PUNTO_COMA;

lista_campo_estructura: lista_campo_estructura campo_estructura
                        | campo_estructura;

campo_estructura: variable | arreglo;

funcion_main: MAIOR bloque_main;

bloque_main: bloque_main contenido_main
                | contenido_main;

contenido_main: bloque_codigo
            | funcion_especial;

funcion_especial: funcion_leer
                | funcion_imprimir PUNTO_COMA;

funcion_leer: LEER expr
            | ID LEER expr;

funcion_imprimir: funcion_imprimir IMPRIMIR contenido_imprimir
                | IMPRIMIR contenido_imprimir;

contenido_imprimir: ID | expr;

expr: expr OR expr
    | expr_and;

expr_and: expr_and AND expr_and
        | expr_not;

expr_not: NOT expr_not
        | expr_rel;

expr_rel: expr_rel IGUALDAD expr_rel
        | expr_rel NO_IGUAL expr_rel
        | expr_rel MENOR expr_rel
        | expr_rel MENOR_IGUAL expr_rel
        | expr_rel MAYOR expr_rel
        | expr_rel MAYOR_IGUAL expr_rel
        | expr_add;

expr_add: expr_add SUMA expr_add
        | expr_add RESTA expr_add
        | expr_mul;

expr_mul: expr_mul MULTIPLICACION expr_mul
        | expr_mul DIVISION expr_mul
        | expr_primary;

expr_primary: DECIMAL
            | ENTERO
            | TEXTO
            | CARACTER
            | LLAVE_ABIERTO lista_valores_arreglo LLAVE_CERRADO;

lista_valores_arreglo: lista_valores_arreglo COMA expr
                    | expr;

// LEXER
SUMA: '+';
RESTA: '-';
MULTIPLICACION: '*';
DIVISION: '/';

IGUALDAD: '==';
NO_IGUAL: '!=';
MAYOR: '>';
MENOR: '<';
MENOR_IGUAL: '<=';
MAYOR_IGUAL: '>=';

AND: '&&';
OR: '||';
NOT: 'non';

INCREMENTO: '++';
DECREMENTO: '--';

DOS_PUNTOS: ':';
PUNTO_COMA: ';';
COMA: ',';
PUNTO: '.';
IGUAL: '=';

CORCHETE_ABIERTO: '[';
CORCHETE_CERRADO: ']';
LLAVE_ABIERTO: '{';
LLAVE_CERRADO: '}';
PARENTESIS_ABIERTO: '(';
PARENTESIS_CERRADO: ')';

LEER: '<<';
IMPRIMIR: '>>';

ESTO: 'esto';
NUMERUS: 'numerus';
TEXTUM: 'textum';
DECIMALIS: 'decimalis';
LITTERA: 'littera';
VERUM: 'verum';
FALSUS: 'falsus';

SERIES: 'series';
STRUCTURA: 'structura';
FINIS_LOWER: 'finis';

SI: 'si';
ALITER: 'aliter';
DUM: 'dum';
FACERE: 'facere';
PER: 'per';

PERGE: 'perge';
INTERRUMPE: 'interrumpe';

ACTIO: 'actio';
VARIABILES: 'VARIABILES';
RATIO: 'ratio';
REDDERE: 'reddere';

MUNERA: 'MUNERA>';
MAIOR: 'MAIOR>';
FINIS_UPPER: 'FINIS';

ENTERO: '0' | ([1-9][0-9]*);
DECIMAL: ENTERO PUNTO [0-9]+;
LETRA: [a-zA-Z];
ID: '_'? LETRA (LETRA|'_'|ENTERO)*;
TEXTO: '"' [^\r\n]+ '"';
CARACTER: '\'' [^\r\n'\\] '\'';

COMMENTARIO_SIMPLE: '//'[^\r\n]+ -> skip;
COMMENTARIO_MULTIPLE: '##'.*?'##' -> skip;
ESPACIO: [ \n\t\r]+ -> skip;
