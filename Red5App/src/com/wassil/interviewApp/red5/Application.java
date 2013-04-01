package com.wassil.interviewApp.red5;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.stream.IBroadcastStream;

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
    }
    

}
