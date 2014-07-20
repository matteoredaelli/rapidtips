-module(tips_home_controller, [Req]).
-compile(export_all).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

index('GET', []) ->
    {ok, [{title, "Home"},
	  {description, "Opensource tools"}, 
	  {keywords, "opensource,tools,anagram"}]}.
