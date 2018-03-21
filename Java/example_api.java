// Author: Markus Solbach (polyhedral@eecs.yorku.ca)

// Uses Java-WebSocket: https://github.com/TooTallNate/Java-WebSocket
import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft_6455;
import org.java_websocket.handshake.ServerHandshake;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Base64;
import java.util.UUID;

import static java.lang.Thread.sleep;

public class Main {

    public static void main(String[] args) throws URISyntaxException, JSONException, InterruptedException {
        WebSocketClient ws = new WebSocketClient(new URI("wss://polyhedral.eecs.yorku.ca/api/"), new Draft_6455()) {
            @Override
            public void onMessage(String message) {
                JSONObject obj = null;
                try {
                    obj = new JSONObject(message);
                    String status = obj.getString("status");
                    System.out.println("Status: " + status);
                    if (status.equals("SUCCESS")) {
                        System.out.println(obj);
                        String pathFile = UUID.randomUUID().toString() + ".png";
                        String image_base64 = obj.getString("image");
                        try (FileOutputStream imageOutFile = new FileOutputStream(pathFile)) {
                            byte[] imageByteArray = Base64.getDecoder().decode(image_base64);
                            imageOutFile.write(imageByteArray);
                        } catch (FileNotFoundException e) {
                            System.out.println("File not found" + e);
                        } catch (IOException ioe) {
                            System.out.println("Exception while writing the Image " + ioe);
                        }

                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onOpen(ServerHandshake handshake) {
                System.out.println("opened connection");
            }

            @Override
            public void onClose(int code, String reason, boolean remote) {
                System.out.println("closed connection");
            }

            @Override
            public void onError(Exception ex) {
                ex.printStackTrace();
            }

        };

        ws.connect();
        JSONObject obj = new JSONObject();
        obj.put("ID", "YOUR ID HERE");
        obj.put("light_fixed", "true");
        obj.put("random_cam", "true");
        obj.put("cam_x", -0.911);
        obj.put("cam_y", 1.238);
        obj.put("cam_z", -4.1961);
        obj.put("cam_qw", -0.0544);
        obj.put("cam_qx", -0.307);
        obj.put("cam_qy", 0.9355);
        obj.put("cam_qz", 0.16599);
        String message = obj.toString();
        boolean sent = true, spin = true;
        while (spin) {
            sleep(500);
            if ((ws.getReadyState() == ws.getReadyState().OPEN) && sent) {
                ws.send(message);
                sent = false;
            }
            if (ws.getReadyState() == ws.getReadyState().CLOSED) {
                spin = false;
            }
        }
        ws.close();
    }
}