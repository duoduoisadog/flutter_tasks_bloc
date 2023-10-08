import 'dart:math';

class GUIDGen {
  static String generate() {
    // 创建一个随机数生成器，使用当前时间的微秒数作为种子
    Random random = Random(DateTime.now().microsecond);
    // 定义十六进制字符串
    const String hexDigits = '0123456789abcdef';
    // 创建一个长度为36的列表，用于存放UUID
    final List<String> uuid = List.filled(36, "", growable: true);

    // 遍历UUID，使用随机数填充
    for (int i = 0; i < 36; i++) {
      final int hexPos = random.nextInt(16);
      uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
    }
    // 获取UUID中第19个字符的十六进制值，并将其转换为整数，然后与0x3进行按位与运算，再将结果左移0x8位，最后将结果转换为十六进制字符串
    int pos = (int.parse(uuid[19], radix: 16) & 0x3 | 0x8);

    // 将UUID中第14个字符设置为'4'
    uuid[14] = '4';

    // 将UUID中第19个字符设置为UUID中第8个字符的十六进制值
    uuid[19] = hexDigits.substring(pos, pos + 1);

    // 将UUID中第8、13、18、23个字符设置为'-'
    uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';

    // 创建一个字符串缓冲区
    final StringBuffer buffer = StringBuffer();

    // 将UUID中的每一个字符拼接到字符串缓冲区中
    buffer.writeAll(uuid);

    // 返回拼接后的字符串
    return buffer.toString();
  }
}
