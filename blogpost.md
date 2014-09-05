This is an example of using Coffeescript and jQuery together to create a stylesheet switcher.
Coffeescript 'ia little language that compiles into javascript'.

I have already installed Coffeescript locally using the instructions which can be found on the [Coffeescript website] [CF-website].
Which allows for command line compilation into javascript.

I have also created some template files:

index.html
<pre>
<code class="language-markup">
    &lt;!doctype html>
    &lt;html lang="en">
    &lt;head>
        &lt;meta charset="UTF-8">
        &lt;title>Coffeescript StyleSwitcher&lt;/title>
        &lt;link rel="stylesheet" href="" id="styles"/>
    &lt;/head>
    &lt;body>
        &lt;div id="buttons">
            &lt;button id="blackButton">Black&lt;/button>
            &lt;button id="whiteButton">White&lt;/button>
        &lt;/div>
        &lt;script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">&lt;/script>
        &lt;script src="switcher.js">&lt;/script>
    &lt;/body>
    &lt;/html>
</code>
</pre>

style1.css
<pre>
<code class="language-markup">
    body {
        background-color: #000;
    }
</code>
</pre>

style2.css
<pre>
<code class="language-markup">
    body {
        background-color: #fff;
    }
</code>
</pre>

As you can see there is a switcher.js file referenced within index.html, this is where we will
compile our coffeescript into. This will be written within a switcher.coffee file I has also created.

Within our coffee file we can get a reference to the buttons and stylesheet link tag within the header:

<pre>
    <code class="language-javascript">
        &#35;get reference to link tag
        style = $ "&#35;styles"

        &#35;get button references
        blackButton = $ "&#35;blackButton"
        blueButton = $ "&#35;whiteButton"
    </code>
</pre>

The link tag within the head has been given an id, originally I had thought that adding an id
to a link tag within the head was against W3C specifications, however having [reviewed them][w3c] an id is: As a means to reference a particular element from a script.

Now we have a reference for the three main components we need, we can add some more functional coffeescript:

<pre>
<code class="language-javascript">
    blackButton.click -&gt;
      changeStyle "style1.css"

    blueButton.click -&gt;
      changeStyle "style2.css"

    changeStyle = (stylesheet) -&gt;
      style.attr href: stylesheet
  </code>
</pre>

Here we have added a click event to each button, and then called the changeStyle function. In Coffeescript the function keyword
is replace with -&gt;, and there is also no need for parentheses. This can make it slighty harder to read to begin with, but I find it far more
readable once you understand the identifiers.

Now to compiles this into javascript:

<pre>
<code class="language-bash">
    coffee -c switcher.coffee
</code>
</pre>

This will compile the javascript in to the switcher.js file which has been referenced within index.html.

Now running this will allow you to switch the background colour, bask in the awesomeness.

Now we would like it that the user's choice of background persists past a page refresh, to do this we will use the
[jQuery-cookie][jquery-cookie] plugin. Which we will add after the call to the jQuery repo.

<pre>
<code class="language-markup">
    &lt;script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
</code>
</pre>

We can now set a cookie when we select a button:

<pre>
<code class="language-javascript">
    changeStyle = (stylesheet) -&gt;
      style.attr href: stylesheet
      setCookie stylesheet

    setCookie = (stylesheet) -&gt;
      $.cookie 'style', stylesheet, { expires: 7}
</code>
</pre>

(As you can see when calling functions there is no need to use parentheses.)

Now when selecting a button a cookie will be created, called style.

To set this on page load we can add:

<pre>
<code class="language-javascript">
    $ -&gt;
      stylesheet = $.cookie 'style'
      if stylesheet
        changeStyle stylesheet
      else
        changeStyle 'style1.css'
</code>
</pre>

This is very little code to wait for the page to load, find a cookie and use its value to set the stylesheet.

Coffeescript may seem strange to those, like me who feels their code is naked without parentheses, but once you get past that it provides
far more readable code and productive enviroment. This is especially true when using Coffeescript's classes.

[CF-website]: http://coffeescript.org/
[w3c]: http://www.w3.org/TR/html401/struct/global.html#adef-id