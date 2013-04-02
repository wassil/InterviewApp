package com.wassil.interviewApp.red5;

import java.util.Date;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.scope.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.stream.IPlayItem;
import org.red5.server.api.stream.IPlaylistSubscriberStream;
import org.red5.server.api.stream.ISubscriberStream;
import org.red5.server.api.stream.support.SimplePlayItem;
import org.red5.server.stream.PlaylistSubscriberStream;
public class Application extends ApplicationAdapter {

    @Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
    	System.out.println("connected");
		return true;
	}

    @Override
	public void disconnect(IConnection conn, IScope scope) {
    	System.out.println("disconnected");
		super.disconnect(conn, scope);
	}
    
    public String sayHello(Object[] params){
    	System.out.println("say Hello to "+params[0].toString());
    	return "Hello " + params[0].toString()+"!";
    }
    
    @Override
    public void streamPublishStart(IBroadcastStream stream){
	    try {
	    	System.out.println("saving as "+stream.getPublishedName());
	    	stream.saveAs(stream.getPublishedName(), false);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
    }

    @Override
    public void streamBroadcastClose(IBroadcastStream stream){
    	System.out.print("Broadcast Closed");
    }

    @Override
    public void streamBroadcastStart(IBroadcastStream stream){
    	System.out.print("Broadcast Started");
    	//SimplePlayItem.build(name)
    }
    
    @Override
    public void streamSubscriberStart(ISubscriberStream stream){
    	String name = ((PlaylistSubscriberStream)stream).getItem(0).getName();
    	System.out.println("Subscriber Start "+name);
    }
    
}