SiteBuilder Version 0.9.5              
	 
sitebuilder.xsl is not supposed to run on an XML-pocessor other than Xalan J
because it uses its XSLT-extensions. However do so if it works ;-)


Contents of this zip-file:
==========================

readme.txt        - This file.

sitebuilder.xsl   - The xslt that is used to convert a xml-website to html-files.

demotrans.xsl     - The xslt that converts a single page inside the xml to html.

website.dtd       - The DTD used for the input-files for sitebuilder.xsl.

demosite.xml      - A demonstration xml-file that defines a website.

demobuild.bat     - The shell-script that runs the demo.


How to run the demo:
====================
1.
Examine the files sitebuilder.xsl and demosite.xml to change the commented variables
and/or values so that they fit your environment. Usually you don't need to change
very much.

2.
If running on unix: chmod u+x demobuild.bat

3.
Run demobuild.bat!
Now, there should be created the html-files and directories in the location
specified in 1.

4.
Maybe you have to move them to your webserver.

5.
Examine "index.html" in your home directory via the server.


What can I do with SiteBuilder?
===============================

Since SiteBuilder is a very little tool, it is not hard to understand what it does.
First do the demo. And then have a look at the commented DTD website.dtd to see
what features SiteBuilder has to offer.



The MIT License
===============

Copyright (C) 2001 
Tilmann Kuhn           Gildestr. 34
http://www.tkuhn.de    76149 Karlsruhe
sbuilder@tkuhn.de      Germany

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.