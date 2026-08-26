//
//  LBData+GZip.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/19.
//

import Foundation
import zlib




public extension Data {
    
    /*
     解压缩缓冲区大小
     */
    private static  let GZIP_BUF_LENGTH = 1024 * 10
    
    /// 判断数据是否为gzip流数据
    var isGzipCompressed : Bool {
    
        if (self.count >= 2) {
            return (self as Data).starts(with: [0x1f, 0x8b])
        }
        
        return false;
    }
    
    
    /// gzip数据解压
    ///
    /// - Returns: NSData

    func gzipUncompress() -> Data?{
          guard isGzipCompressed else { return self }
    

        /*
         解压缩缓冲区
         */
        let gzipBuf = UnsafeMutablePointer<Bytef>.allocate(capacity: Data.GZIP_BUF_LENGTH)
        
        defer {
            gzipBuf.deallocate()
        }


          var stream = z_stream()
          stream.next_in = UnsafeMutablePointer<UInt8>(mutating:(self as NSData).bytes.bindMemory(to:UInt8.self,capacity:self.count))
          stream.avail_in = uInt(self.count)

          var status:Int32 = inflateInit2_(&stream,MAX_WBITS + 16,ZLIB_VERSION,Int32(MemoryLayout<z_stream>.size))
          guard status == Z_OK else { return nil }

          let decompressed = NSMutableData()

          repeat {
              stream.avail_out = uInt(Data.GZIP_BUF_LENGTH)
              stream.next_out = gzipBuf
              status = inflate(&stream,Z_SYNC_FLUSH)

              if status != Z_OK && status != Z_STREAM_END {
                  inflateEnd(&stream)
                  return nil
              } else {
                  let dataLen = Data.GZIP_BUF_LENGTH - Int(stream.avail_out)
                  if dataLen > 0 {
                      decompressed.append(gzipBuf,length:dataLen)
                  }
              }
          } while stream.avail_out == 0

          if inflateEnd(&stream) != Z_OK { return nil }

          return decompressed as Data
      }
    
    // gzip数据压缩
    func gzipCompress() -> Data?{
        var stream = z_stream()
        stream.avail_in = uInt(count)
        stream.next_in = UnsafeMutablePointer<UInt8>(mutating:(self as NSData).bytes.bindMemory(to:UInt8.self,capacity:count))

        var status = deflateInit2_(&stream,Z_DEFAULT_COMPRESSION,Z_DEFLATED,MAX_WBITS + 16,MAX_MEM_LEVEL,Z_DEFAULT_STRATEGY,ZLIB_VERSION,Int32(MemoryLayout<z_stream>.size))
        
        
        guard status == Z_OK else { return nil }

        defer { deflateEnd(&stream) }
        /*
         解压缩缓冲区
         */
        let gzipBuf = UnsafeMutablePointer<Bytef>.allocate(capacity: Data.GZIP_BUF_LENGTH)
        
        defer {
            gzipBuf.deallocate()
        }
        

        let compressed = NSMutableData()

        while stream.avail_out == 0 {
            stream.avail_out = uInt(Data.GZIP_BUF_LENGTH)
            stream.next_out = gzipBuf

            status = deflate(&stream,Z_FINISH)

            if status != Z_OK && status != Z_STREAM_END { return nil }
            let dataLength = Data.GZIP_BUF_LENGTH - Int(stream.avail_out)
            if dataLength > 0 {
                compressed.append(gzipBuf,length:dataLength)
            }
        }

        return compressed as Data
    }

    
    
    static func testGzip() {
        
        let string = "Hello你好"
        guard let helloData =  string.data(using: .utf8) else {
            return
        }
        
        guard  let compressData =   helloData.gzipCompress() else {
            return
        }
        
        guard let uncompressData =  compressData.gzipUncompress() else {
            return
        }
        let resString =  String(data: uncompressData, encoding: .utf8)
        print("resString:\(resString ?? "")")
        
    }
}

