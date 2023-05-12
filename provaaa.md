# TODO:

- [ ]  fare cassa di legno

- [ ]  sistemare tunanotes

- [ ]  mettere i quadernoni da qualche altra parte

- [x]  sistemare qtpanel (e trovare un nome migliore, tipo touchscreenGestures o qualcosa del genere)

## urgenti:

- [ ]  

## TunaNotes:

-  UN solo tipo per blocco (`enum`)

-  dotlist

-  checklist

-  quote

-  header-nth

-  when typing, the active block is plain text

-  catch keyboard input if index==0:

-  '#' =>

-  se header -> header++

-  se non header -> header1

-  'CLTR+DEL' => plain text (removes formatting)

-  '-', '*', '+' => dotlist

-  '[' and then ' ' and then ']' (even without space or with x or X) =>

-  if dotlist or plain -> checklist

-  else -> do nothing

```python
 ch = input_character
txt = current_text.trim()
index = current_cursor_index
type = current_type

if ch == '#':
	if type == "h*":
		type = h(*+1)
    else:
    	type = h1
if ch in "+*-":
	type = "dotlist"
if ch == ']':
	if txt.beginsWith({'+' or '*' or '-'}{' ' or ''}'['{' ' or 'x' or 'X'}:
```

 https://iampe.agenziaentrate.gov.it/sam/UI/Login?realm=/agenziaentrate

 

ciaociao