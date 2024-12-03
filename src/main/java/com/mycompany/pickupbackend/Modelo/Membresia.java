/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pickupbackend.Modelo;

/**
 *
 * @author minay
 */
public class Membresia {
    private int idMembresia;
    private String tipoMembresia;
    private double descuentoEnvio;
    private double precioEspecial;

    public Membresia() {
    }

    public Membresia(int idMembresia, String tipoMembresia, double descuentoEnvio, double precioEspecial) {
        this.idMembresia = idMembresia;
        this.tipoMembresia = tipoMembresia;
        this.descuentoEnvio = descuentoEnvio;
        this.precioEspecial = precioEspecial;
    }

    public int getIdMembresia() {
        return idMembresia;
    }

    public void setIdMembresia(int idMembresia) {
        this.idMembresia = idMembresia;
    }

    public String getTipoMembresia() {
        return tipoMembresia;
    }

    public void setTipoMembresia(String tipoMembresia) {
        this.tipoMembresia = tipoMembresia;
    }

    public double getDescuentoEnvio() {
        return descuentoEnvio;
    }

    public void setDescuentoEnvio(double descuentoEnvio) {
        this.descuentoEnvio = descuentoEnvio;
    }

    public double getPrecioEspecial() {
        return precioEspecial;
    }

    public void setPrecioEspecial(double precioEspecial) {
        this.precioEspecial = precioEspecial;
    }
}
