import unittest

import pycalculix as pyc

class TestMeshing(unittest.TestCase):
    """A class to hold our meshing tests"""

    def test_square_meshing(self):
        proj_name = 'fake_model'
        model = pyc.FeaModel(proj_name)
        model.set_units('m') # this sets dist units to meters

        # x = radial
        # y = axial
        width = 1 # axial
        height = 4 # radial
        part = pyc.Part(model)
        part.goto(-height*0.5, -width*0.5)
        part.draw_line_rad(height)
        part.draw_line_ax(width)
        part.draw_line_rad(-height)
        part.draw_line_ax(-width)
        # model.plot_geometry(proj_name+'_geom')   # plot part geometry

        model.set_eshape('quad', 2)
        model.set_etype('plstress', part, 0.1)
        model.mesh(1.0, 'gmsh') # mesh 1.0 fineness, smaller is finer
        model.plot_elements(proj_name+'_elem')   # plot part elements

if __name__ == '__main__':
    unittest.main()
