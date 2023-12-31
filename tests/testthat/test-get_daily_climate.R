
test_that("downloading several variables gives expected results from v3", {

  # Testing for 2 sites and a single day

  skip_on_cran()
  skip_on_ci()
  skip_if_not(suppressWarnings(check_server(verbose = FALSE)))

  ## Input matrix
  coords.mat <- matrix(c(-5.36, 37.40, -5.5, 37.5), ncol = 2, byrow = TRUE)

  # ## Output data.frame
  expect_identical(
    get_daily_climate(coords.mat, period = "2001-01-01",
                      climatic_var = c("Tmin", "Tmax", "Prcp"),
                      version = 3,
                      check_connection = FALSE),
    structure(list(ID_coords = as.double(1:2),
                   lon = c(-5.36, -5.5),
                   lat = c(37.40, 37.5),
                   date = c("2001-01-01", "2001-01-01"),
                   Tmin = c(6.5, 6.73),
                   Tmax = c(15.93, 15.47),
                   Prcp = c(8.64, 8.83)),
              row.names = c(NA, -2L), class = "data.frame"))

  # Output raster
  output <- get_daily_climate(coords.mat, period = "2001-01-01",
                              climatic_var = c("Tmin", "Tmax", "Prcp"),
                              output = "raster",
                              version = 3, check_connection = FALSE)

  library(terra)
  expect_true(inherits(output, "list"))
  expect_identical(names(output), structure(c("Tmin", "Tmax", "Prcp")))
  expect_identical(head(values(output[[1]])),
                   structure(c(6.73, 6.71, 6.7, 6.69, 6.68, 6.66), dim = c(6L, 1L),
                             dimnames = list(NULL, "2001-01-01")))
  expect_identical(head(values(output[[2]])),
                   structure(c(15.47, 15.46, 15.36, 15.35, 15.34, 15.34), dim = c(6L, 1L),
                             dimnames = list(NULL, "2001-01-01")))
  expect_identical(head(values(output[[3]])),
                   structure(c(8.83, 8.85, 8.87, 8.9, 8.92, 8.95), dim = c(6L, 1L
                   ), dimnames = list(NULL, "2001-01-01")))

  })

test_that("downloading several variables gives expected results from v4", {

  # Testing for 2 sites and a single day

  skip_on_cran()
  skip_on_ci()
  skip_if_not(suppressWarnings(check_server(verbose = FALSE)))

  ## Input matrix
  coords.mat <- matrix(c(-5.36, 37.40, -5.5, 37.5), ncol = 2, byrow = TRUE)

  # ## Output data.frame
  expect_identical(
    get_daily_climate(coords.mat, period = "2001-01-01",
                      climatic_var = c("Tmin", "Tmax", "Prcp"),
                      check_connection = FALSE),
    structure(list(ID_coords = as.double(1:2),
                   lon = c(-5.36, -5.5),
                   lat = c(37.40, 37.5),
                   date = c("2001-01-01", "2001-01-01"),
                   Tmin = c(6.25, 6.51),
                   Tmax = c(16.06, 15.65),
                   Prcp = c(8.30, 8.72)),
              row.names = c(NA, -2L), class = "data.frame"))

  # Output raster
  output <- get_daily_climate(coords.mat, period = "2001-01-01",
                              climatic_var = c("Tmin", "Tmax", "Prcp"),
                              output = "raster",
                              check_connection = FALSE)

  library(terra)
  expect_true(inherits(output, "list"))
  expect_identical(names(output), structure(c("Tmin", "Tmax", "Prcp")))
  expect_identical(head(values(output[[1]])),
                   structure(c(6.51, 6.49, 6.46, 6.44, 6.42, 6.40), dim = c(6L, 1L),
                             dimnames = list(NULL, "2001-01-01")))
  expect_identical(head(values(output[[2]])),
                   structure(c(15.65, 15.64, 15.53, 15.53, 15.52, 15.51), dim = c(6L, 1L),
                             dimnames = list(NULL, "2001-01-01")))
  expect_identical(head(values(output[[3]])),
                   structure(c(8.72, 8.70, 8.67, 8.65, 8.62, 8.59), dim = c(6L, 1L
                   ), dimnames = list(NULL, "2001-01-01")))

})

