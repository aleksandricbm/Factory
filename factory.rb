class Facktor
	
	def self.new(*args, &block)
		Class.new do
			args.each { |k| attr_accessor k }
			define_method :initialize do |*h|
				h.each_with_index { |key,val| instance_variable_set("@#{args[val]}",key)}
			end

			class_eval &block if block_given?
		
			def [] (arg)
					if arg.is_a?(Integer)
						instance_variable_get(Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ].keys[arg])
					else 
						instance_variable_get("@#{arg}")
					end
			end
		end
	end
end

Cccc=Facktor.new(:name,:email,:phone)

su=Cccc.new("Namess","EMAILSSS","phone number")
puts su.instance_variables
puts su.inspect
puts su.name
puts su['email']
puts su[:phone]
puts su[1]

Customer = Facktor.new(:name, :address) do
  def greeting
    puts "Hello #{name}!"
  end
end

Customer.new('Aleks', '123@yaya.ua').greeting
