def uuid
  uuid = ""

  uuid = random_hex_times(8)
  uuid += "-" + random_hex_times(4)
  uuid += "-" + random_hex_times(4)
  uuid += "-" + random_hex_times(4)
  uuid += "-" + random_hex_times(12)

  uuid
end

def random_hex
  hex_characters = ('0'..'9').to_a + ('A'..'F').to_a

  hex_characters.sample()
end

def random_hex_times(number)
  hex = ""

  number.times do
    hex += random_hex
  end

  hex
end
