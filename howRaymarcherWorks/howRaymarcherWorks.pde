final int CIRCLE_COUNT = 6;
Circle[] circles = new Circle[ CIRCLE_COUNT ];

PGraphics[] layer = new PGraphics[ 4 ];

void setup() {
  size( 800, 800 );
  
  circles[ 0 ] = new Circle( 700, 100, 50 );
  circles[ 1 ] = new Circle( 600, 300, 75 );
  circles[ 2 ] = new Circle( 150, 650, 100 );
  circles[ 3 ] = new Circle( 600, 600, 150 );
  circles[ 4 ] = new Circle( 200, 400, 50 );
  circles[ 5 ] = new Circle( 400, 400, 25 );
  
  for ( int i = 0; i < 4; i ++ ) {
    layer[ i ] = createGraphics( width, height );
  }
}

void draw() {
  for ( int i = 0; i < 4; i ++ ) {
    layer[ i ].beginDraw();
    layer[ i ].clear();
    layer[ i ].endDraw();
  }
  
  float time = frameCount * PI * 2.0 / 400.0;
  
  background( 255 );
  
  float rayBX = 100.0;
  float rayBY = 100.0;
  float rayX = rayBX;
  float rayY = rayBY;
  float rayDir = ( 1.0 + sin( time ) ) * PI / 4.0;
  float rayLen = 0.0;
  
  Circle minCirc;
  
  for ( int iMarch = 0; iMarch < 32; iMarch ++ ) {
    minCirc = circles[ 0 ];
    float dist = dist( rayX, rayY, minCirc.x, minCirc.y ) - minCirc.r;
    
    for ( int iCirc = 1; iCirc < CIRCLE_COUNT; iCirc ++ ) {
      Circle circle = circles[ iCirc ];
      float distC = dist( rayX, rayY, circle.x, circle.y ) - circle.r;
      if ( distC < dist ) {
        minCirc = circle;
        dist = distC;
      }
    }
    
    float rayPX = rayX;
    float rayPY = rayY;
    
    rayLen += dist;
    rayX = rayBX + cos( rayDir ) * rayLen;
    rayY = rayBY + sin( rayDir ) * rayLen;
    
    layer[ 0 ].beginDraw();
      layer[ 0 ].noFill();
      layer[ 0 ].strokeWeight( 3 );
      
      layer[ 0 ].stroke( 170 );
      layer[ 0 ].ellipse( rayPX, rayPY, dist * 2.0, dist * 2.0 );
      
      layer[ 0 ].stroke( 170 );
      layer[ 0 ].line( rayPX, rayPY, minCirc.x, minCirc.y );
    layer[ 0 ].endDraw();
    
    layer[ 2 ].beginDraw();
      layer[ 2 ].noFill();
      
      layer[ 2 ].strokeWeight( 6 );
      layer[ 2 ].stroke( 250, 140, 50 );
      layer[ 2 ].line( rayPX, rayPY, rayX, rayY );
      
      layer[ 2 ].fill( 250, 140, 50 );
      layer[ 2 ].noStroke();
      layer[ 2 ].ellipse( rayX, rayY, 10.0, 10.0 );
    layer[ 2 ].endDraw();
    
    if ( 1200 < rayLen ) { break; }
    if ( dist < 1 ) { break; }
  }
  
  layer[ 1 ].beginDraw();
    layer[ 1 ].fill( 0 );
    layer[ 1 ].noStroke();
    
    for ( int iCirc = 0; iCirc < CIRCLE_COUNT; iCirc ++ ) {
      Circle circle = circles[ iCirc ];
      layer[ 1 ].ellipse( circle.x, circle.y, circle.r * 2.0, circle.r * 2.0 );
    }
  layer[ 1 ].endDraw();
  
  layer[ 2 ].beginDraw();
    layer[ 2 ].fill( 250, 140, 50 );
    layer[ 2 ].noStroke();
    layer[ 2 ].ellipse( rayX, rayY, 16.0, 16.0 );
  layer[ 2 ].endDraw();
  
  layer[ 3 ].beginDraw();
    layer[ 3 ].pushMatrix();
    layer[ 3 ].translate( 100, 100 );
    layer[ 3 ].rotate( rayDir );
    layer[ 3 ].fill( 0 );
    layer[ 3 ].rect( -30, -10, 20, 20 );
    layer[ 3 ].triangle( -10, 0, 5, 10, 5, -10 );
    layer[ 3 ].popMatrix();
  layer[ 3 ].endDraw();
  
  for ( int i = 0; i < 4; i ++ ) {
    image( layer[ i ], 0, 0 );
  }
  
  saveFrame( "capture/####.png" );
}

class Circle {
  float x;
  float y;
  float r;
  
  Circle( float _x, float _y, float _r ) {
    x = _x;
    y = _y;
    r = _r;
  }
}