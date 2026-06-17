package util;

import org.apache.commons.mail2.jakarta.DefaultAuthenticator;
import org.apache.commons.mail2.jakarta.HtmlEmail;

public class servicioemail {

    public boolean enviarRespuesta(
        String destino,
        String nombre,
        String asuntoConsulta,
        String mensajeConsulta,
        String respuesta) {

        try {

            HtmlEmail email = new HtmlEmail();
            email.setHostName("smtp.gmail.com");

            email.setSmtpPort(465);

            email.setAuthenticator(
                    new DefaultAuthenticator(
                            "reinadeldulceysabor@gmail.com",
                            "pssybfranxqgvinf"
                    )
            );
            email.setSSLOnConnect(true);

            email.setFrom(
                    "reinadeldulceysabor@gmail.com",
                    "Cora System"
            );

            email.addTo(destino);

            email.setSubject("Respuesta a tu consulta");

            String html =
                "<div style='background:#f5f1ec;padding:40px;font-family:Georgia,serif;'>" +

                    "<div style='max-width:700px;margin:auto;background:#ffffff;" +
                    "border-radius:12px;overflow:hidden;" +
                    "box-shadow:0 4px 20px rgba(0,0,0,0.08);'>" +

                        "<div style='background:#e6c2bf;padding:25px;text-align:center;'>" +
                            "<h1 style='margin:0;color:#4a4a4a;'>Cora</h1>" +
                            "<p style='margin-top:8px;color:#5d544b;'>Respuesta a tu consulta</p>" +
                        "</div>" +

                        "<div style='padding:30px;'>" +

                            "<h2 style='color:#7c6753;'>Hola " + nombre + "</h2>" +

                            "<p style='color:#5d544b;font-size:15px;'>" +
                            "Gracias por comunicarte con nosotros. Hemos revisado tu mensaje y te enviamos la siguiente respuesta." +
                            "</p>" +

                            "<div style='background:#faf8f5;border-left:5px solid #a68b6d;" +
                            "padding:15px;margin:25px 0;border-radius:6px;'>" +

                                "<h3 style='color:#7c6753;margin-top:0;'>Tu consulta</h3>" +

                                "<p><strong>Asunto:</strong> "
                                + asuntoConsulta + "</p>" +

                                "<p><strong>Mensaje:</strong><br>"
                                + mensajeConsulta + "</p>" +

                            "</div>" +

                            "<div style='background:#f2dfdd;" +
                            "padding:20px;border-radius:8px;'>" +

                                "<h3 style='margin-top:0;color:#B1564E;'>" +
                                "Nuestra respuesta</h3>" +

                                "<p style='color:#4a4a4a;line-height:1.7;'>" +
                                respuesta +
                                "</p>" +

                            "</div>" +

                            "<p style='margin-top:30px;color:#5d544b;'>" +
                            "Si tienes alguna otra consulta estaremos encantados de ayudarte." +
                            "</p>" +

                            "<p style='color:#7c6753;'>" +
                            "<strong>Equipo Cora</strong>" +
                            "</p>" +

                        "</div>" +

                        "<div style='background:#f5f1ec;padding:15px;text-align:center;" +
                        "font-size:12px;color:#7c6753;'>" +

                            "Este correo fue enviado automaticamente desde Cora." +

                        "</div>" +

                    "</div>" +

                "</div>";

                email.setHtmlMsg(html);

            email.send();

            return true;

        } catch (Exception e) {
            e.printStackTrace();

            Throwable causa = e.getCause();
            while (causa != null) {
                System.out.println("CAUSA: " + causa);
                causa = causa.getCause();
            }

            return false;
        }
    }
}