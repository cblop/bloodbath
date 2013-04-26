%% Do not edit, this file has been generated
%% automatically by report.tex via gmp.sty

verbatimtex%&latex
\documentclass[11pt]{article}


\begin{document}
etex;

input metauml;
outputtemplate:= "%j.mps";
beginfig(5);
 Begin.b;
 State.rest("Rest")();
 State.walk("Walk")();
 State.punch("Punch")();
 State.kick("Kick")();
 State.crouch("Crouch")();
 State.jump("Jump")();
 State.lose("Lose")();
 State.win("Win")();
 End.e;
 

leftToRight(30)(b, rest);
 leftToRight(30)(rest, walk);
 leftToRight(30)(crouch, lose);
 topToBottom(20)(lose, win);
 leftToRight(30)(win, e);
 topToBottom(20)(walk,punch,kick,crouch,jump);
 
drawObject(b);
 drawObjects(rest,walk,punch,kick,crouch,jump,lose,win);
 drawObject(e);
 
clink(transition)(b,rest);
 clink(transition)(rest,walk);
 clink(transition)(walk,rest);
 clink(transition)(rest,punch);
 clink(transition)(punch,rest);
 clink(transition)(rest,kick);
 clink(transition)(kick,rest);
 clink(transition)(rest,crouch);
 clink(transition)(crouch,rest);
 clink(transition)(rest,jump);
 clink(transition)(jump,rest);
 clink(transition)(rest,lose);
 clink(transition)(punch,win);
 clink(transition)(kick,win);
 clink(transition)(jump,lose);
 clink(transition)(crouch,lose);
 clink(transition)(walk,lose);
 clink(transition)(punch,lose);
 clink(transition)(kick,lose);
 clink(transition)(lose,e);
 clink(transition)(win,e);
 

endfig;
end.
verbatimtex
\end{document}
etex
