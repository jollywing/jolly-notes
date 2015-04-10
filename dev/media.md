# 视频分辨率标准 #

1. 4k 4096x1024, 超高清
2. 2k 2048x1080, 高清
3. 1080P 1920x1080, 全高清，一般蓝光质量都是1080P
4. 720P 1280x720 标准高清

# PES #

Packetized Elementary Stream (PES)
MPEG-2中定义的规范，把流分成报文。把连续的数据字节封装在 PES packet headers中。
对于从编码器出来的流，先封装成PES报文，在把PES报文封装到TS (MPEG transport stream)报文中。

(Note: `Packet start code` + `stream id` is called the 32-bit start code.)

- Packet start code: prefix	3 bytes	0x000001
- Stream id	1 byte:	Examples: Audio streams (0xC0-0xDF), Video streams (0xE0-0xEF)
- PES Packet length: 2 bytes, Can be zero.
- Optional PES header: variable length	
- Stuffing bytes: variable length	
- Data: See elementary stream. In the case of private streams the first byte of the payload is the sub-stream number.

## ES (Elementary Stream) ##

MPEG通信协议定义的，是MPEG音视频编码器的输出。
ES中只包含一种数据，音频或视频。其格式依赖于编码器和流中的数据。
但变成PES后，就有一个一致的header啦。

比如：Header for MPEG-2 video elementary stream

- start code, 32 bits, 0x000001B3
- Horizontal Size, 12 bits,
- Vertical Size, 12	bits
- Aspect ratio,	4 bits
- Frame rate code, 4 bits
- Bit rate, 18 bits, Actual bit rate = bit rate * 400, rounded upwards. Use 0x3FFFF for variable bit rate.
- Marker bit, 1 bit, Always 1.
- VBV buf size,	10 bits, Size of video buffer verifier = 16\*1024\*vbv buf size
- constrained parameters flag, 1 bit
- load intra quantizer matrix, 1 bit, If bit set then intra quantizer matrix follows, otherwise use default values.
- intra quantizer matrix	0 or 64\*8	
- load non intra quantizer matrix	1	If bit set then non intra quantizer matrix follows.
- non intra quantizer matrix	0 or 64*8	
