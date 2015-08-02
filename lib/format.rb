class Format
  def initialize(file)
    @file = file
  end

  def header
    <<END
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,700,400italic' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="reset.css">
<link rel="stylesheet" type="text/css" href="main.css">

</head>
<body>
END
  end

  def footer
    <<END
</body>
</html>
END
  end

  def wrap
    @file << header
    yield(@file)
    @file << footer
  end

  def section(name)
    @file << "<h2>#{name}</h2>"
  end
end
