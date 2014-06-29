class NetNode {
  private PVector _position;
  private float _radius;
  private color _color;
  private int _resolution;

  public NetNode() {
    this._position = PVector.random3D();
    this._position.mult( (float) ( 0.4 + 0.05 * Math.random() ) * height);
    this._radius = 0.01 * height;
    this._color = color( (int) ( 64 * Math.random() ) + 32 );
    this._resolution = 30;
  }
  public void draw() {
    pushStyle();
    pushMatrix();
    fill(this._color);
    sphereDetail(this._resolution);
    smooth();
    translate(this._position.x, this._position.y, this._position.z);
    sphere(this._radius);
    popMatrix();
    popStyle();
  }
  public PVector getPosition(){
    return this._position;
  }
}

