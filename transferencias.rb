#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Alex Ballera;  alex@alexballera.com; +584120172898

# Los Clientes del banco MyBank, pueden realizar transferencias hacia sus propias cuentas, 
# o a cuentas a otros personas, sean del banco o de otros bancos. 

# Usted es contratado por el departamento de Tecnología del Banco, y debe realizar el algoritmo del proceso 
# del sistema en ruby para el manejo de Transferencias.

# A a fin de estandarizar los procesos en este ejercicio, 
# los números de cuenta de todos los bancos son de 20 dígitos numéricos, 
# y las transferencias interbancarias se procesan inmediatamente.

# Para que una transferencia pueda ser realizada Los Clientes deben contar con una cuenta en el banco, con saldo suficiente 
# para cubrir el monto de la transferencia, se debe verificar que la cuenta destino cumpla con el standard.

# Luego de realizada la transferencia deben actualizarse los saldos tanto en la cuenta origen como destino. 
# y se debe enviar un mensaje de confirmación de la operación (si fue exitosa o no).

# Los clientes debe contar con la opción de visualizar los saldos de sus cuentas en cualquier momento (antes o después de las transferencias)


class Cliente
	attr_accessor :nombre, :apellido, :cedula, :correo, :direccion, :telefono, :cuenta, :saldo, :transaccion
	
	def initialize nombre, apellido, cedula, correo, direccion, telefono, cuenta, saldo, transaccion
		@nombre = nombre 
		@apellido = apellido 
		@cedula = cedula
		@correo = correo
		@direccion = direccion
		@telefono = telefono
		@cuenta = cuenta
		@saldo = saldo
		@transaccion = transaccion
	end
	
	def clientes cliente
		@clientes = Array.new
		@clientes.push cliente
	end

	def disponibilidad monto
		if monto < saldo
			return true
		else puts "\n Saldo Insuficiente\n"
			return false
		end
	end

	def debito monto
		@saldo = @saldo - monto
	end

	def credito monto
		 @saldo = @saldo + monto
	end

	def saldo_cuenta
		puts "\nSr(a) #{nombre} #{apellido} el saldo de su cuenta es #{saldo}\n"
	end

	def deposito cliente, monto
		if cliente.cuenta.length == 20
			cliente.credito monto
			puts "\nSr(a) #{nombre} #{apellido} ha recibido un depósito por un monto de #{monto}"
			cliente.mensaje monto, transaccion
		else
			puts "\nDepósito Rechazado! Número de Cuenta No Tiene 20 Dígitos\n"
		end
	end

	def retiro cliente, monto
		if cliente.cuenta.length == 20
			cliente.debito monto
			puts "\nSr(a) #{nombre} #{apellido} ha realizado un retiro de su cuenta por un monto de #{monto}"
			cliente.mensaje monto, transaccion
		else
			puts "\nRetiro Rechazado! Número de Cuenta No Tiene 20 Dígitos\n"
		end
	end


	def transferencias cliente1, cliente2, monto
		if cliente1.cuenta.length == 20
			verificar = cliente1.disponibilidad monto
			if verificar == true
				cliente1.debito monto
				puts "\nSr(a) #{nombre} #{apellido} usted ha realizado una transferencia por un monto de #{monto}\n"
				cliente1.mensaje monto, transaccion
				if cliente2.cuenta.length == 20
					verificar = cliente2.disponibilidad monto
					if verificar == true
						cliente2.credito monto
						puts "\nTransferencia recibida por un monto de #{monto}\n"
						cliente2.mensaje monto, transaccion
					end
				else
					puts "Transferecia Rechazada. Número de Cuenta No Tiene 20 Dígitos"
				end
			end
		else
			puts "\nTransferecia Rechazada. Número de Cuenta No Tiene 20 Dígitos\n"
		end
	end

	def mensaje monto, transaccion
		t = Time.new
		r = rand(1000000000..9999999999)
		puts """
BANCO MYBANK
DATOS DE LA TRANSACCIÓN:
Referencia: #{r}
Fecha: #{t}
Nombre: #{nombre}
Apellido: #{apellido}
Cedula: #{cedula}
Cuenta: #{cuenta}
Monto: #{monto}
Saldo: #{saldo}
"""
puts "="*64
	end
end


def main
	cliente1 = Cliente.new "Alex", "Ballera", "8983523", "alex@ballera.com", "caracas", "02123267340", "12345678901234567890", 10000, "deposito"
	cliente2 = Cliente.new "Jose", "Lugo", "18983523", "jose@ballera.com", "caracas", "02123267340", "12345678901234567891", 15000, "deposito"
	cliente3 = Cliente.new "Pedro", "Gonzalez", "10983523", "pedro@ballera.com", "caracas", "02123267340", "12345678901234567892", 25000, "deposito"
	cliente4 = Cliente.new "Juan", "Perez", "11983523", "juan@ballera.com", "caracas", "02123267340", "12345678901234567893", 5000, "deposito"
	cliente5 = Cliente.new "Jose", "Bolivar", "12983523", "jose@ballera.com", "caracas", "02123267340", "12345678901234567894", 6000, "deposito"
	
	cliente1.clientes cliente1
	cliente2.clientes cliente2
	cliente3.clientes cliente3
	cliente4.clientes cliente4
	cliente5.clientes cliente5

	cliente1.transferencias cliente1, cliente2, 5000
	cliente1.deposito cliente1, 10000
	cliente1.retiro cliente1, 500

end
main