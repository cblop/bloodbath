%% Do not edit, this file has been generated
%% automatically by report.tex via gmp.sty

verbatimtex%&latex
\documentclass[11pt]{article}


\begin{document}
etex;

input metauml;
outputtemplate:= "%j.mps";
beginfig(1);
 Class.A("Player") ("+name:string","+number:int","+x:int","+y:int","+anims:animation[]","+keymap:string[]","+direction:string","+status:string","+anim:string","+sizex:int","+sizey:int","+health:int","+lock:boolean","+timer:int") ("+new(name:string, anims:animation[], keymap:string[]):void","+getHit(height:int,attack:string):void","+takeDamage(amount:int):void","+keyevent(key:string):boolean","+animate(action:string):void","+resetAnim(action:string):void","+render():void","+move(x:int, y:int):void","+flip():void","+die():void","+celebrate():void","+update(dt:float):void","+keyreleased(key:string,unicode:string):void");
 
Class.B("Fight") ("+player1:Player","+player2:Player","+messages:Message[]") ("+new(player1:Player, player2:Player, messages(Message[])):void","+applyDamage():void", "+victory(winplayer:Player):void", "+update(dt:float):void");
 
Class.C("StatusBar") ("+player:Player","+value:int","+font:Font") ("+new(player:Player):void","+draw():void");
 
Class.D("Messages") ("+message:string","+size:int","+color:int[]","+font:Font","+x:int","+y:int") ("+new():void","+announceWinner(winner:string)","+show():void");
 
Class.E("Game") ("+background:Image", "+menuoptions:Player[]", "+players:Player[]", "+statusBars:StatusBar[]", "+keymap:Keymap[]", "+fight:Fight", "+font:Font", "+fighting:boolean", "+menuSelected:int[]") ("+new(keymaps:Keymap[],allPlayers:Player[]):void","+keypressed(key:string):void","+startFight():void","+showMenu():void","+update(dt:float):void","+draw():void");
 
topToBottom(10)(C, D);
 topToBottom(10)(D, E);
 topToBottom(10)(B, A);
 leftToRight(10)(A, D);
 drawObjects(A,B,C,D,E);
 
endfig;
end.
verbatimtex
\end{document}
etex
