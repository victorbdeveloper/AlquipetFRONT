import 'dart:convert';

import '../listing.dart';

class FilteredListingsResponse {
  FilteredListingsResponse({
    this.totalAnunciosEncontradosAplicandoLosFiltros,
    this.anunciosMostrados,
    this.indiceDelPrimerAnuncioMostrado,
    this.indiceDelUltimoAnuncioMostrado,
    this.results,
  });

  int? totalAnunciosEncontradosAplicandoLosFiltros = 0;
  int? anunciosMostrados = 0;
  int? indiceDelPrimerAnuncioMostrado = 0;
  int? indiceDelUltimoAnuncioMostrado = 0;
  List<Listing>? results = <Listing>[];

  factory FilteredListingsResponse.fromJson(String str) =>
      FilteredListingsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilteredListingsResponse.fromMap(Map<String, dynamic> json) => FilteredListingsResponse(
        totalAnunciosEncontradosAplicandoLosFiltros:
            json["Total anuncios encontrados aplicando los filtros:"] ?? 0,
        anunciosMostrados: json["Anuncios mostrados: "] ?? 0,
        indiceDelPrimerAnuncioMostrado:
            json["Índice del primer anuncio mostrado: "] ?? 0,
        indiceDelUltimoAnuncioMostrado:
            json["Índice del último anuncio mostrado: "] ?? 0,
        results: json["results"] == null
            ? <Listing>[]
            : List<Listing>.from(
                json["results"].map((x) => Listing.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Total anuncios encontrados aplicando los filtros:":
            totalAnunciosEncontradosAplicandoLosFiltros,
        "Anuncios mostrados: ": anunciosMostrados,
        "Índice del primer anuncio mostrado: ": indiceDelPrimerAnuncioMostrado,
        "Índice del último anuncio mostrado: ": indiceDelUltimoAnuncioMostrado,
        "results": results == null
            ? <Listing>[]
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'ListingResponse{totalAnunciosEncontradosAplicandoLosFiltros: $totalAnunciosEncontradosAplicandoLosFiltros, anunciosMostrados: $anunciosMostrados, indiceDelPrimerAnuncioMostrado: $indiceDelPrimerAnuncioMostrado, indiceDelUltimoAnuncioMostrado: $indiceDelUltimoAnuncioMostrado, results: $results}';
  }
}


