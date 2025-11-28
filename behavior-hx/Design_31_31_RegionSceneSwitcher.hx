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
import box2D.collision.shapes.B2Shape;

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



class Design_31_31_RegionSceneSwitcher extends SceneScript
{
	public var _Region:Region;
	public var _Scene:Scene;
	public var _RegionSceneList:Array<Dynamic>;
	public var _Entry:Array<Dynamic>;
	public var _RegionID:Float;
	public var _SceneName:String;
	public var _X:Float;
	public var _Y:Float;
	public var _ActorType:ActorType;
	public var _OnlySwitchOnKeyPress:Bool;
	public var _SwitchControl:String;
	public var _InRegion:Bool;
	public var _Done:Bool;
	public var _OutTime:Float;
	public var _InTime:Float;
	public var _TransitionStyle:String;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_SwitchScene():Void
	{
		if(!(isTransitioning()))
		{
			if((_Entry.length >= 4))
			{
				_X = asNumber(Std.parseFloat("" + _Entry[Std.int(2)]));
				propertyChanged("_X", _X);
				_Y = asNumber(Std.parseFloat("" + _Entry[Std.int(3)]));
				propertyChanged("_Y", _Y);
				createActorInNextScene(_ActorType, _X, _Y, Script.FRONT);
			}
			if((_TransitionStyle == "Fade"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createFadeOut(_OutTime), createFadeIn(_InTime));
			}
			else if((_TransitionStyle == "Blinds"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createBlindsOut(_OutTime), createBlindsIn(_InTime));
			}
			else if((_TransitionStyle == "Bubbles"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createBubblesOut(_OutTime), createBubblesIn(_InTime));
			}
			else if((_TransitionStyle == "Spotlight"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createCircleOut(_OutTime), createCircleIn(_InTime));
			}
			else if((_TransitionStyle == "Blur"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createPixelizeOut(_OutTime), createPixelizeIn(_InTime));
			}
			else if((_TransitionStyle == "Box"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), createRectangleOut(_OutTime), createRectangleIn(_InTime));
			}
			else if((_TransitionStyle == "Crossfade"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createCrossfadeTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Up"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideUpTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Down"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideDownTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Left"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideLeftTransition(_OutTime));
			}
			else if((_TransitionStyle == "Slide Right"))
			{
				switchScene(GameModel.get().scenes.get(getIDForScene(_SceneName)).getID(), null, createSlideRightTransition(_OutTime));
			}
		}
	}
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Region", "_Region");
		nameMap.set("Scene", "_Scene");
		nameMap.set("Region Scene List", "_RegionSceneList");
		_RegionSceneList = [];
		nameMap.set("Entry", "_Entry");
		_Entry = [];
		nameMap.set("Region ID", "_RegionID");
		_RegionID = 0.0;
		nameMap.set("Scene Name", "_SceneName");
		_SceneName = "";
		nameMap.set("X", "_X");
		_X = 0.0;
		nameMap.set("Y", "_Y");
		_Y = 0.0;
		nameMap.set("Actor Type", "_ActorType");
		nameMap.set("Only Switch On Key Press", "_OnlySwitchOnKeyPress");
		_OnlySwitchOnKeyPress = false;
		nameMap.set("Switch Control", "_SwitchControl");
		nameMap.set("In Region", "_InRegion");
		_InRegion = false;
		nameMap.set("Done", "_Done");
		_Done = false;
		nameMap.set("Out Time", "_OutTime");
		_OutTime = 0.5;
		nameMap.set("In Time", "_InTime");
		_InTime = 0.5;
		nameMap.set("Transition Style", "_TransitionStyle");
		_TransitionStyle = "";
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_InRegion = false;
				propertyChanged("_InRegion", _InRegion);
				if(((hasValue(_ActorType)) && !(isTransitioning())))
				{
					for(actorOfType in getActorsOfType(_ActorType))
					{
						if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
							for(item in cast(_RegionSceneList, Array<Dynamic>))
							{
								_Entry = ("" + item).split(",");
								propertyChanged("_Entry", _Entry);
								if((_Entry.length >= 2))
								{
									_RegionID = asNumber(Std.parseFloat("" + _Entry[Std.int(0)]));
									propertyChanged("_RegionID", _RegionID);
									_SceneName = ("" + _Entry[Std.int(1)]);
									propertyChanged("_SceneName", _SceneName);
									_Region = engine.getRegion(Std.int(_RegionID));
									propertyChanged("_Region", _Region);
									if(isInRegion(actorOfType, _Region))
									{
										if(_OnlySwitchOnKeyPress)
										{
											_InRegion = true;
											propertyChanged("_InRegion", _InRegion);
										}
										else
										{
											_customEvent_SwitchScene();
										}
										_Done = true;
										propertyChanged("_Done", _Done);
										break;
									}
								}
							}
							if(_Done)
							{
								break;
							}
						}
					}
				}
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener(_SwitchControl, function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if((_OnlySwitchOnKeyPress && _InRegion))
				{
					_customEvent_SwitchScene();
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}