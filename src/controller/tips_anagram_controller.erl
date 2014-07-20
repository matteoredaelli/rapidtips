-module(tips_anagram_controller, [Req]).
-compile(export_all).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

index('GET', []) ->
    %%{ok, []}.
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, "anagram,permutation"}]};
   
index('POST', []) ->
    %%Word = Req:param("word"),
    Word = Req:post_param("word"),
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, "anagram,permutation"}, {words, perms(Word)}]}.
