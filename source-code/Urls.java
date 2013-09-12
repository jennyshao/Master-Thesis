import java.io.BufferedReader;
import java.net.MalformedURLException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;

public class Urls{

    final String leftBoundary = "<body";
    final String rightBoundary = "/body>";

    HashSet<String> urlsetHash;  
    ArrayQueue<String> urlqueue;

    HashSet<String> fileset;  

    String rooturl;

    private String regex; 

    public static void main(String[] args) {

        //List<String> Domains;
        String strDomain = "http://www.dmv.state.ne.us/"; 

        List<String> links = new ArrayList<String>();
        LinkGetter myurl = new LinkGetter();
        links = myurl.getSinglePageUrls(strDomain);
        //linksProcess();
        for(String s : links){
            System.out.println(s);
        }
    }
/*
    public Urls(String strDomain)
    {
        this.rooturl = strDomain;
        urlsetHash = new HashSet<String>();
        urlqueue = new ArrayQueue<String>();

        fileset = new HashSet<String>();
    }
*/
}






