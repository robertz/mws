<cfscript>
    service = new AmazonService(awsAccessKeyId = "<your access key></your>", secretKey = "<your secret key>", sellerId = "<your sellerId>");

    writeDump(var = service.parse(xmlNode = "<envelope><key>value</key></envelope>"), abort = 1);
</cfscript>