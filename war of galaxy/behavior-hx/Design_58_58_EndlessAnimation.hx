package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_58_58_EndlessAnimation extends ActorScript
{
	public var _AnimationList:Array<Dynamic>;
	public var _Entry:Array<Dynamic>;
	public var _CurrentAnimationPrefix:String;
	public var _Parts:Array<Dynamic>;
	public var _CurrentAnimationIndex:Float;
	public var _LastFrameDuration:Float;
	public var _Waiting:Bool;
	public var _DefaultMode:String;
	public var _Reverse:Bool;
	public var _LastAnimationIndex:Float;
	public var _FirstAnimationIndex:Float;
	public var _CurrentMode:String;
	public var _CurrentFrame:Float;
	public var _CurrentAnimation:String;
	public var _NextAnimationIndex:Float;
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SwitchEndlessAnimation(__animation:String):Void
	{
		var __Self:Actor = actor;
		if(!(("" + ("" + __animation)).split("-")[Std.int(0)] == ("" + ("" + actor.getAnimation())).split("-")[Std.int(0)]))
		{
			actor.setAnimation("" + __animation);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Animation List", "_AnimationList");
		_AnimationList = [];
		nameMap.set("Entry", "_Entry");
		_Entry = [];
		nameMap.set("Current Animation Prefix", "_CurrentAnimationPrefix");
		_CurrentAnimationPrefix = "";
		nameMap.set("Parts", "_Parts");
		_Parts = [];
		nameMap.set("Current Animation Index", "_CurrentAnimationIndex");
		_CurrentAnimationIndex = 0.0;
		nameMap.set("Last Frame Duration", "_LastFrameDuration");
		_LastFrameDuration = 0.0;
		nameMap.set("Waiting", "_Waiting");
		_Waiting = false;
		nameMap.set("Default Mode", "_DefaultMode");
		_DefaultMode = "";
		nameMap.set("Reverse", "_Reverse");
		_Reverse = false;
		nameMap.set("Last Animation Index", "_LastAnimationIndex");
		_LastAnimationIndex = 0.0;
		nameMap.set("First Animation Index", "_FirstAnimationIndex");
		_FirstAnimationIndex = 0.0;
		nameMap.set("Current Mode", "_CurrentMode");
		_CurrentMode = "";
		nameMap.set("Current Frame", "_CurrentFrame");
		_CurrentFrame = 0.0;
		nameMap.set("Current Animation", "_CurrentAnimation");
		nameMap.set("Next Animation Index", "_NextAnimationIndex");
		_NextAnimationIndex = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((!(_Waiting) && (actor.getCurrentFrame() == (actor.getNumFrames() - 1))))
				{
					_CurrentAnimation = actor.getAnimation();
					propertyChanged("_CurrentAnimation", _CurrentAnimation);
					_CurrentFrame = asNumber(actor.getCurrentFrame());
					propertyChanged("_CurrentFrame", _CurrentFrame);
					_Parts = ("" + ("" + _CurrentAnimation)).split("-");
					propertyChanged("_Parts", _Parts);
					if((_Parts.length == 2))
					{
						_CurrentAnimationPrefix = _Parts[Std.int(0)];
						propertyChanged("_CurrentAnimationPrefix", _CurrentAnimationPrefix);
						_CurrentAnimationIndex = asNumber(_Parts[Std.int(1)]);
						propertyChanged("_CurrentAnimationIndex", _CurrentAnimationIndex);
						for(item in cast(_AnimationList, Array<Dynamic>))
						{
							_Entry = ("" + item).split(",");
							propertyChanged("_Entry", _Entry);
							if(((_Entry.length >= 3) && (_CurrentAnimationPrefix == _Entry[Std.int(0)])))
							{
								_Waiting = true;
								propertyChanged("_Waiting", _Waiting);
								_LastFrameDuration = asNumber((actor.currAnimation.getFrameDurations()[Std.int((actor.getNumFrames() - 1))] / 1000));
								propertyChanged("_LastFrameDuration", _LastFrameDuration);
								runLater(1000 * _LastFrameDuration, function(timeTask:TimedTask):Void {
									_Waiting = false;
									propertyChanged("_Waiting", _Waiting);
									if(((_CurrentAnimation == actor.getAnimation()) && (_CurrentFrame == actor.getCurrentFrame())))
									{
										_Parts = ("" + ("" + actor.getAnimation())).split("-");
										propertyChanged("_Parts", _Parts);
										if((_Parts.length == 2))
										{
											_CurrentAnimationPrefix = _Parts[Std.int(0)];
											propertyChanged("_CurrentAnimationPrefix", _CurrentAnimationPrefix);
											_CurrentAnimationIndex = asNumber(_Parts[Std.int(1)]);
											propertyChanged("_CurrentAnimationIndex", _CurrentAnimationIndex);
											for(item in cast(_AnimationList, Array<Dynamic>))
											{
												_Entry = ("" + item).split(",");
												propertyChanged("_Entry", _Entry);
												if(((_Entry.length >= 3) && (_CurrentAnimationPrefix == _Entry[Std.int(0)])))
												{
													_FirstAnimationIndex = asNumber(_Entry[Std.int(1)]);
													propertyChanged("_FirstAnimationIndex", _FirstAnimationIndex);
													_LastAnimationIndex = asNumber(_Entry[Std.int(2)]);
													propertyChanged("_LastAnimationIndex", _LastAnimationIndex);
													if((_Entry.length >= 4))
													{
														_CurrentMode = _Entry[Std.int(3)];
														propertyChanged("_CurrentMode", _CurrentMode);
													}
													else
													{
														_CurrentMode = _DefaultMode;
														propertyChanged("_CurrentMode", _CurrentMode);
													}
													if((_CurrentMode == "Reverse"))
													{
														if(_Reverse)
														{
															if((_CurrentAnimationIndex == _FirstAnimationIndex))
															{
																_NextAnimationIndex = asNumber((_FirstAnimationIndex + 1));
																propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
																_Reverse = false;
																propertyChanged("_Reverse", _Reverse);
															}
															else
															{
																_NextAnimationIndex = asNumber((_CurrentAnimationIndex - 1));
																propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
															}
														}
														else
														{
															if((_CurrentAnimationIndex == _LastAnimationIndex))
															{
																_NextAnimationIndex = asNumber((_LastAnimationIndex - 1));
																propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
																_Reverse = true;
																propertyChanged("_Reverse", _Reverse);
															}
															else
															{
																_NextAnimationIndex = asNumber((_CurrentAnimationIndex + 1));
																propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
															}
														}
													}
													else if(((_CurrentMode == "Loop") && (_CurrentAnimationIndex == _LastAnimationIndex)))
													{
														_NextAnimationIndex = asNumber(_FirstAnimationIndex);
														propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
													}
													else
													{
														_NextAnimationIndex = asNumber((_CurrentAnimationIndex + 1));
														propertyChanged("_NextAnimationIndex", _NextAnimationIndex);
													}
													actor.setAnimation("" + ("" + (("" + _CurrentAnimationPrefix) + ("" + (("" + "-") + ("" + ("" + _NextAnimationIndex)))))));
													break;
												}
											}
										}
									}
								}, actor);
								break;
							}
						}
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}