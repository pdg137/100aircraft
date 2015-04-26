class Format
  def header
    <<END
<html>
<head>
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
end
