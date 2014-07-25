-module(tips_tools_controller, [Req]).
-compile(export_all).

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANAGRAM
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
perms([]) -> [[]];
perms(L) -> [list_to_binary([H|T]) || H <- L, T <- perms(L--[H])].

anagram_keywords() ->
    <<"anagram,permutation,anagramma,anagramm,anagrama,字谜,anagramme,анаграмма">>.

anagram('GET', []) ->
    %%{ok, []}.
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, anagram_keywords()}]};
   
anagram('POST', []) ->
    %%Word = Req:param("word"),
    Word = Req:post_param("word"),
    ShortWord = lists:sublist(Word, 8),
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, anagram_keywords()}, 
	  {words, perms(ShortWord)}]}.

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INDEX
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

index('GET', []) ->
    {ok, [{title, "Home"},
          {description, "Opensource tools"},
          {keywords, <<"opensource,tools">>}]}.

