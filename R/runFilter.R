#'  Avvia un container Docker per eseguire una funzione R su una matrice CSV
#'  @param directory La cartella del computer dove si trovano i file e la matrice
#'  @param input_name Il nome del file du input
#'  @param output_name Il nome del file di output
#'  @return Il codice di stato del comando di sistema
#'  @export
runFilter <- function(directory, input_name, output_name=NULL, n) {
  
  dir_path <- sprintf('"%s"', normalizePath(directory, winslash = "/"))
  
  
  if (is.null(output_name)) {
    stop("E' necessario nominare il file di output")
  } else {
    cmd <- sprintf("docker run --rm -v %s:/data -w /data myimage %s %s %s",
                   dir_path, input_name, output_name, n)
  }
  
  
  system(cmd)
}