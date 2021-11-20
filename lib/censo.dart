class Censo{
  String nombre;
  String correo;
  int habitantes;
  int vacunados;
  String direccion;
  int cp;

  Censo(this.nombre,this.correo,this.habitantes,this.vacunados,this.direccion,this.cp);

  Map<String,dynamic> toMap(){
    return {
      'nombre':nombre,'correo':correo,'habitantes':habitantes,'vacunados':vacunados,'direccion':direccion,'cp':cp
    };
  }
}