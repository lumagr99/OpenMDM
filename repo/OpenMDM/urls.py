from django.conf.urls import include, url
from django.views.generic import RedirectView
from django.contrib import admin
import public_gate.urls

admin.autodiscover()

urlpatterns = [
    url(r'^public_gate/', include((public_gate.urls, 'public_gate'), namespace='public_gate')),
    url(r'^admin/', admin.site.urls),  # Keine Notwendigkeit mehr, 'include' für admin.urls zu verwenden
    # Stelle sicher, dass keine Endlosschleife durch die RedirectView entsteht
    url(r'^(?!public_gate/home).*$',
        RedirectView.as_view(url='/public_gate/home')),
]