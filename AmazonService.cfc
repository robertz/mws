component {

    function init(required string awsAccessKeyId, required string secretKey, required string sellerId) {
        variables['awsAccessKeyId'] = arguments.awsAccessKeyId;
        variables['secretKey'] = arguments.secretKey;
        variables['sellerId'] = arguments.sellerId
        return this;
    }

    // Private methods

    // generate an Amazon V2 signature
    private string function generateSignedUrl(
        string verb = 'GET',
        string host = '',
        string uri = '/',
        required struct params
    ) {
        var props = {};
        props['now'] = dateConvert('local2Utc', now());
        props['time'] = dateFormat(props.now, 'yyyy-mm-dd') & 'T' & timeFormat(props.now, 'HH:mm:ss');
        props['query'] = [];
        // Process URL params
        urlParams = {
            'AWSAccessKeyId': variables.awsAccessKeyId,
            'Timestamp': props.time,
            'SignatureVersion': 2,
            'SignatureMethod': 'HmacSHA256'
        };
        urlParmas.append(params);
        for (var i in urlParams) {
            props.query.append(i & '=' & encodeRFC3986(urlParams[i]));
        }
        // params should be in natural byte order
        arraySort(props.query, 'text');
        props['queryString'] = arrayToList(props.query, '&');
        props['toEncode'] = arguments.verb & chr(10) & arguments.host & chr(10) & arguments.uri & chr(10) & props.queryString;
        props['signature'] = encodeForURL(
            toBase64(
                binaryDecode(
                    hmac(
                        props.toEncode,
                        variables.secretKey,
                        'HMACSHA256',
                        'UTF-8'
                    ),
                    'hex'
                )
            )
        );
        props['signedURL'] = 'https://' & arguments.host & arguments.uri & '?' & props.queryString & '&Signature=' & props.signature;
        return props.signedURL;
    }

    private string function encodeRFC3986(required string str) {
        return encodeForURL(arguments.str)
            .replace('%7E', '~', 'all')
            .replace('+', '%20', 'all')
            .replace('*', '%2A', 'all');
    }

    private array function chunk(required array input, required numeric chunkSize) {
        var out = [];
        var ceil = ceiling(input.len() / chunkSize);
        for (var i = 1; i <= ceil; i++) {
            var t = [];
            var offset = (i - 1) * chunkSize;
            if (i == ceil) {
                var c = input.len() - offset < chunkSize ? input.len() - offset : chunkSize;
                for (var x = 1; x <= c; x++) {
                    t.append(input[offset + x]);
                }
            } else {
                for (var x = 1; x <= chunkSize; x++) {
                    t.append(input[offset + x]);
                }
            }
            out.append(t);
        }
        return out;
    }

    function parse(required string xmlNode) {
        // this works on lucee with the included jar
        var obj = createObject('java', 'org.json.XML', expandPath('org.json-20161124.jar'));
        return deserializeJSON(obj.toJSONObject(xmlNode));
    }

}
