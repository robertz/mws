<cfscript>
    service = new AmazonService(awsAccessKeyId = "<your access key></your>", secretKey = "<your secret key>", sellerId = "<your sellerId>");

    // writeDump(var = service.parse(xmlNode = "<envelope><key>value</key></envelope>"), abort = 1);

    // writeDump(var = service.getFeedSubmissionResultById({ feedSubmissionId: 12345 }), abort = 1);

</cfscript>