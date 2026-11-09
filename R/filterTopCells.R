#'  Orders the cells by decreasing library size and keeps only the first n cells 
#'  @param input_file Il nome del file di input in formato CSV
#'  @param output_file Il nome del file CSV in cui salvare la matrice filtrata
#'  @param n Il numero di celle che si vogliono tenere nella matrice filtrata
#'  @return Riporta n, il numero di righe e il numero di colonne rimaste 
#'  @export
filterTopCells <- function(input_file, output_file, n)  {
  
  mat <- as.matrix(read.csv(input_file, header = TRUE, row.names = 1))
  
  library_size <- colSums(mat)    #form olumn sums for data frames, quindi per ogni colonna mi dà la somma totale dei conteggi
  
  library_ordinata <- order(library_size, na.last =TRUE , decreasing = TRUE)   #quale colonna ha la library size maggiore? 
  
  if (n >= ncol(mat)) {
    mat_filtrata <- mat    #la riporto uguale se n è uguale o maggiore al numero di colonne della matrice importata
    n_cells_kept <- ncol(mat)
  } else {
    mat_filtrata <- mat[, library_ordinata[1:n], drop = FALSE]
    n_cells_kept <- n
  }
  
  n_genes <- nrow(mat_filtrata)
  n_cells <- ncol(mat_filtrata)
  
  write.csv(mat_filtrata, file = output_file)

  return(list(n_cells_kept = n_cells_kept, n_genes = n_genes, n_cells = n_cells))
  
}
