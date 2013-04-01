package com.wassil.interviewApp.red5;

import java.util.Date;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.scope.IScope;
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
	    	Date date = new Date();
	    	stream.saveAs("../videos/"+Long.toString((date.getTime()/1000)), false);
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
