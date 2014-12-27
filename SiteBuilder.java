/*
 * SiteBuilder.java
 *
 * Created on 17. Februar 2002, 15:59
 */

import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.parsers.*;

/**
 * @author  Tilmann Kuhn
 */
public class SiteBuilder {

    /** 
	 * Creates new SiteBuilder
	 */
    public SiteBuilder() {
    }

    /**
     * @param args the command line arguments
     */
    public static void main (String args[]) {
        if (args.length == 2) {
            if ((args[0].endsWith(".xsl")) && (args[1].endsWith(".xml"))) {
                try {
                    TransformerFactory tFactory = TransformerFactory.newInstance();
                    StreamSource xsl = new StreamSource(args[0]);
                    StreamSource xml = new StreamSource(args[1]);
                    Transformer transformer = tFactory.newTransformer(xsl);
                    transformer.transform(xml,new StreamResult(System.out));
                } catch(Exception e) {
                    e.printStackTrace();
                }
            } else {
                System.out.println("Usage: java SiteBuilder in.xsl in.xml\n");
            }
        } else {
            System.out.println("Usage: java SiteBuilder in.xsl in.xml\n");
        }
    }

}
