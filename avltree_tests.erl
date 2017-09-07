-module(avltree_tests).

-include_lib("eunit/include/eunit.hrl").

-author("Sean Pedersen").
-author("Uwe Krause").



% Unit testing
% Aufruf ueber die Konsole:
% (1) Modul Kompilieren 		c(avltree)
% (2) Testmodul kompilieren		c(avltree_tests)
% (3) Aufruf der Testfaelle 	eunit:test(avltree,[verbose]).
% oder mit eunit:test(avltree)


% Generiert die eigentlichen Testfunktionen intern
add_test_() ->
	[test_avltree_initBT(),
	%test_avltree_isEmptyBT(),
	%test_avltree_equalBT(),
	%test_avltree_isBT(),
	test_avltree_insertBT(),
	test_avltree_deleteBT(),
	test_avltree_rot_li(),
	test_avltree_rot_re(),
	test_avltree_get_balance(),
	test_avltree_reorg_rot_re()
	].



% VORLAGE zur Generierung von Tests
% (Aus dieser Liste von Makros werden letztlich die Tests generiert)
% Liste der verfuegbaren Makros
% http://learnyousomeerlang.com/eunit#eunit-whats-a-eunit
test_avltree_initBT() ->
	[
	% leere Liste
	?_assertEqual({}, avltree:initBT())
	].

	
test_avltree_deleteBT() ->
	[
	% leere Liste
	?_assertEqual({}, avltree:deleteBT({}, 1)),
	?_assertEqual({}, avltree:deleteBT({1,{},{},1}, 1)),
	?_assertEqual({75,{},{100,{},{},1},2}, avltree:deleteBT({75,{50,{},{}, 1},{100,{},{},1},2}, 50)),
	?_assertEqual({75,{50,{},{},1},{},2}, avltree:deleteBT({75,{50,{},{}, 1},{100,{},{},1},2}, 100)),
	?_assertEqual({100,{50,{},{},1},{},2}, avltree:deleteBT({75,{50,{},{}, 1},{100,{},{},1},2}, 75))
	
	%,{},{},1
	
	].
	
	
%avltree:rot_li({33, {}, {44, {},{55,{},{},1}, 2},3}).
test_avltree_rot_li() ->
	[
	% leere Liste
	?_assertEqual(
            {44,{33,{},{},1},{55,{},{},1},2},
            avltree:rot_li({33, {}, {44, {},{55,{},{},1}, 2},3})
            )
	].
	
test_avltree_rot_re() ->
	[
	% leere Liste
	?_assertEqual(
            {44,{33,{},{},1},{55,{},{},1},2},
            avltree:rot_re({55, {44, {33,{},{},1}, {}, 2}, {} ,3})
            )
	].

test_avltree_reorg_rot_re() ->
        [
	?_assertEqual(
            {{25,{10,{},{},1},{50,{},{},1},2}, false},
            avltree:reorg_rot_re({50, {25, {10,{},{},1}, {}, 2}, {} ,3})
            )
	].
	
test_avltree_insertBT() ->
        [
	?_assertEqual({25,{10,{},{},1},{50,{},{},1},2},
            avltree:insertBT({50, {25, {}, {}, 1}, {} ,2}, 10)
            ), % rechtsrot
        ?_assertEqual({75,{50,{},{},1},{100,{},{},1},2},
        avltree:insertBT({50, {}, {75, {}, {}, 1}, 2}, 100)), % linksrot
        ?_assertEqual({10, {5,{3,{},{},1},{},2},{25,{15,{},{},1},{50,{},{},1},2},3},
            avltree:insertBT({25,{5,{3,{},{},1},{10,{},{},1},2},{50,{},{},1},3}, 15)), % dopp rot re
        ?_assertEqual({25,{7,{5,{3,{},{},1},{},2},{22,{21,{},{},1},{23,{},{},1},2},3},{50,{},{55,{},{},1},2},4},
            avltree:insertBT({25,{5,{3,{},{},1},{22,{7,{},{},1},{23,{},{},1},2},3},{50,{},{55,{},{},1},2},4},21)
            ) % dopp rot li
	].
	
test_avltree_get_balance() ->
[

?_assertEqual(-2,
avltree:get_balance({55, {44, {33,{},{},1}, {}, 2}, {} ,3})
),
?_assertEqual(-1, avltree:get_balance({55, {44, {33,{},{},1}, {}, 2}, {66,{},{},1} ,3})),
?_assertEqual(0, avltree:get_balance({55, {44, {33,{},{},1}, {}, 2}, {66, {58,{},{},1}, {}, 2} ,3})),
?_assertEqual(1, avltree:get_balance({55, {33,{},{},1}, {66, {58,{},{},1}, {}, 2},3})),
?_assertEqual(2, avltree:get_balance({55, {}, {66, {58,{},{},1}, {}, 2},3})),


?_assertEqual(-3, avltree:get_balance({55, {44, {33,{22,{},{},1},{},2}, {}, 3}, {} ,4}))
].