package com.mycompany.pickupbackend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
        .csrf().disable()
        .authorizeRequests()
            .antMatchers("/register.jsp", "/login.jsp", "/css/**", "/js/**", "/img/**").permitAll()
            .anyRequest().authenticated();
            // .and()
            // .formLogin()
            //     .loginPage("/login.jsp") // Página de inicio de sesión personalizada
            //     .loginProcessingUrl("/login") // Procesa el formulario
            //     .defaultSuccessUrl("/index.jsp", true) // Redirige al inicio tras login
            //     .failureUrl("/login.jsp?error=true") // Redirige a login si hay error
            //     .permitAll()
            // .and()
            // .logout()
            //     .logoutUrl("/logout")
            //     .logoutSuccessUrl("/login.jsp?logout")
            //     .permitAll();

    return http.build();
    }

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.mariadb.jdbc.Driver");
        dataSource.setUrl("jdbc:mariadb://localhost:3306/pick_up");
        dataSource.setUsername("root");
        dataSource.setPassword("root");
        return dataSource;
    }

    @Bean
    public UserDetailsService userDetailsService(DataSource dataSource) {
        JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);
        manager.setUsersByUsernameQuery("SELECT email, password, true FROM usuarios WHERE email = ?");
        manager.setAuthoritiesByUsernameQuery("SELECT u.email, r.nombre_rol FROM usuarios u JOIN roles r ON u.id_rol = r.id_rol WHERE u.email = ?");
        return manager;
    }
}
