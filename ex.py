

from typing import Self
import math



grid = [['█' for _ in range(120)] for _ in range(30)]
RESET = "\033[0m"


class Vertex():
    x=0
    y=0
    def __init__(self,x,y):
        self.x=x
        self.y=y
        pass
    def print(self):
        grid[self.x][self.y] ='▓'
    def __sub__(self,other):
        return Vertex(self.x-other.x,self.y-other.y)
    def __mul__(self,other):
        return self.x * other.x + self.y * other.y
    def __str__(self):
            return f"({self.x}, {self.y})"
    def __repr__(self):
            # Good practice: Include the class name so it looks like a constructor
            return f"Vector(x={self.x}, y={self.y})"

def get_bounding_box(verts):
    """Returns (x_min, x_max, y_min, y_max) for a list of Vertex objects"""
    xs = [v.x for v in verts]
    ys = [v.y for v in verts]
    
    # We floor the mins and ceil the maxes to ensure we cover partial pixels
    return (
        math.floor(min(xs)),
        math.ceil(max(xs)),
        math.floor(min(ys)),
        math.ceil(max(ys))
    )
def get_rgb_ansi(r, g, b):
    # Convert 0.0-1.0 to 0-255
    r_int = int(r * 255)
    g_int = int(g * 255)
    b_int = int(b * 255)
    return f"\033[38;2;{r_int};{g_int};{b_int}m"

def bary(pt,vert_a,vert_b,vert_c):
    ab = vert_b - vert_a
    ac = vert_c - vert_a
    ap = pt - vert_a
    nac = Vertex(vert_a.y - vert_c.y,vert_c.x - vert_a.x)
    nab = Vertex(vert_a.y - vert_b.y,vert_b.x - vert_a.x)
    bary_beta = 0
    bary_gamma = 0
    try:
        bary_beta  = (ap * nac) / (ab * nac);
    except:
        bary_beta = 1.0
    try:
        bary_gamma = (ap * nab) / (ac * nab);
    except:
        bary_gamma = 1.0
    bary_alpha = 1.000 - bary_beta - bary_gamma;
    return [bary_beta,bary_gamma,bary_alpha]

def in_triangle(pt,vert_a,vert_b,vert_c):
    vals = bary(pt,vert_a,vert_b,vert_c)
    
    err_tolerance=.01
    if vals[0] >= err_tolerance and vals[1] >= err_tolerance and vals[2] >= err_tolerance:
        return True,vals
    else:
        return False,vals

def fill_Triangle(vert_a,vert_b,vert_c):
    xmin,xmax,ymin,ymax = get_bounding_box([vert_a,vert_b,vert_c])
    for i in range(xmin,xmax+1):
        for j in range(ymin,ymax+1):
            decision,colors=in_triangle(Vertex(i,j),vert_a,vert_b,vert_c)
            
            if decision:
                color = get_rgb_ansi(colors[0],colors[1],colors[2])
                grid[i][j] =f"{color}█{RESET}"

    return

#120 x 30
a = Vertex(0,0)
b = Vertex(20,119)
c = Vertex(29,0)
#a.print()
#b.print()
#c.print()

a2 = Vertex(10,0)
b2 = Vertex(12,119)
c2 = Vertex(28,20)

fill_Triangle(a,b,c)
fill_Triangle(a2,b2,c2)

a2.print()
b2.print()
c2.print()
for i in grid:
    nums=""
    for j in i:
        nums+=j
    print(nums)
    








