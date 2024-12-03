/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pickupbackend.Modelo;

import java.util.Date;
/**
 *
 * @author minay
 */
public class Envio {
    private int idEnvio;
    private int idPedido;
    private String direccionEnvio;
    private String estadoEnvio;
    private Date fechaEnvio;
    private Date fechaEntrega;

    public Envio() {
    }

    public Envio(int idEnvio, int idPedido, String direccionEnvio, String estadoEnvio, Date fechaEnvio, Date fechaEntrega) {
        this.idEnvio = idEnvio;
        this.idPedido = idPedido;
        this.direccionEnvio = direccionEnvio;
        this.estadoEnvio = estadoEnvio;
        this.fechaEnvio = fechaEnvio;
        this.fechaEntrega = fechaEntrega;
    }

    public int getIdEnvio() {
        return idEnvio;
    }

    public void setIdEnvio(int idEnvio) {
        this.idEnvio = idEnvio;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public String getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(String direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }

    public String getEstadoEnvio() {
        return estadoEnvio;
    }

    public void setEstadoEnvio(String estadoEnvio) {
        this.estadoEnvio = estadoEnvio;
    }

    public Date getFechaEnvio() {
        return fechaEnvio;
    }

    public void setFechaEnvio(Date fechaEnvio) {
        this.fechaEnvio = fechaEnvio;
    }

    public Date getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(Date fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }
}
