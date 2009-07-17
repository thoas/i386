package cc.milkshape.navigation.about
{
    import cc.milkshape.framework.remoting.ProxyService;
    import cc.milkshape.navigation.about.view.ContactFormUI;
    import cc.milkshape.navigation.about.cmd.OnSubmitContactFormUI;
    import cc.milkshape.navigation.generic.PluginsServiceList;
    import cc.milkshape.navigation.generic.PrivateEventList;
    import cc.milkshape.navigation.generic.UIList;

    import com.bourre.plugin.AbstractPlugin;

    import flash.display.MovieClip;
    public class AboutPlugin extends AbstractPlugin
    {
        private var _container:MovieClip;

        public function AboutPlugin(container:MovieClip)
        {
            _container = container;
            ProxyService.getInstance().registerService(PluginsServiceList.ABOUT, new AboutPluginService(ProxyService.getInstance().gatewayURL));
            getController().pushCommandClass(PrivateEventList.onSubmitContactFormUI, OnSubmitContactFormUI);
            var contactFormUI:ContactFormUI = new ContactFormUI(this, UIList.CONTACT_FORM, container);
            contactFormUI.setSubmit(contactFormUI.getWidget('submit'), PrivateEventList.onSubmitContactFormUI);
        }
    }
}