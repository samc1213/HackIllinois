import webapp2
from google.appengine.api import urlfetch
import urllib2

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
        factualquery = 'http://api.v3.factual.com/t/places?filters={"name":"Stand"}&geo={"$circle":{"$center":['
        factualquery += latitude
        factualquery += ", "
        factualquery += longitude
        factualquery += '],"$meters":2500}}&KEY=fp1SCfi27hqvFLHF5d55fyXoMCUNAh9V9hL4BD15'

        #payload=None,
        #method=urlfetch.GET)
        self.response.write(factualquery)




application = webapp2.WSGIApplication([
    ('/', RandomRestaurant),
], debug=True)
