-module(tips_anagram_controller, [Req]).
-compile(export_all).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

word('GET', []) ->
    %%{ok, []}.
    {ok, []};
   
word('POST', []) ->
    %%Word = Req:param("word"),
    Word = Req:post_param("word"),
    {ok, [{title, "Anagram"}, {words, perms(Word)}]}.
