template = File.read("_category.template")
Dir.glob("*.liquid") { |file|
    category = File.basename(file, ".liquid")
    output = template.gsub("@cat@", category)
    File.open(file, "w") { |file| file.write(output) }
}
