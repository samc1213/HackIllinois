import webapp2
from google.appengine.api import urlfetch
import urllib2
import urllib
import base64
import simplejson as json
import random


MAIN_PAGE_HTML = """\
<html>
  <body>
    <form method="POST" action="/">
        Latitude: <input type=text name="lat">
        Longitude: <input type=text name="long">
    <input type="submit" value="Tell me where you live!">
    </form>
  </body>
</html>
"""


class RandomRestaurant(webapp2.RequestHandler):
    def get(self):
        self.response.write(MAIN_PAGE_HTML)
    def post(self):
        self.response.headers['Content-Type'] = 'text/plain'
        latitude = self.request.get("lat")
        longitude = self.request.get("long")
        factualquery = 'http://api.v3.factual.com/t/restaurants-us?geo={"$circle":{"$center":['
        factualquery += str(latitude)
        factualquery += ","
        factualquery += str(longitude)
        factualquery += '],"$meters":2500}}&KEY=fp1SCfi27hqvFLHF5d55fyXoMCUNAh9V9hL4BD15'
        base64version = base64.b64decode(factualquery)
        #self.response.write(factualquery)
        response = urlfetch.fetch(url = factualquery, method = urlfetch.GET)
        rezult = json.loads(response.content)
        responsedict = rezult['response']
        data = responsedict['data']
        index = random.randint(0, len(data))
        randominlist = data[index]
        name = randominlist['name']
        self.response.write(name)
application = webapp2.WSGIApplication([
    ('/', RandomRestaurant),
], debug=True)
