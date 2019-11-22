xquery version "3.1";

module namespace app="http://my.wineCellar.de/templates";

import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://my.wineCellar.de/config" at "config.xqm";

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
        let $volume := $bottle/@volume/string()
        let $color := $bottle/color
        let $grapeVariety := $bottle/grapeVariety
        let $sweet := $bottle/sweet
        let $vineyard := $bottle/vineyard
        let $pic := if($n='0') then('empty.jpg') else if($color='rot') then('red.jpg') else if($color='weiß') then('white.jpg') else if($color='rose') then('rose.jpg') else if($color='sparkling') then('sparkling.jpg') else()
        return
            <div class="row box">
                <div class="col-md-4">
                 <img src="{concat('http://localhost:8080/exist/apps/wineCellar/resources/pics/',$pic)}" alt="no picture" height="140"/> 
                </div>
                <div class="col-md-6">
                    <table>
                        <tr>
                            <td>{$id}</td>
                            <td><button><a href="edit/{$id}">edit</a></button></td>
                        </tr>
                        <tr>
                            <td width="150px">Anzahl:</td>
                            <td>{$n}</td>
                        </tr>
                        <tr>
                            <td>Flaschengröße:</td>
                            <td>{$volume} L</td>
                        </tr>
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
                            <td>Weingut:</td>
                            <td>{$vineyard}</td>
                        </tr>
                    </table>
                </div>
            </div>
};

declare function app:wineCellarEdit($node as node(), $model as map(*)) {
    let $id := request:get-parameter("bottle-id", "Fehler")
    let $bottle := collection("/db/contents/wineCellar")//bottle[@id = $id]
    let $n := $bottle/@stock/string()
    let $volume := $bottle/@volume/string()
    let $color := $bottle/color
    let $grapeVariety := $bottle/grapeVariety
    let $sweet := $bottle/sweet
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
            Anzahl:<br/>
            <input type="text" name="Süße" value="{$sweet}"/>
            <br/>
            Flaschengröße:<br/>
            <input type="text" name="Weingut" value="{$vineyard}"/>
            <br/><br/>
            <button onclick="history.back();">speichern</button>
         </div>

};