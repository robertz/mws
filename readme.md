### MWS: Component for working with Amazon MWS

This is the base service for testing Amazon MWS integration. Creating a new instance of AmazonService requires three parameters:

``` cfml
service = new AmazonService(awsAccessKeyId = "<your access key>", secretKey = "<your secret key>", sellerId = "<your sellerId>");

writeDump(var = service.listMarketplaceParticipations());

```

I am using the org.json.XML library to quickly convert XML to a ColdFusion struct which is easy to load using Lucee. If you are running Adobe ColdFusion you will need to add the 
library to your class path or write your own XML parser.