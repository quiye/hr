cd /home/pi/fitbitt/
cat `ls -l 20* |grep -v 'pi.*pi.* 0 .*'|grep -v 'pi.*pi.* 382 .*'|tail -n 1| awk '{print $9}'` |sed "s/'/\"/g"|jq '(."activities-heart-intraday"[]|reverse)[0:4]'| grep value |awk '{X += $2}END{printf("%.1f %.3f\n",X / NR, 60 / ( X / NR) )}'> /home/pi/hr/hr.txt
cd /home/pi/hr/
#sed "s/^at .*/at `date`/g" -i index.html
#sed "s/心拍数.*分/心拍数: `cat hr.txt|awk '{print $1}'` 回\/分/g" -i index.html
#sed "s/-webkit-animation: animationTest .*s/-webkit-animation: animationTest `cat hr.txt|awk '{print $2}'`s/g" -i index.css
#sed "s/index\.css?v=[0-9]*/index\.css?v=`date +%s`/g" -i index.html
#sed "s/hr\.json?v=[0-9]*/hr\.json?v=`date +%s`/g" -i index.html
#echo "{\"heartrate\": \"`cut -f1 -d' ' hr.txt`\", \"date\": \"`date`\", \"animationrate\": \"`cut -f2 -d' ' hr.txt`\"}" > hr.json
#git add hr.json && git commit -m "`date`" && git push origin master
curl -sS --dump-header - 'https://api.myjson.com/bins/kfhmi' -X PUT -H 'Content-Type:application/json; charset=utf-8' -d "{\"heartrate\": \"`cut -f1 -d' ' hr.txt`\", \"date\": \"`date`\", \"animationrate\": \"`cut -f2 -d' ' hr.txt`\"}"
