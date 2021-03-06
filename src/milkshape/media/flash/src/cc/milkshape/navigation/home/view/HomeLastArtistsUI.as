package cc.milkshape.navigation.home.view
{
    import cc.milkshape.framework.buttons.SmallButton;
    import cc.milkshape.navigation.generic.UIList;
    import cc.milkshape.navigation.generic.PrivateEventList;
    import cc.milkshape.navigation.home.view.buttons.HomeArtistButtonUI;

    import com.bourre.events.EventBroadcaster;
    import com.bourre.events.ObjectEvent;
    import com.bourre.ioc.bean.BeanFactory;
    import com.bourre.plugin.Plugin;
    import com.bourre.view.AbstractView;

    import flash.events.MouseEvent;
    public class HomeLastArtistsUI extends AbstractView
    {
        private var _allArtistBtn:SmallButton;

        public function HomeLastArtistsUI(owner:Plugin = null, name:String = null)
        {
            super(owner, name, new HomeLastArtistsClp());
        }

        public function init(a:Array):void
        {
            var decalX:int = 0;
            var decalY:int = 0;
            var artistButton:HomeArtistButtonUI;
            
            for each(var o:Object in a) {
                artistButton = new HomeArtistButtonUI(o, getOwner(), UIList.HOME_ARTISTS_BUTTON + "_" + o.user.username);
                if(decalX + artistButton.view.width > 225) {
                    decalX = 0;
                    decalY += 20;
                }
                artistButton.view.y = decalY;
                artistButton.view.x = decalX;
                decalX += artistButton.view.width + 10; 
                (view as HomeLastArtistsClp).preview1.addChild(artistButton.view);
            }
            
            _allArtistBtn = new SmallButton(BeanFactory.getInstance().locate('ALL_ARTISTS') as String, new PlusItem());
            _allArtistBtn.addEventListener(MouseEvent.CLICK, _clickHandler);
            (view as HomeLastArtistsClp).allArtists.addChild(_allArtistBtn);        
        }

        private function _clickHandler(e:MouseEvent):void
        {
            EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(PrivateEventList.loadApplication, {
                url: BeanFactory.getInstance().locate('ARTISTS_SWF') as String
            }));
        }
    }
}