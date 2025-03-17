#from rawweb import RawWeb
from xml.etree import ElementTree as ET
from urllib import parse
import urllib
import base64
import csv
import codecs

filename='html5Vulnweb_bad'
log_file=filename+'.log'
csv_log_file=filename+'.csv'

def parse_log(log_path):
	'''
	This fucntion accepts burp log file path.
	and returns a dict. of request and response
	result = {'GET /page.php...':'200 OK HTTP / 1.1....','':'',.....}
	'''
	result = {}
	try:
		with open(log_path): pass
	except IOError:
		print("[+] Error!!! ",log_path,"doesn't exist..")
		exit()
	try:
		tree = ET.parse(log_path)
	except Exception:
		print('[+] Opps..!Please make sure binary data is not present in Log, Like raw image dump,flash(.swf files) dump etc')
		exit()
	root = tree.getroot()
	for reqs in root.findall('item'):
		raw_req = reqs.find('request').text
		raw_req = parse.unquote(raw_req)
		raw_resp = reqs.find('response').text
		result[raw_req] = raw_resp
	return result	
    
def parseRawHTTPReq(raw):
    try:
        raw = raw.decode('UTF-8')
    except Exception:
        raw = raw
        #print(type(raw))
    global headers,method,body,path
    headers = {}
    if(isinstance(raw,bytes)):
        sp =raw.decode('utf-8',errors='ignore').split('\r\n\r\n',1)
        #print(sp)
    else: 
        sp =raw.split('\r\n\r\n',1)
    if sp[1] != "":
        head = sp[0]
        body = sp[1]
    else:
        head = sp[0]
        body = ""
    c1 = head.split('\n',head.count('\n'))
    method = c1[0].split(' ',2)[0]
    path = c1[0].split(' ',2)[1]
    for i in range(1, head.count('\n')+1):
        slice1 = c1[i].split(': ',1)
        if slice1[0] != "":
            try:
                headers[slice1[0]] = slice1[1]
            except: 
                pass
    return headers,method,body,path

badWords=['sleep','drop','uid','select','waitfor','delay','system','union','group by','order by']
def extractFeatures(method,path_enc,body_enc,headers):
    badWords_count=0
    path=parse.unquote_plus(path_enc)
    body=parse.unquote(body_enc)
    single_q=path.count("'")+body.count("'")
    double_q=path.count("\"")+body.count("\"")
    dashes=path.count("--")+body.count("--")
    braces=path.count("(")+body.count("(")
    spaces=path.count(" ")+body.count(" ")
    for word in badWords:
        badWords_count+=path.count(word)+body.count(word)
        for header in headers:
            badWords_count+=headers[header].count(word)+headers[header].count(word)
    return [method,path_enc.strip(),body_enc.strip(),single_q,double_q,dashes,braces,spaces,badWords_count]

#Open logFile and writing to csvFile
f=open(csv_log_file,'w')
c=csv.writer(f)
c.writerow(["method","path","body","single_q","double_q","dashes","braces","spaces","badWords"])
f.close()
    
result=parse_log(log_file)

for item in result:
    data=[]
    raw=base64.b64decode(item)
    headers,method,body,path=parseRawHTTPReq(raw)
    data=extractFeatures(method,path,body,headers)
    f=open(csv_log_file,'a',newline='')
    c=csv.writer(f)
    c.writerow(data)
    f.close()

    