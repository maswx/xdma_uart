
NOTES: log by [masw](masw@masw.tech) : 

* 项目还在持续开发中，尚未稳定
* FPGA 已 OK, 执行make即可编译工程， 缺上位机 `.ko` 驱动
* 寻有志之士撰写 Linux UART串口驱动!

## 这是啥？

* FPGA : XDMA+UART
* 上位机 : Linux x86 虚拟出串口设备 /dev/ttyUART0 

## 用来干啥？

* 对于服务器板卡，没有外置串口
* FPGA内置RISC-V / MicroBlaze 时，需要串口Debug
* 通过PCIe的bar区控制 UART

## Demo

* 串口环回

## 编译FPGA

```
cd fpga 
make
```

## 编译上位机驱动

```
cd driver 
make 
sudo make install 
```

## 测试

使用串口软件测试
