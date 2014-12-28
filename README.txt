SiteBuilder
-----------
Copyright (C) 2014 Tilmann Kuhn
See LICENSE.txt for details of the MIT license.

Contents of this readme:

* Purpose
* Change history
* Contents of the release
* How to get started
* How to contact me 
* Limitations and bugs



PURPOSE

This is a tiny XSLT for the Xalan XML-processor can be used to transform XML-web-pages
defined in one XML file similar to the following into a directory-strucrure of XHTML/HTML
files to be published on a www-server.

Example:
<website>
  <pagetree build="yes">
    <pagespec path="home" build="yes"/>
    <pagespec path="studium" build="yes">
      <pagespec path="informatik" build="no"/>
      <pagespec path="info-links" build="rec"/>
    </pagespec>
    ...
  </pagetree>
  <page id="home">
    ...
  </page>
  <page id="studium">
    ...
  </page>
  ...
</website>
In this example the following files would be created:
index.html
studium/index.html
studium/info-links/index.html
Of course you can have the files output to other filenames than 'index.html' and other
locations than the calculated path from the pagespectree too, as you can insert links
to other pages in this navigational structure.



CHANGE HISTORY

0.9.5 - Updated README and LICENSE
0.9.4 - Introduced optional pageref attribute in pagespec to determine the page, so
        that you can have the same paths for diffenrent page ids.
      - Introduced optional absolutepath attribute in pagespec to give an absolute
        path where the file should be output instead of the path calculated from the
        path attributes.
      - Status-output is valid html now.
      - Link-, outputdirectory-prefixes and default-filename can now be set in the
        xml, as a variable or from the commandline.
      - I did a little bugfixing on the dtd. I hope it is correct now because I'm not
        very familiar with dtds. :-(
0.9.3 - Pages will be output even if there is a href-attribure specified in the
        "pagespec". If you don't want them to be output specify build="no". (This can
        be used when you need to build a template for a page that is on a different
        url e.g. a script that is in cgi-bin.
      - The href-attribute was also removed from "website.dtd".
0.9.2 - The first release.



CONTENTS OF THE RELEASE

readme.txt        - This file.
sitebuilder.xsl   - The xslt that is used to convert a xml-website to html-files.
demotrans.xsl     - The xslt that converts a single page inside the xml to html.
website.dtd       - The DTD used for the input-files for sitebuilder.xsl.
demosite.xml      - A demonstration xml-file that defines a website.
demobuild.bat     - The shell-script that runs the demo.



HOW TO GET STARTED
sitebuilder.xsl is not supposed to run on an XML-pocessor other than Xalan J
because it uses its XSLT-extensions. However do so if it works ;-)

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



HOW TO CONTACT ME

http://www.tkuhn.de
sbuilder@tkuhn.de



LIMITATIONS AND BUGS

Not known so far. Please report your experiences to me.