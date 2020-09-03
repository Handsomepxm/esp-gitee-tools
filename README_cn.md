# Gitee 中仓库使用的补充说明

为了解决国内开发者从 github 克隆 esp 相关工程慢的问题，已将 esp-idf 和部分重要工程及其关联的子模块镜像到了 gitee。

有部分 esp 工程会使用 submodule，而 submodule 会指向 github，或者以相对路径的方式指向 gitee 上不存在或不正确的仓库，导致从 clone 仍旧慢或者会出错，因此引入了新的脚本来解决此问题。

> 判断是否有 submodule 的方法是确认工程下是否有 .gitmodules 文件。

## 使用流程

以下以 esp-idf 为例说明，其他包含 submodule 的工程，如 esp-adf 等均可以参考。

[ ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/index.html#linux-and-macos) 中默认使用如下命令来克隆 esp-idf：

```shell
git clone --recursive https://github.com/espressif/esp-idf.git
```

git 命令带了 --recursive 参数后会克隆包括子模块在内的所有仓库。

有别于此，在 gitee 中可使用如下流程：

- Step 1：

  ```shell
  git clone https://gitee.com/EspressifSystems/submodule-update.git
  ```

  为了方面后面使用，可以 export submodule-updata 路径，如：

  ```shell
  cd submodule-updata
  export SU_PATH=$(pwd)
  ```

- Step 2：

  ```shell
  git clone https://gitee.com/EspressifSystems/esp-idf.git
  ```

  仅克隆 esp-idf，不包含子模块。

- Step 3：

  进入 esp-idf 目录执行 submodule-updata 脚本：

  ```shell
  cd esp-idf
  $SU_PATH/submodule-update.sh
  ```

  有如下类似 log：

  ```
  子模组 'components/asio/asio'（https://gitee.com/espressif/asio.git）已对路径 'components/asio/asio' 注册
  子模组 'components/bootloader/subproject/components/micro-ecc/micro-ecc'（https://gitee.com/kmackay/micro-ecc.git）已对路径 'components/bootloader/subproject/components/micro-ecc/micro-ecc' 注册
  子模组 'components/bt/controller/lib'（https://gitee.com/espressif/esp32-bt-lib.git）已对路径 'components/bt/controller/lib' 注册
  子模组 'components/bt/host/nimble/nimble'（https://gitee.com/espressif/esp-nimble.git）已对路径 'components/bt/host/nimble/nimble' 注册
  子模组 'components/cbor/tinycbor'（https://gitee.com/intel/tinycbor.git）已对路径 'components/cbor/tinycbor' 注册
  子模组 'components/coap/libcoap'（https://gitee.com/obgm/libcoap.git）已对路径 'components/coap/libcoap' 注册
  子模组 'components/esp_wifi/lib'（https://gitee.com/espressif/esp32-wifi-lib.git）已对路径 'components/esp_wifi/lib' 注册
  子模组 'components/esptool_py/esptool'（https://gitee.com/espressif/esptool.git）已对路径 'components/esptool_py/esptool' 注册
  子模组 'components/expat/expat'（https://gitee.com/libexpat/libexpat.git）已对路径 'components/expat/expat' 注册
  子模组 'components/json/cJSON'（https://gitee.com/DaveGamble/cJSON.git）已对路径 'components/json/cJSON' 注册
  子模组 'components/libsodium/libsodium'（https://gitee.com/jedisct1/libsodium.git）已对路径 'components/libsodium/libsodium' 注册
  子模组 'components/lwip/lwip'（https://gitee.com/espressif/esp-lwip.git）已对路径 'components/lwip/lwip' 注册
  子模组 'components/mbedtls/mbedtls'（https://gitee.com/espressif/mbedtls.git）已对路径 'components/mbedtls/mbedtls' 注册
  子模组 'components/mqtt/esp-mqtt'（https://gitee.com/espressif/esp-mqtt.git）已对路径 'components/mqtt/esp-mqtt' 注册
  子模组 'components/nghttp/nghttp2'（https://gitee.com/nghttp2/nghttp2.git）已对路径 'components/nghttp/nghttp2' 注册
  子模组 'components/protobuf-c/protobuf-c'（https://gitee.com/protobuf-c/protobuf-c.git）已对路径 'components/protobuf-c/protobuf-c' 注册
  子模组 'components/spiffs/spiffs'（https://gitee.com/pellepl/spiffs.git）已对路径 'components/spiffs/spiffs' 注册
  子模组 'components/tinyusb/tinyusb'（https://gitee.com/espressif/tinyusb.git）已对路径 'components/tinyusb/tinyusb' 注册
  子模组 'components/unity/unity'（https://gitee.com/ThrowTheSwitch/Unity.git）已对路径 'components/unity/unity' 注册
  子模组 'examples/build_system/cmake/import_lib/main/lib/tinyxml2'（https://gitee.com/leethomason/tinyxml2.git）已对路径 'examples/build_system/cmake/import_lib/main/lib/tinyxml2' 注册
  子模组 'examples/peripherals/secure_element/atecc608_ecdsa/components/esp-cryptoauthlib'（https://gitee.com/espressif/esp-cryptoauthlib.git）已对路径 'examples/peripherals/secure_element/atecc608_ecdsa/components/esp-cryptoauthlib' 注册
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/asio/asio'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/bootloader/subproject/components/micro-ecc/micro-ecc'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/bt/controller/lib'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/bt/host/nimble/nimble'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/cbor/tinycbor'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/coap/libcoap'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/esp_wifi/lib'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/esptool_py/esptool'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/expat/expat'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/json/cJSON'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/libsodium/libsodium'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/lwip/lwip'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/mbedtls/mbedtls'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/mqtt/esp-mqtt'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/nghttp/nghttp2'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/protobuf-c/protobuf-c'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/spiffs/spiffs'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/tinyusb/tinyusb'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/unity/unity'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/examples/build_system/cmake/import_lib/main/lib/tinyxml2'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/examples/peripherals/secure_element/atecc608_ecdsa/components/esp-cryptoauthlib'...
  子模组路径 'components/asio/asio'：检出 'f31694c9f1746ba189a4bcae2e34db15135ddb22'
  子模组路径 'components/bootloader/subproject/components/micro-ecc/micro-ecc'：检出 'd037ec89546fad14b5c4d5456c2e23a71e554966'
  子模组路径 'components/bt/controller/lib'：检出 '93eeca8b535dd609da8b1cdac44a11707e03c333'
  子模组路径 'components/bt/host/nimble/nimble'：检出 '95bd8644abf4a410dd3fb914468d3a23ac9bbec2'
  子模组路径 'components/cbor/tinycbor'：检出 '085ca40781f7c39febe6d14fb7e5cba342e1804b'
  子模组路径 'components/coap/libcoap'：检出 '98954eb30a2e728e172a6cd29430ae5bc999b585'
  子模组路径 'components/esp_wifi/lib'：检出 '3d951fb6c4fce3a2655e63d475b80b09c6acfddf'
  子模组路径 'components/esptool_py/esptool'：检出 '1b296066bea253f1eb857188c1ac5548696e49e7'
  子模组路径 'components/expat/expat'：检出 '968b8cc46dbee47b83318d5f31a8e7907199614b'
  子模组路径 'components/json/cJSON'：检出 '3c8935676a97c7c97bf006db8312875b4f292f6c'
  子模组路径 'components/libsodium/libsodium'：检出 '70170c28c844a4786e75efc626e1aeebc93caebc'
  子模组路径 'components/lwip/lwip'：检出 '80d6d19a929c6db577fc44a47fdb4acffdd68933'
  子模组路径 'components/mbedtls/mbedtls'：检出 '90f46c8b17bc1219a82d4ddf81520d40c5ac5ebf'
  子模组路径 'components/mqtt/esp-mqtt'：检出 '6bc94add892437d0fd50f26bfabe78c646648c13'
  子模组路径 'components/nghttp/nghttp2'：检出 '8f7b008b158e12de0e58247afd170f127dbb6456'
  子模组路径 'components/protobuf-c/protobuf-c'：检出 'dac1a65feac4ad72f612aab99f487056fbcf5c1a'
  子模组路径 'components/spiffs/spiffs'：检出 'f5e26c4e933189593a71c6b82cda381a7b21e41c'
  子模组路径 'components/tinyusb/tinyusb'：检出 'a2ba3dccccf94022d31e939fa2ce4dca5f0a34f0'
  子模组路径 'components/unity/unity'：检出 '7d2bf62b7e6afaf38153041a9d53c21aeeca9a25'
  子模组路径 'examples/build_system/cmake/import_lib/main/lib/tinyxml2'：检出 '7e8e249990ec491ec15990cf95b6d871a66cf64a'
  子模组路径 'examples/peripherals/secure_element/atecc608_ecdsa/components/esp-cryptoauthlib'：检出 '71e69383a0368bb704e1b0d90b7e5697afae7d5d'
  进入 'components/asio/asio'
  进入 'components/bootloader/subproject/components/micro-ecc/micro-ecc'
  进入 'components/bt/controller/lib'
  进入 'components/bt/host/nimble/nimble'
  进入 'components/cbor/tinycbor'
  进入 'components/coap/libcoap'
  子模组 'ext/tinydtls'（https://github.com/eclipse/tinydtls.git）已对路径 'ext/tinydtls' 注册
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/coap/libcoap/ext/tinydtls'...
  子模组路径 'ext/tinydtls'：检出 '7f8c86e501e690301630029fa9bae22424adf618'
  进入 'ext/tinydtls'
  进入 'components/esp_wifi/lib'
  进入 'components/esptool_py/esptool'
  进入 'components/expat/expat'
  进入 'components/json/cJSON'
  进入 'components/libsodium/libsodium'
  进入 'components/lwip/lwip'
  进入 'components/mbedtls/mbedtls'
  进入 'components/mqtt/esp-mqtt'
  进入 'components/nghttp/nghttp2'
  子模组 'third-party/mruby'（https://github.com/mruby/mruby）已对路径 'third-party/mruby' 注册
  子模组 'third-party/neverbleed'（https://github.com/tatsuhiro-t/neverbleed.git）已对路径 'third-party/neverbleed' 注册
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/nghttp/nghttp2/third-party/mruby'...
  正克隆到 '/home/wujg/git/esp32-sdk/esp-idf-gitee/components/nghttp/nghttp2/third-party/neverbleed'...
  子模组路径 'third-party/mruby'：检出 '7c91efc1ffda769a5f1a872c646c82b00698f1b8'
  子模组路径 'third-party/neverbleed'：检出 'b967ca054f48a36f82d8fcdd32e54ec5144f2751'
  进入 'third-party/mruby'
  进入 'third-party/neverbleed'
  进入 'components/protobuf-c/protobuf-c'
  进入 'components/spiffs/spiffs'
  进入 'components/tinyusb/tinyusb'
  进入 'components/unity/unity'
  进入 'examples/build_system/cmake/import_lib/main/lib/tinyxml2'
  进入 'examples/peripherals/secure_element/atecc608_ecdsa/components/esp-cryptoauthlib'
  ```

如使用中有任何问题，请提交到 [Issues](https://gitee.com/EspressifSystems/submodule-update/issues)。