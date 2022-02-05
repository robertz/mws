<cfscript>
    service = new AmazonService(awsAccessKeyId = "<your access key>", secretKey = "<your secret key>", sellerId = "<your sellerId>");

    // writeDump(var = service.parse(xmlNode = "<envelope><key>value</key></envelope>"));

    // writeDump(var = service.getFeedSubmissionResult({ feedSubmissionId: 12345 }));

    // writeDump(var = service.listMarketplaceParticipations());

    // writeDump(var = service.getServiceStatus());

    writeDump(var = service);

</cfscript>