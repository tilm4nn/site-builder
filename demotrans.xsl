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
                                              by Tilmann Kuhn

	This is a demonstration of how a "pagetranslator" is used together with the 
	SiteBuilder.
 -->

<xsl:stylesheet version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
				xmlns:html="http://www.w3.org/1999/xhtml"
				xmlns:sb="http://www.tkuhn.de/xml/sitebuilder/SiteBuilder"
				xmlns:pt="http://www.tkuhn.de/xml/sitebuilder/PageTranslator"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				exclude-result-prefixes="pt sb html">
  
  <xsl:param name="linkprefix" select="''"/>

<!-- This is used only if no linkprfix is given in the xml nor the commandline. 
-->
  <xsl:variable name="defaultlinkprefix" select="'/'" />

  <xsl:variable name="linkpre">
    <xsl:choose>
      <xsl:when test="$linkprefix != ''">
 	    <xsl:value-of select="$linkprefix"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:choose>
		  <xsl:when test="/sb:website/sb:pagetree/@linkprefix">
		    <xsl:value-of select="/sb:website/sb:pagetree/@linkprefix"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="$defaultlinkprefix"/>
		  </xsl:otherwise>
		</xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
  </xsl:variable>	
  
<!-- The template for "page" outputs the frame of the html files             --> 
  <xsl:template match="sb:page">
    <html>
	  <head>
	     <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
         <meta name="author" content="SiteBuilder" />
		 <meta name="description" content="SiteBuilder DemoSite" />
		 <meta name="MSSmartTagsPreventParsing" content="TRUE" />
         <title>SiteBuilder DemoSite - <xsl:value-of select="@id" /></title>
	  </head>
	  <body>
	    <xsl:apply-templates select="*" />
	  </body>
	</html>
  </xsl:template>

<!-- This template is used to recurse down pagetree to build a navigation-bar   
     it is calld by the template for "navbar"                                -->
  <xsl:template name="topic">
    <xsl:param name="path" select="'/'"/>
    <xsl:param name="topic" select="'home'"/>
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
				  <xsl:value-of select="concat($linkpre,substring-after(@absolutepath,'dirpre:'))"/>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="@absolutepath"/>
				</xsl:otherwise>
			  </xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:value-of select="$actpath"/>
			</xsl:otherwise>
	      </xsl:choose>
		  <xsl:if test="@filename">
		    <xsl:value-of select="@filename"/>
		  </xsl:if>
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
	    <xsl:when test="$path=$linkpre">
		  <td style="width:100px;vertical-align:top;">
		    <span style="font-weight:bold;">
		      <xsl:text>[ </xsl:text>
              <xsl:choose>
	            <xsl:when test="$pageref=$topic">
		           <xsl:value-of select="@text" />
	            </xsl:when>
	            <xsl:otherwise>
		          <xsl:choose>
			        <xsl:when test="$pageref='home'">
		              <a href="{$linkpre}"><xsl:value-of select="@text" /></a>
			        </xsl:when>
			        <xsl:otherwise>
					  <a href="{$destination}"><xsl:value-of select="@text" /></a>
			        </xsl:otherwise>
			      </xsl:choose>
	            </xsl:otherwise>
	          </xsl:choose>
		      <xsl:text> ]</xsl:text>
			</span>
	        <xsl:if test="descendant-or-self::sb:pagespec[@path=$topic and not(@pageref)] or descendant-or-self::sb:pagespec[@pageref=$topic]">
	          <xsl:if test="sb:pagespec">
	            <xsl:for-each select="sb:pagespec">
                  <xsl:call-template name="topic">
	                <xsl:with-param name="path" select="$actpath"/>
				    <xsl:with-param name="topic" select="$topic"/>
                  </xsl:call-template>
                </xsl:for-each>	
	          </xsl:if>
	        </xsl:if>
		  </td>
		</xsl:when>
		<xsl:otherwise>
		  <br/>
		  <xsl:text>[ </xsl:text>
          <xsl:choose>
	        <xsl:when test="$pageref=$topic">
		       <xsl:value-of select="@text" />
	        </xsl:when>
	        <xsl:otherwise>
		      <xsl:choose>
			    <xsl:when test="$pageref='home'">
		          <a href="{$linkpre}"><xsl:value-of select="@text" /></a>
			    </xsl:when>
			    <xsl:otherwise>
			      <a href="{$destination}"><xsl:value-of select="@text" /></a>
			    </xsl:otherwise>
			  </xsl:choose>
	        </xsl:otherwise>
	      </xsl:choose>
		  <xsl:text> ]</xsl:text>
		</xsl:otherwise>
	  </xsl:choose>
  </xsl:template>
  
  
<!-- This template will build the demo navigation bar using the call-template   
     "topic"                                                                 -->
  <xsl:template match="pt:navbar">
    <xsl:variable name="topic" select="ancestor::sb:page/@id"/>
    <table>
	  <tr>
 	    <xsl:for-each select="//sb:pagetree/sb:pagespec">
	      <xsl:call-template name="topic">
	 	    <xsl:with-param name="path" select="$linkpre"/>
		    <xsl:with-param name="topic" select="$topic"/>
		  </xsl:call-template>
	    </xsl:for-each>
      </tr>
	</table>
	<hr/>
  </xsl:template>
    
<!-- These essential templates is used to copy all html elements from the web-  
     site xml to the output. These are the html elements since there is no      
	 special template for them.                                              -->
  <xsl:template match="html:*/@*">
    <xsl:attribute name="{name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="html:*">
    <xsl:element name="{name()}">
      <xsl:apply-templates  select="@*|html:*|pt:*|text()"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
