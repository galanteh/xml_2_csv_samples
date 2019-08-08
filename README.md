# Samples of complex XML processing
We are processing using XSLT 1.0 some XML that are very complex. Most of them coming from devices like Routers which eventually are more designed to be fast written than to be read easily.
Here are a couple of some real sample processing.

# How to check it?
You can use XSLT processor, in our case, we will use xlstproc as the tool to test them.

```
xsltproc -o results.csv transformation.xsl xml_source_file.xml
```
# Samples
There are two samples from two mayor hardware vendors to use as example of work. 

## Huawei case
In the Huawei case, we use the XSLT processor to convert from large XML files into CSV files. However, we still need to split values from the columns into rows. 
For example, you will get a result like this if you use the version huawei.xsl in the xlst folder

```
2019-01-23T11:00:00-05:00 | 41249367 | SomeDevice/SomeCell:Label=SomeLabel, CellID=1234, LogicRNCID=111 | 67179298 67179299 67179302 67179303 | 134 134 2200 59310 
```  

In this sample, we have the fourth and fifth column with array values. Each value is a type of measurement and it's measure in that specific date time. We still need to split into something more valuable to be into a database table or a datalake columnar file. 
In our case, we will use [Apache NiFi](https://nifi.apache.org/) to do that job, so you can find an example in Groovy of how to split that using an [InvokeScriptProcessor](https://nifi.apache.org/docs/nifi-docs/components/org.apache.nifi/nifi-scripting-nar/1.5.0/org.apache.nifi.processors.script.InvokeScriptedProcessor/index.html).

### XLST that Pivot the Array values
In the version 2 named huawei_v2.xsl you will find a XLST which slower but pivot the array into rows in the CSV. 
To see a quick example of this, you check this simple sample of [how to pivot the array into rows](http://xsltransform.net/pNEhB3o)

## Ericsson case
In this case, the XML is more simple, so the XSLT is also very straight to process because we can obtain the final CSV ready to be inserted into a table. 
