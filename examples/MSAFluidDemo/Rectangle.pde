class Rectangle {
  float cordinateX[];
  float cordinateY[];
  float center[];
  PShape rectangle;
  PVector[] vertices;

  Rectangle (float _centerX, float _centerY, float _rWidth, float _rHeight, float _rotation) {
    //Init
    center = new float[2];
    cordinateX = new float[4];
    cordinateY = new float[4];
    //Find center
    center[0] = _centerX;
    center[1] = _centerY;
    //find coord
    cordinateX[0] = center[0] - _rWidth/2;
    cordinateX[1] = center[0] + _rWidth/2;
    cordinateX[2] = cordinateX[1];
    cordinateX[3] = cordinateX[0];
    
    cordinateY[0] = center[1] + _rHeight/2;
    cordinateY[1] = cordinateY[0];
    cordinateY[2] = center[1] - _rHeight/2;
    cordinateY[3] = cordinateY[2];
    
    //recalculate coords with rotation:
    if (_rotation !=0) {
      for (int i =0; i<4; i++) {
       float dx = cordinateX[i] - center[0];
       float dy = cordinateY[i] - center[1];
       cordinateX[i] = center[0] - dx*(float)Math.cos(_rotation) + dy*(float)Math.sin(_rotation);
       cordinateY[i] = (float) center[0] - dx*(float)Math.sin(_rotation) - dy*(float)Math.cos(_rotation); 
      }
      
    }
    
    rectangle = createShape();
    rectangle.beginShape();
    for (int i =0; i<4;i++) rectangle.vertex(cordinateX[i],cordinateY[i]);
    rectangle.endShape(CLOSE);      
    
  }


  void display() {
    shape(rectangle);
  }
  
  float[] getFigureParams () {
    //rewrite to full matrix
    return rectangle.getParams();
  }
  boolean isFigContainsPoint (float _x, float _y) {
    return rectangle.contains(_x,_y);
  }
  
  //from http://alienryderflex.com/polygon/ 
  boolean isPointInRectangle (float x, float y) {
  int polySides = 4; //rectagular
  int i, j = polySides -1;
  boolean  oddNodes = false;
  for (i=0; i<polySides; i++) {
    if ((cordinateY[i] < y && cordinateY[j] >= y
    ||   cordinateY[j] < y && cordinateY[i] >= y)
    &&  (cordinateX[i] <= x || cordinateX[j] <= x)) {
      oddNodes ^= (cordinateX[i] + (y - cordinateY[i])/(cordinateY[j] - cordinateY[i]) * (cordinateX[j] - cordinateX[i]) < x); }
    j=i; }

  return oddNodes; }
    
}
