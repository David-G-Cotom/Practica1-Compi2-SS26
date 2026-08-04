grammar Latinus;

// GRAMMAR
inicio: declaraciones_globales funcion_main;

declaraciones_globales: VARIABILES MAYOR;

funcion_main: MAIOR;

// LEXER
SUMA: '+';
RESTA: '-';
MULTIPLICACION: '*';
DIVIVISION: '/';

IGUALDAD: '==';
NO_IGUAL: '!=';
MAYOR: '>';
MENOR: '<';

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

PARGE: 'parge';
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

ESPACIO: [ \n\t\r]+ -> skip;
