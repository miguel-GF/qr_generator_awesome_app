# Development

Para crear fromJson y toJson de los modelos

```
# importar la libreria
import 'package:json_annotation/json_annotation.dart';
# poner este nombre de archivo de acuerdo a tu modelo
part 'name_model.g.dart';
# agregar la anotacion 
@JsonSerializable()
class NameModel extends NameEntity {
...
```
Ejecutar en terminal
```
dart run build_runner build
```

Esto te generara tu archivo con tus metodos de fromJson y toJson ya solo usar los metodos generados en tu modelo
```
...
factory NameModel.fromJson(Map<String, dynamic> data) =>
      _$NameModelFromJson(data);
  Map<String, dynamic> toJson() => _$NameModelToJson(this);
}
```
