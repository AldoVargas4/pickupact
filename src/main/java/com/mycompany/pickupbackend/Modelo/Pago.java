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
public class Pago {
    private int idPago;
    private int idPedido;
    private String metodoPago;
    private String estadoPago;
    private Date fechaPago;

    public Pago() {
    }

    public Pago(int idPago, int idPedido, String metodoPago, String estadoPago, Date fechaPago) {
        this.idPago = idPago;
        this.idPedido = idPedido;
        this.metodoPago = metodoPago;
        this.estadoPago = estadoPago;
        this.fechaPago = fechaPago;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }

    public Date getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }
}
