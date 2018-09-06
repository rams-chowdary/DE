public with sharing class SlackPublisher {
     
    private static final String slackURL = 'https://hooks.slack.com/services/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';
     
    public class Defect{
        @InvocableVariable(label='Operation')
        public String operation;
        @InvocableVariable(label='Record Id')
        public String recordId;
        @InvocableVariable(label='Issue Number')
        public String issueNumber;
        @InvocableVariable(label='Status')
        public String status;
        @InvocableVariable(label='Created or Modified By')
        public String createdOrModBy;
    }
     
    @InvocableMethod(label='Post to Slack')
    public static void postToSlack(List<Defect> defects) {
        Defect d = defects[0]; // If bulk, only post first to avoid overloading Slack channel
        Map<String,Object> msg = new Map<String,Object>();
        String text;
        if(d.operation == 'Insert') {
            text = 'New Defect has created. \n*Defect:* <https://'+URL.getSalesforceBaseUrl().getHost()+'/'+d.recordId+'|'+d.issueNumber+'>\n* with Status:* ' + d.status + '\n*Created By:* '+d.createdOrModBy;
        }
        else if(d.operation == 'Update'){
            text ='The following *Defect:* <https://'+URL.getSalesforceBaseUrl().getHost()+'/'+d.recordId+'|'+d.issueNumber+'> Status has changed.\n*New Status:* ' + d.status +'\n*Modified By:* '+d.createdOrModBy;
        }
        msg.put('text', text);
        msg.put('mrkdwn', true);
        String body = JSON.serialize(msg);    
        System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
    }
     
    public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
         
        private final String url;
        private final String method;
        private final String body;
         
        public QueueableSlackCall(String url, String method, String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
         
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            req.setBody(body);
            Http http = new Http();
            HttpResponse res = http.send(req);
        }
 
    }
    
}