def generate_username1 (name)
  name[0].downcase
end

def generate_username2 (first_name, last_name)
  if first_name.empty? then return nil end
  if last_name.empty? then return nil end
  first_name = first_name.gsub(" ","")
  last_name = last_name.gsub(" ","")
  first_name = first_name.gsub(/(\W|\s|\d)/,"")
  last_name = last_name.gsub(/(\W|\s|\d)/,"")
  first_name[0].downcase + last_name.downcase
end

def generate_username3 (first_name, last_name, birth_year)
  if birth_year.to_s.length != 4 then return nil end
  generate_username2(first_name, last_name) + birth_year.to_s[-2..-1]
end

def check_privilege(index=0)
  ["user", "seller", "manager", "admin"][index]
end

def generate_username4 (first_name, last_name, birth_year, privilege_level=0)
  if privilege_level == 0
    generate_username3(first_name, last_name, birth_year)
  else
    check_privilege(privilege_level) + "-" + generate_username3(first_name, last_name, birth_year)
  end
end

$usernames = []
def generate_username5 (first_name, last_name, birth_year)
  username = generate_username3(first_name, last_name, birth_year)
  c = $usernames.count{ |x| x[username]}
  username = c!=0 ? username + "_" + c.to_s : username
  $usernames.push(username)
  username
end

def generate_username6 (first_name, last_name, birth_year)
  c = 0
  usernames = []
  File.read("./usernames.txt").each_line { |line| usernames.push(line.gsub("\n",""))}
  username = generate_username3(first_name, last_name, birth_year)
  c = usernames.count{ |x| x[username]}
  username = c!=0 ? username + "_" + c.to_s : username
  usernames.push(username)
  File.open("./usernames.txt", "w+") do |f| f.puts(usernames) end
  username
end

input = []
["First Name: ","Last Name:  ","Birth Year: "].each_with_index {|x,i|
  if (not ARGV[i])
    print x
    input[i] = STDIN.gets.chomp
  else
    input[i] = ARGV[i]
  end
}

print "Your username is: "
p generate_username6(input[0],input[1],input[2])
