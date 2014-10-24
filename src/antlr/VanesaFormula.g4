/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar VanesaFormula;

PLUS   : '+' ;
MINUS  : '-' ;
MULT   : '*' ;
DIV    : '/' ;
POW    : '^' ;
LODASH : '_' ;
LPAREN : '(' ;
RPAREN : ')' ;

/*------------------------------------------------------------------
 * PARSER RULES
 *------------------------------------------------------------------*/

expr				: term ;

term				: LPAREN term RPAREN
					| atom
					// function MULTIPLE ARGUMENTS??
					| function LPAREN term ( ',' term )* RPAREN
               | term operator=( POW | MULT | DIV ) term
					| term operator=( PLUS | MINUS ) term
					;

atom           : number
               | neg_number
               | variable
               | neg_variable
               ;           

number			: NUMBER ;

neg_number		: LPAREN MINUS number RPAREN ;

variable			: VARIABLE ( LODASH VARIABLE )*;

neg_variable	: LPAREN MINUS variable RPAREN ;

function       : VARIABLE ;
 
/*------------------------------------------------------------------
 * LEXER RULES
 *------------------------------------------------------------------*/
 
NUMBER   : ( DIGIT )+ ( ( '.' | ',' ) ( DIGIT )+ )? ;

VARIABLE : ( CHAR )+ ;

WS       : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
 
DIGIT    : [0-9] ;

CHAR     : [a-zA-Z0-9] ;