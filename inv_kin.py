import ctypes
import os
import numpy as np
import time

if os.name == 'nt':
    import msvcrt
    def getch():
        return msvcrt.getch().decode()
else:
    import sys, tty, termios
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    def getch():
        try:
            tty.setraw(sys.stdin.fileno())
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch

from dynamixel_sdk import *                    # Uses Dynamixel SDK library

# Length of the arms in inches
a0      = 2   
a1      = 7
a2      = 3
# Angles of the joints
t0      = 180
t1      = 180 
t2      = 180

# Angles in radians
t0      = t0/180*np.pi
t1      = t1/180*np.pi
t2      = t2/180*np.pi

# Control Table address
ADDR_TORQUE_ENABLE                 = 64
ADDR_PROFILE_VELOCITY              = 112
ADDR_PROFILE_ACCELERATION          = 108
ADDR_GOAL_POSITION                 = 116
ADDR_PRESENT_POSITION              = 132
ADDR_DRIVE_MODE                    = 10
ADDR_MOVING_STATUS                 = 123

# Data Byte Length
LEN_GOAL_POSITION       = 4
LEN_PRESENT_POSITION    = 4

# Protocol version
PROTOCOL_VERSION            = 2.0               # See which protocol version is used in the Dynamixel

# Default setting
DXL1_ID                     = 92                 # Dynamixel#1 ID : 92
DXL2_ID                     = 94                 # Dynamixel#1 ID : 94
DXL3_ID                     = 96                 # Dynamixel#1 ID : 96   
BAUDRATE                    = 1000000            # Dynamixel default baudrate : 57600
DEVICENAME                  = '/dev/ttyUSB0'     # check the port being used

TORQUE_ENABLE               = 1                 # Value for enabling the torque
TORQUE_DISABLE              = 0                 # Value for disabling the torque

DXL_MIN_POSITION_VALUE      = 1023
DXL_MAX_POSITION_VALUE      = 3071
'''    
DXL1_MIN_POSITION_VALUE     = 1500          # Dynamixel 1 will rotate between this value
DXL1_MAX_POSITION_VALUE     = 2000              # and this value 
DXL2_MIN_POSITION_VALUE     = 1100           # Dynamixel 2 will rotate between this value
DXL2_MAX_POSITION_VALUE     = 2700          # and this value
DXL3_MIN_POSITION_VALUE     = 1800          # Dynamixel 2 will rotate between this value
DXL3_MAX_POSITION_VALUE     = 3000              # and this value
'''
DXL_MOVING_STATUS_THRESHOLD = 20                # Dynamixel moving status threshold


class Forward_kinematics():
    
    def init (self):
        self.joint1         = t0
        self.joint2         = t1
        self.joint3         = t2
        self.param_table    = [[],[],[],[]]
        self.T0_1           = [[],[],[],[]]
        self.T1_2           = [[],[],[],[]]
        self.T2_3           = [[],[],[],[]]
        self.T0_2           = [[],[],[],[]]
        self.T0_3           = [[],[],[],[]]

    def param_table(self, joint1, joint2, joint3):
        # Parameter table with columns " theta, alpha, r or a, d 
        self.param_tab  =   [[joint1 ,      0         ,  a0   ,  0  ],
                             [joint2 ,      0         ,  a1   ,  0  ],
                             [joint3 ,      0         ,  a2   ,  0  ]]
    
    def transformation_matrix(self):
        '''
        This method calculates the Transformation Matrix at each joint
        and returns end effector Transformation Matrix
        '''

        # Transformation matrix
        i=0
        self.T0_1 = [[np.cos(param_tab[i][0]) , -np.cos(param_tab[i][1])*np.sin(param_tab[i][0]), np.sin(param_tab[i][1])*np.sin(param_tab[i][0])  , param_tab[i][2]*np.cos(param_tab[i][0])],
                     [np.sin(param_tab[i][0]) , np.cos(param_tab[i][1])*np.cos(param_tab[i][0]) , -np.sin(param_tab[i][1])*np.cos(param_tab[i][0]) , param_tab[i][2]*np.sin(param_tab[i][0])],
                     [           0            ,            np.sin(param_tab[i][1])              ,       np.cos(param_tab[i][1])                    ,     param_tab[i][3]                    ],
                     [0  ,  0  ,  0  ,  1 ]]

        i=1
        self.T1_2 = [[np.cos(param_tab[i][0]) , -np.cos(param_tab[i][1])*np.sin(param_tab[i][0]), np.sin(param_tab[i][1])*np.sin(param_tab[i][0])  , param_tab[i][2]*np.cos(param_tab[i][0])],
                     [np.sin(param_tab[i][0]) , np.cos(param_tab[i][1])*np.cos(param_tab[i][0]) , -np.sin(param_tab[i][1])*np.cos(param_tab[i][0]) , param_tab[i][2]*np.sin(param_tab[i][0])],
                     [           0            ,            np.sin(param_tab[i][1])              ,       np.cos(param_tab[i][1])                    ,     param_tab[i][3]                    ],
                     [0  ,  0  ,  0  ,  1 ]]

        i=2
        self.T2_3 = [[np.cos(param_tab[i][0]) , -np.cos(param_tab[i][1])*np.sin(param_tab[i][0]), np.sin(param_tab[i][1])*np.sin(param_tab[i][0])  , param_tab[i][2]*np.cos(param_tab[i][0])],
                     [np.sin(param_tab[i][0]) , np.cos(param_tab[i][1])*np.cos(param_tab[i][0]) , -np.sin(param_tab[i][1])*np.cos(param_tab[i][0]) , param_tab[i][2]*np.sin(param_tab[i][0])],
                     [           0            ,            np.sin(param_tab[i][1])              ,       np.cos(param_tab[i][1])                    ,     param_tab[i][3]                    ],
                     [0  ,  0  ,  0  ,  1 ]]

        # Finding T0_3 matrix
        self.T0_2 = np.dot(T0_1,T1_2)
        self.T0_3 = np.dot(T0_2,T2_3) 

        return T0_3

    def position(self, tran_mat):
        '''
        This method prints the position of the end effector
        '''
        # Traslation vectors x,y,z are
        p_x = tran_mat[0][3]
        p_y = tran_mat[1][3]
        p_z = tran_mat[2][3]

        print(" X : ",p_x)
        print(" Y : ",p_y)
        print(" Z : ",p_z)

    def orientation(self, tran_mat):
        '''
        This method prints the orientation of the end effector
        '''
        #  Yaw-Pitch-Roll orientation
        #  phi - theta - psi
        theta = np.arcsin(tran_mat[2][0])
        psi = np.arccos((tran_mat[2][2])/np.cos(theta))
        phi = np.arccos((tran_mat[0][0])/np.cos(theta))

        print(" theta : ",theta)
        print(" psi : ",psi)
        print(" phi : ",phi)

def system_start_up():
    # Initialize PortHandler instance
    # Set the port path
    # Get methods and members of PortHandlerLinux or PortHandlerWindows
    portHandler = PortHandler(DEVICENAME)

    # Initialize PacketHandler instance
    # Set the protocol version
    # Get methods and members of Protocol1PacketHandler or Protocol2PacketHandler
    packetHandler = PacketHandler(PROTOCOL_VERSION)

    # Initialize GroupBulkWrite instance
    groupBulkWrite = GroupBulkWrite(portHandler, packetHandler)

    # Initialize GroupBulkRead instace for Present Position
    groupBulkRead = GroupBulkRead(portHandler, packetHandler)

    # Open port
    if portHandler.openPort():
        print("Succeeded to open the port")
    else:
        print("Failed to open the port")
        print("Press any key to terminate...")
        getch()
        quit()

    # Set port baudrate
    if portHandler.setBaudRate(BAUDRATE):
        print("Succeeded to change the baudrate")
    else:
        print("Failed to change the baudrate")
        print("Press any key to terminate...")
        getch()
        quit()

def torque_enable(name):
    # Enable Dynamixel Torque of the provided actuator
    dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, name, ADDR_TORQUE_ENABLE, TORQUE_ENABLE)
    if dxl_comm_result != COMM_SUCCESS:
        print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
    elif dxl_error != 0:
        print("%s" % packetHandler.getRxPacketError(dxl_error))
    else:
        print(name," has been successfully connected")

def torque_disable(name):
    # Disable Dynamixel Torque of the provided actuator
    dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, name, ADDR_TORQUE_ENABLE, TORQUE_DISABLE)
    if dxl_comm_result != COMM_SUCCESS:
        print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
    elif dxl_error != 0:
        print("%s" % packetHandler.getRxPacketError(dxl_error))

def add_parameter(name):
    # Add parameter storage for the given dunamixel's present position
    dxl_addparam_result = groupBulkRead.addParam(name, ADDR_PRESENT_POSITION, LEN_PRESENT_POSITION)
    if dxl_addparam_result != True:
        print("[ID:%03d] groupBulkRead addparam failed" % name)
        quit()

def byte_val_array(value):
    # Allocate value into byte array
    return  [DXL_LOBYTE(DXL_LOWORD(value)), DXL_HIBYTE(DXL_LOWORD(value)), DXL_LOBYTE(DXL_HIWORD(value)), DXL_HIBYTE(DXL_HIWORD(value))]

system_start_up()
torque_enable(DXL1_ID)
torque_enable(DXL2_ID)
torque_enable(DXL3_ID)

add_parameter(DXL1_ID)
add_parameter(DXL2_ID)
add_parameter(DXL3_ID)

while True:
    print("Press any key to continue! (or press ESC to quit!)")
    if getch() == chr(0x1b):
        break

