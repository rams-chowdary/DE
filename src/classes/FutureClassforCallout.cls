global class FutureClassforCallout {

    @future (callout=true)
    public static void createWaterMarkFutureCallout(Id custObjRecId) { 
        List<RamsChowdary__Custom__c> custObjList = [Select RamsChowdary__Watermark__c from RamsChowdary__Custom__c where Id =: custObjRecId];
        if(!custObjList.isEmpty()){     
            String watermark = EncodingUtil.urlEncode(custObjList[0].RamsChowdary__Watermark__c,'UTF-8');
                        
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://api.img4me.com/?text='+watermark+'&font=arial&fcolor=ED6A42&size=34&bcolor=FFFFFF&type=png');
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());
            string imageURL = res.getBody();
            
            Http h = new Http(); 
            HttpRequest req1 = new HttpRequest(); 
            string firstImageURL = res.getBody(); 
            //Replace any spaces with %20 
            firstImageURL = firstImageURL.replace(' ', '%20'); 
            req.setEndpoint(firstImageURL); 
            req.setMethod('GET'); 
            req.setHeader('Content-Type', 'image/png'); 
            req.setCompressed(true); 
            req.setTimeout(60000); 
            HttpResponse res1 = null; 
            res1 = h.send(req);  
            string responseValue = ''; 
            responseValue = res1.getBody(); 
            system.debug('Response Body for File: ' + responseValue); 
            //This is the line that does the magic. We can get the blob of our file. This getBodyAsBlob method was added in the Spring 2012 release and version 24 of the API. 
            blob image = res1.getBodyAsBlob(); 
            
            Attachment n = new Attachment(); 
            n.ParentId = custObjList[0].id; 
            n.Name = 'Watermark'+string.valueOfGmt(datetime.now())+'.png'; 
            n.Body = image;
            //n.Body = blob.valueOf(EncodingUtil.base64Encode(image)); 
            system.debug(n.Body);
            n.contentType = 'image/png'; 
            insert n;
        }     
    }
}