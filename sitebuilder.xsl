<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	The MIT License

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
	 
	 This XSLT is not supposed to run on an XML-pocessor other than Xalan J     
	 because it uses its XSLT-extensions. However do so if it works ;-)         
	 
	 Before use change the values marked with comments below to fit your needs. 
	 
	 Questions & bug-reports: sbuilder@tkuhn.de             the DFUe AG rocks on
	 
	 
	 Version History:
	 
	 0.9.5 - Removed the ouput-element in website-defifition and added its      
	         functionality to the pagetree-element. (To update from 0.9.4 just  
	         open your website remove you output-element and add its attributes 
	         to the pagetree-element.)                                          
	       - Introduced namespaces.                                             
	 
	 0.9.4 - Introduced optional pageref attribute in pagespec to determine the 
             page, so that you can have the same paths for diffenrent page ids. 
           - Introduced optional absolutepath attribute in pagespec to give an  
             absolute path where the file should be output instead of the path  
             calculated from the path attributes.                               
		   - Status-output is valid html now.                                   
		   - Link-, outputdirectory-prefixes and default-filename can now be set
             in the xml, as a variable or from the commandline.                 
	 
     0.9.3 Pages will be output even if there is a href-attribure specified in  
           the "pagespec". If you don't want them to be output specify          
           build="no". (This can be used when you need to build a template for a
           page that is on a different url e.g. a script that is in cgi-bin.    
	 
	 0.9.2 Was the first release.
-->

<xsl:stylesheet version="1.0"
        	    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	          xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:redirect="org.apache.xalan.xslt.extensions.Redirect"
   		    xmlns:sb="http://www.tkuhn.de/xml/sitebuilder/SiteBuilder"
                extension-element-prefixes="redirect"
			    exclude-result-prefixes="sb">
			
  <lxslt:component prefix="redirect" elements="write open close" functions="">
    <lxslt:script lang="javaclass" src="org.apache.xalan.lib.Redirect"/>
  </lxslt:component>  
  
<!-- Fill in the location of the xslt that translates the page-elements!        
     Don't change for the demo!                                              -->
  <xsl:import href="demotrans.xsl"/> 
   
<!-- Change these to output HTML4.01!  Default: XHTML 1.0                    --> 
  <xsl:output method="xhtml"
              encoding="iso-8859-1"
              indent="yes" 
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
              doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

<!-- Do not change: -->		
  <xsl:param name="outputprefix" select="''"/>
  <xsl:param name="filename" select="''"/>	
			  
<!-- Fill in the default directory in which the output files shall be created.  
     Include '/' at the end. Is used if none is present in the xml nor in the   
     commandline. -->
  <xsl:variable name="defaultoutputprefix" select="'./'"/>

<!-- Fill in the default filename for your output files. Is used if none is     
     present in the xml nor in the commandline.                              -->
  <xsl:variable name="defaultfilename" select="'index.html'" />
  
<!-- This is the SiteBuilder version number (don't change)                   -->  
  <xsl:variable name="version" select="'0.9.4'"/>
  
<!-- Enter the e.mail of the webmaster of your site. Used in the errortemplate  
     You need no change for the demo! -->  
  <xsl:variable name="webmaster" select="'webmaster@tkuhn.de'"/>

<!-- The errortemplate gets output if no page definition was found and the page 
     was specified for beenig build.                                            
	 You need no change for the demo! -->
  <xsl:template name="errortemplate">
  <xsl:param name="pageref" select="'unknown'"/>
    <html>
	  <head>
	     <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
         <meta name="author" content="SiteBuilder {$version}" />
		 <meta name="description" content="SiteBuilder error Message" />
		 <meta name="MSSmartTagsPreventParsing" content="TRUE" />
         <title>SiteBuilder error!</title>
	  </head>
	  <body>
	    <h1>SiteBuilder <xsl:value-of select="$version"/> error!</h1>
		<hr/>
		<p>
		  Site Builder could not find a definition for page <xsl:value-of select="$pageref"/> while building the
		  website.<br/>
		  Please contact <a href="mailto:{$webmaster}"><xsl:value-of select="$webmaster"/></a>.
		</p>
	  </body>
	</html>
  </xsl:template>
  
  <xsl:variable name="dirpre">
    <xsl:choose>
      <xsl:when test="$outputprefix != ''">
 	    <xsl:value-of select="$outputprefix"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:choose>
		  <xsl:when test="/sb:website/sb:pagetree/@outputprefix">
		    <xsl:value-of select="/sb:website/sb:pagetree/@outputprefix"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="$defaultoutputprefix"/>
		  </xsl:otherwise>
		</xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:variable>	
  
  <xsl:variable name="defaultfname">
    <xsl:choose>
      <xsl:when test="$filename != ''">
 	    <xsl:value-of select="$filename"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:choose>
		  <xsl:when test="/sb:website/sb:pagetree/@filename">
		    <xsl:value-of select="/sb:website/sb:pagetree/@filename"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="$defaultfilename"/>
		  </xsl:otherwise>
		</xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:variable>	
  
  <xsl:key name="page" match="//sb:page" use="@id"/>
  
  <xsl:template name="build">
  <xsl:param name="pageref" select="''"/>
  <xsl:param name="destination" select="$defaultfname"/>
    <xsl:choose>
	  <xsl:when test="$pageref = ''">
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:choose>
	      <xsl:when test="key('page',$pageref)">
		    <redirect:write select="$destination">
		      <xsl:apply-templates select="key('page',$pageref)"/>
		    </redirect:write>
			<li>build <xsl:value-of select="$destination"/> from page-id: <xsl:value-of select="$pageref"/></li>
		  </xsl:when>
		  <xsl:otherwise>
		    <redirect:write select="$destination">
		      <xsl:call-template name="errortemplate">
			    <xsl:with-param name="pageref" select="$pageref"/>
			  </xsl:call-template>
		    </redirect:write>
            <li>ERROR: Could not find a definition for page <xsl:value-of select="$pageref"/></li>.
		  </xsl:otherwise>
	    </xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="pagespec">
  <xsl:param name="path" select="'/'" />
  <xsl:param name="recurse" select="'normal'" />
    <xsl:variable name="filename">
	  <xsl:choose>
	    <xsl:when test="@filename">
		  <xsl:value-of select="@filename"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="$defaultfname"/>
		</xsl:otherwise>
      </xsl:choose>
	</xsl:variable>
	<xsl:variable name="pageref">
	  <xsl:choose>
	    <xsl:when test="@pageref">
		  <xsl:value-of select="@pageref"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@path"/>
		</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
    <xsl:choose>
	  <xsl:when test="$pageref='home'">
	    <xsl:if test="(@build='yes') or (@build='rec')">
		  <xsl:call-template name="build">
		    <xsl:with-param name="pageref" select="'home'"/>
			<xsl:with-param name="destination" select="concat($dirpre,$filename)"/>
		  </xsl:call-template>
		</xsl:if>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:variable name="actpath">
		  <xsl:value-of select="$path"/>
		  <xsl:if test="@path">
		    <xsl:value-of select="concat(@path,'/')" />
		  </xsl:if>
		</xsl:variable>
		<xsl:variable name="destination">
		  <xsl:choose>
		    <xsl:when test="@absolutepath">
			  <xsl:choose>
			    <xsl:when test="starts-with(@absolutepath,'dirpre:')">
				  <xsl:value-of select="concat($dirpre,substring-after(@absolutepath,'dirpre:'),$filename)"/>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="concat(@absolutepath,$filename)"/>
				</xsl:otherwise>
			  </xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:value-of select="concat($actpath,$filename)"/>
			</xsl:otherwise>
	      </xsl:choose>
		</xsl:variable>
		<xsl:choose>
	      <xsl:when test="($recurse='recurse') or (@build='rec')">
			  <xsl:call-template name="build">
		        <xsl:with-param name="pageref" select="$pageref"/>
			    <xsl:with-param name="destination" select="$destination"/>
		      </xsl:call-template>
	        <xsl:for-each select="sb:pagespec">
              <xsl:call-template name="pagespec">
	            <xsl:with-param name="path" select="$actpath" />
			    <xsl:with-param name="recurse" select="'recurse'" />
              </xsl:call-template>
		    </xsl:for-each>	
	      </xsl:when>
	      <xsl:when test="@build='yes'">
			  <xsl:call-template name="build">
		        <xsl:with-param name="pageref" select="$pageref"/>
			    <xsl:with-param name="destination" select="$destination"/>
		      </xsl:call-template>
		    <xsl:for-each select="sb:pagespec">
              <xsl:call-template name="pagespec">
	            <xsl:with-param name="path" select="$actpath" />
			    <xsl:with-param name="recurse" select="'normal'" />
              </xsl:call-template>
		    </xsl:for-each>	
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:for-each select="sb:pagespec">
              <xsl:call-template name="pagespec">
	            <xsl:with-param name="path" select="$actpath" />
			    <xsl:with-param name="recurse" select="'normal'" />
              </xsl:call-template>
		    </xsl:for-each>	
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match="sb:pagetree">
    <xsl:choose>
	  <xsl:when test="@build='rec'">
	  	<xsl:for-each select="sb:pagespec">
            <xsl:call-template name="pagespec">
	          <xsl:with-param name="path" select="$dirpre" />
			  <xsl:with-param name="recurse" select="'recurse'" />
            </xsl:call-template>
        </xsl:for-each>	
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:for-each select="sb:pagespec">
            <xsl:call-template name="pagespec">
	          <xsl:with-param name="path" select="$dirpre" />
			  <xsl:with-param name="recurse" select="'normal'" />
            </xsl:call-template>
        </xsl:for-each>	
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
	
  <xsl:template match="sb:website">
    <html>
	  <head>
         <title>SiteBuilder <xsl:value-of select="$version"/> by Tilmann Kuhn.</title>
	  </head>
	  <body>
	    <h1>SiteBuilder <xsl:value-of select="$version"/> by Tilmann Kuhn.</h1>
		<h2>build status:</h2>
		<ul>
		  <xsl:apply-templates select="sb:pagetree"/>
		</ul>
		<h2>building finished!</h2>
	  </body>
	</html>
  </xsl:template>  
	
</xsl:stylesheet>
