#!/bin/bash
JSON_DATA="$(mysql -B dsubs_prod -e 'select * from kill_records where created_at < UTC_TIMESTAMP - INTERVAL 30 minute and simulator_id like "main%" order by id desc limit 250;' | csvjson -t)"
echo -n '<link href="https://unpkg.com/tabulator-tables@4.4.1/dist/css/tabulator.min.css" rel="stylesheet">
<script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.4.1/dist/js/tabulator.min.js"></script>
<div id="kills_table"></div>
<script type="text/javascript">
    var kill_records = ' > index.html
echo "${JSON_DATA};" >> index.html
echo '    var table = new Tabulator("#kills_table", {
        data: kill_records,
        layout:"fitColumns",
        columns:[
            {title:"Timestamp", field:"created_at"},
            {title:"simulator_id", field:"simulator_id"},
            {title:"Shooter", field:"shooter_captain_name"},
            {title:"Shooter hull", field:"shooter_hull_name"},
            {title:"Victim", field:"dead_captain_name"},
            {title:"Victim hull", field:"dead_hull_name"},
            {title:"Weapon", field:"weapon_name"},
            {title:"Weapon travel distance", field:"weapon_travelled"}
        ]
    });
    table.setSort("created_at", "desc");
</script>' >> index.html
