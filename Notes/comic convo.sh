
URL 	irc://freenode/Susan,isnick 	Connected via 	adams.freenode.net
Conversation with Susan <sex@wikipedia/MZMcBride>
Well open up your mind and see like me.
Susan
	Susan	Including #python.
	Susan	And... others, I guess.
	Susan	Plus I'm always connected.
	Susan	Pastebin your code?
	Temporary123	which site did you recommend?
	Susan	http://dpaste.de
	Temporary123	http://dpaste.de/dRO1k/
	Susan	You figured out how to set a User-Agent!
	Susan	ygg
	Temporary123	I copied it from the Internet.
	Susan	No kidding.
	Susan	You're coding!
	Temporary123	
	Susan	So you need to figure out where the URL is.
	Susan	In the response text.
	Susan	And then grab it.
	Temporary123	the image url?
	Susan	Yes.
	Temporary123	How do I do that?
	Susan	Go to <http://www.gocomics.com/calvinandhobbes/> and figure out where the URL you want is in the HTML page source.
	Temporary123	http://assets.amuniversal.com/fd7226901dee012f2fc700163e41dd5b
	Temporary123	!
	Susan	Right.
	Susan	And you can tack on a ?width= parameter to make it larger.
	Susan	http://assets.amuniversal.com/fd7226901dee012f2fc700163e41dd5b?width=1000
	Susan	Though it's a bit fuzzy.
	Susan	http://assets.amuniversal.com/0a16dd501def012f2fc700163e41dd5b?width=1000
	Susan	That version is clearer.
	Susan	Anyway,
	Susan	it looks like you can just search the page text for "?width=900" or similar.
	Temporary123	questions
	Temporary123	where'd the better resolution image url come from?
	Susan	>
	Susan	<p class="feature_item"><a href='#mutable_868789' class='photo'><img alt="Calvin and Hobbes" class="strip" onload="Meebo('makeSharable',{element:this, type:'image', shadow:'none', title:'Calvin and Hobbes', url:document.location.href, tweet:'Check out Calvin and Hobbes on GoComics', description:'Check out Calvin and Hobbes on GoComics'})" src="http://assets.amuniversal.com/fd7226901dee012f2fc700163e41dd5b" width="600" /></a><div id='mutable_868789' ...
	Susan	... style='display: none;'><img alt="0a16dd501def012f2fc700163e41dd5b?width=900" class="strip" src="http://assets.amuniversal.com/0a16dd501def012f2fc700163e41dd5b?width=900.0" /></div> </p>
	Susan	>
	Susan	(o;
	Susan	That block of HTML page source.
	Susan	OBVICOPTERS.
	Temporary123	got it
	Temporary123	so how do I search?
	Susan	http://dpaste.de/yXPhR/raw/
	Temporary123	find()
	Susan	You can use .find(), but you already imported red.
	Susan	Err, re.
	Susan	Muscle memory is a cruel and fickle mistress.
	Susan	Anyway, compare that paste I just sent over to yours.
	Susan	And ask any questions you have.
	Temporary123	looking at it
	Susan	(Do you understand regular expressions?)
	Temporary123	I know what they do.
	Temporary123	I don't know how to use them yet.
	Susan	Okay.
	Susan	I'll walk you through this script.
	Susan	Top part is the shebang.
	Susan	That just tells the OS how to interpret the file.
	Susan	And how to execute it.
	Susan	#! /usr/bin/env python
	Susan	https://en.wikipedia.org/wiki/Shebang_%28Unix%29
	Susan	More info. ^
	Susan	Second two lines are your imports.
	Susan	You had a third import, but it was stupid.
	Susan	You don't need to import urllib twice.
	Susan	The class overrides the default User-Agent.
	Susan	base_url is a variable.
	Susan	img_re is a variable, but it's holding a compiled regular expression.
	Susan	img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')
	Susan	The convention for regular expressions is to name them _re, usually.
	Temporary123	what does re.compile mean/do?
	Susan	It compiles the regular expression.
	Susan	http://docs.python.org/2/library/re.html#re.compile
	Susan	So you can compile a regular expression before calling .match() or .search() using it.
	Temporary123	k
	Susan	img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')[20:17] <Susan> img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')
	Susan	So that compiles a regular expression that looks for 'src="..."' in the page source.
	Susan	More specifically, src="http://assets..."
	Susan	l\.com
	Susan	The period character matches any character one time.
	Temporary123	k
	Susan	http://www.cheatography.com/davechild/cheat-sheets/regular-expressions/
	Temporary123	that's going to be helpful
	Susan	Not sure why that site has ads.
	Susan	So ".*" is any character (period) 0 or 1 times (*).
	Susan	So .* matches pretty much anything.
	Susan	.+ matches any character 1 or more times (not zero).
	Susan	.{2,3} matches any character 2 to 3 times, inclusive.
	Susan	I think.
	Susan	Right.
	Susan	We won't get into greedy v. non-greedy regexen right now.
	Temporary123	k
	Susan	Most of the rest of the script is what you already had.
	Susan	>
	Susan	response = page.read()
	Susan	match = img_re.search(response)
	Susan	image_url = match.group(1)
	Susan	>
	Susan	Put the response in a variable.
	Susan	Then define a variable (match) and take the compiled regular expression and search the response.
	Susan	img_re <-- compiled regex.
	Susan	.search() <-- function
	Susan	.search(response) <-- function + actual useful shit (the HTML response)
	Susan	Then image_url is your next variable.
	Susan	Regular expressions have groupings.
	Susan	Or they can. Do you understand those?
	Temporary123	nope
	Susan	Okay.
	Susan	So let's say you have the string "A hello B".
	Susan	And you want to make the string "A hello B hello".
	Temporary123	k
	Susan	Basically taking the content between "A " and " B" and duplicating it.
	Susan	In order to do this, you have to define groupings.
	Susan	So way up above...
	Susan	img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')
	Susan	You're defining a grouping in there.
	Susan	Do you see it?
	Susan	It starts before "http://".
	Susan	And it ends after "900.0".
	Temporary123	k
	Susan	Groupings in Python happen to not be zero-indexed.
	Temporary123	so it's setting boundaries
	Susan	Right.
	Susan	So if you had "A hello B", you'd write a regex like...
	Susan	"A (.+) B"
	Temporary123	right
	Susan	That would match any non-empty string between those characters.
	Susan	Or if you want to be more precise, you might write....
	Susan	"A [a-z]{5} B"
	Temporary123	space is included?
	Temporary123	oops
	Temporary123	nm
	Susan	That means [a-z] (lowercase alphabet A to Z) exactly five times.
	Susan	So that would match "hello".
	Temporary123	right
	Susan	You have to be careful with regex.
	Susan	http://xkcd.com/1031/
	Susan	So the script searches the response (the full HTML) looking for a string similar to "src=...".
	Temporary123	got it
	Susan	And then if it finds a match, it grabs it and you then grab .group(1).
	Susan	[20:25] <Susan> Groupings in Python happen to not be zero-indexed.
	Temporary123	yes
	Susan	Oh, as I was saying...
	Susan	[20:25] <Susan> "A [a-z]{5} B"
	Susan	So that would be your find.
	Susan	And your replacement would be "A \1 B \1".
	Temporary123	ohhhhh
	Susan	So you'd end up with "A hello B hello".
	Susan	So if you have "Smith, John" and "Elrod, Susan", you can match them like...
	Susan	"(.+), (.+)"
	Susan	And then replace them with "\2 \1".
	Susan	I think Python's syntax is a bit weirder, but similar concept wherever you go.
	Temporary123	k
	Susan	You can do this in TextWrangler.
	Temporary123	Do what exactly?
	Temporary123	oh
	Temporary123	search?
	Susan	Groupings with regular expressions.
	Susan	>
	Susan	image_url = match.group(1)
	Susan	return image_url
	Susan	>
	Susan	So you grab the image_url and store it in a variable.
	Temporary123	right
	Susan	And then tell the function (get_image_url) to return the variable.
	Susan	>
	Susan	for comic in comics:
	Susan	print comic
	Susan	print get_image_url(comic)
	Susan	for comic in comics:
	Susan	print comic
	Susan	print get_image_url(comic)
	Susan	Oop.
	Susan	If you want to clear scrollback, you can type "/clear".
	Susan	clears.
	Susan	Anyway, that for loop just iterates through your comics and prints the comic name and image URL.
	Temporary123	right
	Susan	Okay.
	Temporary123	cool!
	Temporary123	so now we have the url
	Temporary123	How do I dump all of the actual images onto a page or email?
	Susan	You'll need to download them, I guess.
	Susan	So you'll read the URLs.
	Susan	image = urllib.urlopen(...).read()
	Susan	Then write a file.
	Susan	Like...
	Susan	f = open('hello.jpg', 'w')
	Susan	f.write(image)
	Susan	f.close()
	Susan	I'll be back later. Maybe.
	Susan	Good luck!
	Temporary123	thanks1
	Temporary123	*!
	Susan	Be careful with file writes.
	Temporary123	...
	Susan	The images will go in to the current working directory unless you specify otherwise.
	Susan	So... open('/Users/Plemer/hello.jpg', 'w')
	Susan	Or whatever.
	Susan	Just don't overwrite your hard drive with a "Calvin & Hobbes" images.
	Temporary123	there are worse things to overwrite my hard drive with
	Temporary123	
	Temporary123	Are you in Ohio yet?
