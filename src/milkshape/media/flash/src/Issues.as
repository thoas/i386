package
{
	import cc.milkshape.issues.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Issues extends MovieClip
	{		
		public function Issues()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			var oGateway:Object = {
				currentIssues: new Array(
					{
						num: 4,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					}
				),
				completeIssues: new Array(
					{
						num: 1,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					},
					{
						num: 2,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					},
					{
						num: 3,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',  
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					},
					{
						num: 4,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',  
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					},
					{
						num: 5,
						title: 'BLACK & WHITE',
						desc: 'Not very hard',
						url: 'assets/currentissue1.jpg',  
						schedule: 'START 27-06-09',
						nbCreators: 9,
						nbIssues: 25
					}
				)
			};
			
			_onResult(oGateway);
			
		}
		
		private function _onResult(o:Object):void
		{
			var issueClp:IssuesClp = new IssuesClp();
			addChild(issueClp);
			var issuePreview:IssuePreview;
			var i:int;
			
			for(i = 0; i < 4; i++)
			{ 
				issuePreview = new IssuePreview(o.currentIssues[i] ? o.currentIssues[i] : null);
				issuePreview.x = i * 239;
				issueClp.currentContainer.addChild(issuePreview);
			}
			
			for(i = 0; i < o.completeIssues.length; i++)
			{
				issuePreview = new IssuePreview(o.completeIssues[i]);
				issuePreview.x = i * 239;
				issueClp.completeContainer.addChild(issuePreview);
			}
		}
	}
	
}