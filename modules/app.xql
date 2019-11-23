xquery version "3.1";

module namespace app="http://my.wineCellar.de/templates";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://my.wineCellar.de/config" at "config.xqm";

declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xhtml media-type=text/xml indent=yes";

(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute: data-template="app:test" or class="app:test" (deprecated). 
 : The function has to take 2 default parameters. Additional parameters are automatically mapped to
 : any matching request or function parameter.
 : 
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)
declare function app:wineCellar($node as node(), $model as map(*)) {
    let $cellar := collection('/db/contents/wineCellar')/bottle
    for $bottle in $cellar
        let $id := $bottle/@id/string()
        let $n := $bottle/@stock/string()
        let $volume := $bottle/@volume/translate(string(),'.',',')
        let $color := $bottle/color
        let $grapeVariety := $bottle/grapeVariety
        let $sweet := $bottle/sweet
        let $vintage := $bottle/vintage
        let $vineyard := $bottle/vineyard
        let $pic := if($n='0') then('empty.jpg') else if($color='rot') then('red.jpg') else if($color='weiß') then('white.jpg') else if($color='rose') then('rose.jpg') else if($color='sparkling') then('sparkling.jpg') else()
        order by $grapeVariety ascending, $vintage descending
        return
        (
            <div class="row box">
                <div class="col-md-4">
                 <img src="{concat('http://localhost:8080/exist/apps/wineCellar/resources/pics/',$pic)}" alt="no picture" height="140"/>
                 <span style="color:grey;"><br/>ID: {$id}</span>
                </div>
                <div class="col-md-5">
                    <table>
                        <tr>
                            <td>Farbe:</td>
                            <td>{$color}</td>
                        </tr>
                        <tr>
                            <td>Rebsorte:</td>
                            <td>{$grapeVariety}</td>
                        </tr>
                        <tr>
                            <td>Süße:</td>
                            <td>{$sweet}</td>
                        </tr>
                        <tr>
                            <td>Jahrgang:</td>
                            <td>{$vintage}</td>
                        </tr>
                        <tr>
                            <td>Weingut:</td>
                            <td>{$vineyard}</td>
                        </tr>
                        <tr>
                            <td>Flaschengröße:</td>
                            <td>{$volume} Liter</td>
                        </tr>
                        <tr>
                            <td width="150px">Anzahl:</td>
                            <td>{$n}</td>
                        </tr>
                    </table>
                </div>
            </div>)
};

declare function app:wineCellarEdit($node as node(), $model as map(*)) {
    let $id := request:get-parameter("bottle-id", "Fehler")
    let $collection := collection("/db/contents/wineCellar")
    let $bottle := $collection//bottle[@id = $id]
    let $n := $bottle/@stock/string()
    let $volume := $bottle/@volume/string()
    let $color := $bottle/color
    let $grapeVariety := $bottle/grapeVariety
    let $sweet := $bottle/sweet
    let $vintage := $bottle/vintage
    let $vineyard := $bottle/vineyard

    return
         <div>
            Anzahl:<br/>
            <input type="text" name="Anzahl" value="{$n}"/>
            <br/>
            Flaschengröße:<br/>
            <input type="text" name="Flaschengröße" value="{$volume}"/>
            <br/>
            Anzahl:<br/>
            <input type="text" name="Farbe" value="{$color}"/>
            <br/>
            Flaschengröße:<br/>
            <input type="text" name="Rebsorte" value="{$grapeVariety}"/>
            <br/>
            Süße:<br/>
            <input type="text" name="Süße" value="{$sweet}"/>
            <br/>
            Jahrgang:<br/>
            <input type="text" name="Süße" value="{$vintage}"/>
            <br/>
            Flaschengröße:<br/>
            <input type="text" name="Weingut" value="{$vineyard}"/>
            <br/><br/>
            <button onlick="history.back();">zurück</button>
         </div>
};