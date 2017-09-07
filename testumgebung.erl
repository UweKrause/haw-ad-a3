-module(testumgebung).

-author("Sean Pedersen").
-author("Uwe Krause").

%TODO: Debug export_all entfernen
-compile(export_all).



% X random Zahlen in einen AVL Baum einfügen

% Messe Laufzeit von insertBT/2 und deleteBT/2
messen(Anzahl) ->

    Baum = {},

    RandList = util:randomliste(Anzahl),
    Prozentwert = round(Anzahl * (1 - 0.42)),
    DelList = lists:nthtail(Prozentwert, RandList),

    
    
    io:format("Listen erstellt~n", []),

    
    {InsBaum, EinfTime} = einfuegen(Baum, RandList),
    {DelBaum, EntfTime} = entfernen(InsBaum, DelList),

    
    

    
    avltree:printBT(InsBaum, "gross.dot"),
    avltree:printBT(DelBaum, "klein.dot"),
    %io:format("Laufzeit insertBT: ~p Sekunden~n", [(EinfTime/1000000)]),
    %io:format("Laufzeit deleteBT: ~p Sekunden~n", [(EntfTime/1000000)]),
    io:format("Laufzeit insertBT: ~p Mikrosekunden~n", [(EinfTime)]),
    io:format("Laufzeit deleteBT: ~p Mikrosekunden~n", [(EntfTime)]),

    {avltree:isBT(InsBaum), avltree:isBT(DelBaum)}.



einfuegen(B, List) -> ein_reku(B, List, 0).
ein_reku(B, [], Time) -> {B, Time};
ein_reku(Baum, [H|T], Time) -> {MesTime, ResultTree} = timer:tc(avltree, insertBT, [Baum, H]), ein_reku(ResultTree, T, Time+MesTime).

entfernen(B, List) -> raus_reku(B, List, 0).
raus_reku(B, [], Time) -> {B, Time};
raus_reku(Baum, [H|T], Time) -> {MesTime, ResultTree} = timer:tc(avltree, deleteBT, [Baum, H]), raus_reku(ResultTree, T, Time+MesTime).
