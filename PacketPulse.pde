class PacketPulse {
  private PVector _startPosition, _centerPosition, _endPosition, _currentPosition;
  private int _time;
  private int _timeLength;
  
  public PacketPulse(PVector start, PVector center, PVector end, int timeLength){
    this._startPosition = start;
    this._centerPosition = center;
    this._endPosition = end;
    this._timeLength = timeLength;
    
    this._currentPosition = start;
    this._time = 0;
  }
  
  public void draw(){
    pushStyle();
    noFill();
    smooth();
    float pulseProgress = 1 - abs(2*((float) _time)/((float) _timeLength) - 1);
    strokeWeight(5*pulseProgress + 1);
    stroke(255, 255, 255, (int) (pulseProgress * 200) );
    bezierDetail(100);
    bezier(
      this._startPosition.x, this._startPosition.y, this._startPosition.z,
      this._centerPosition.x, this._centerPosition.y, this._centerPosition.z,
      this._centerPosition.x, this._centerPosition.y, this._centerPosition.z,
      this._endPosition.x, this._endPosition.y, this._endPosition.z
    );
    this._time++;
    popStyle();
  }
  
  public boolean received(){
    return (this._time > this._timeLength);
  }
}
