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
public class EstadoPedido {
    private int idEstado;
    private int idPedido;
    private String estado;
    private Date fechaActualizacion;

    public EstadoPedido() {
    }

    public EstadoPedido(int idEstado, int idPedido, String estado, Date fechaActualizacion) {
        this.idEstado = idEstado;
        this.idPedido = idPedido;
        this.estado = estado;
        this.fechaActualizacion = fechaActualizacion;
    }

    public int getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(int idEstado) {
        this.idEstado = idEstado;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFechaActualizacion() {
        return fechaActualizacion;
    }

    public void setFechaActualizacion(Date fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }
}
