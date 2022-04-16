import tinify


tinify.key = "SkJZTmVVPTs21vPSqmWw1mVTZcZhjSKP"
source = tinify.from_file("./b.jpg")
source.to_file("./a.jpg")

