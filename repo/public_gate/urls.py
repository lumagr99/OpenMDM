from django.conf.urls import url
from public_gate import views

urlpatterns = [
    # Base
    url(r'^home/$', views.home, name="home"),
    url(r'^about/$', views.about, name="about"),
    url(r'^contact/$', views.contact, name="contact"),

    # Authentication
    url(r'^login/$', views.site_login, name="site_login"),
    url(r'^logout/$', views.site_logout, name="site_logout"),

    # Property lists
    url(r'^property_list/$', views.property_lists, name="property_lists"),
    url(r'^property_list/(?P<plist_id>[a-z0-9]{24})/$', views.property_list_detail, name='property_list_detail'),
    url(r'^property_list/(?P<plist_id>[a-z0-9]{24})/download/$', views.property_list_download, name='property_list_download'),
    url(r'^user/property_lists/$', views.property_lists_for_user, name='property_lists_for_user'),
    url(r'^property_list/add/$', views.add_property_list, name="property_list_add"),
]
