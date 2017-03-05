-- See: http://www.andre-simon.de/doku/highlight/en/langs.php

set exts to {"actionscript", "applescript", "assembler", "c", "clojure", "cobol", "csharp", "css", "diff", "erlang", "go", "haskell", "html", "ini", "java", "js", "json", "lisp", "lua", "make", "matlab", "md", "mssql", "nginx", "ocaml", "pdf", "perl", "php", "python", "ruby", "scala", "scss", "sh", "sql", "svg", "swift", "txt", "xml", "yaml"}

choose from list exts with title "Select syntax" with prompt "Please select the syntax to use for highlighting" default items {"js"} without multiple selections allowed and empty selection allowed

return the result as string
