# FPGA-Final-project  
專題題目:貪吃的豬(接接樂)  
==========================
Team members:108321004 108321011  


語言 : SystemVerilog  
開發環境 : Quartus 13.1  

七階段顯示器用來表示分數  

3顆LED燈用來顯示血量  

紅色switch開關 :  
   2,3開關用來調整關卡難度  
   4開關用來繼續或是暫停遊戲  
     
4bit 按鈕 :     
1,2號按鈕分別用來操作左移右移  
4號按鈕用來重置血量跟分數跟遊戲  
  
8x8LED顯示器  

基本功能 :  
產生隨機位置的三種掉落物  
可操控位置的移動物  
![image](https://github.com/hao089/FPGA-Final-project/blob/main/1.png)  
碰到藍色加2分，碰到黃色加1分，碰到紅色減一血  

進階功能 :  
     1. 勝利跟失敗畫面  
     ![image](https://github.com/hao089/FPGA-Final-project/blob/main/2.png)
     ![image](https://github.com/hao089/FPGA-Final-project/blob/main/3.png)  
     2. 難度調整  
     3. 撞到掉落物時有Beep聲  
影片:[連結](https://mega.nz/file/vv5EwDZa#BovquXxVR6tPWSq7LHhqU_TwgYCzHjvO2P6_5z-pkRA)
