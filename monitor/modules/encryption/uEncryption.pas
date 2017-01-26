unit uEncryption;

interface

uses
  System.Classes, SBSymmetricCrypto, SBUtils;

type
  TEncryption = class
                private
                  const
                    DEFAULT_CRYPT_KEY = 'p6m5_e3$9--#HLTI{a-rG-]J8@%-k203';
                    DEFAULT_CRYPT_IV  = '${L54vl_M-kd:0_!';

                  class function GenerateKeyMaterial(const Key, IV: string): TElSymmetricKeyMaterial;
                protected
                public
                  class procedure Decrypt(const AInStream : TStream; out AOutStream : TStream; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
                  class procedure Encrypt(const AInStream : TStream; out AOutStream : TStream; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
                  class procedure EncryptFile(const AFile : String; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
                  class procedure DecryptFile(const AFile : String; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
                end;

implementation

uses
  System.SysUtils, SBConstants;

class function TEncryption.GenerateKeyMaterial(const Key, IV: string): TElSymmetricKeyMaterial;
begin
  Result := TElSymmetricKeyMaterial.Create;
  Result.Key := SBUtils.BytesOfString(Key);
  Result.IV := SBUtils.BytesOfString(IV);
end;

class procedure TEncryption.EncryptFile(const AFile : String; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
var
  fs  : TFileStream;
  ms  : TStream;
begin
  ms := TMemoryStream.Create;
  try
    fs := TFileStream.Create(AFile, fmOpenRead);
    try
      Encrypt(fs, ms, AKey, AIV);
    finally
      fs.Free;
    end;
    (ms as TMemoryStream).SaveToFile(AFile);
  finally
    ms.Free;
  end;
end;

class procedure TEncryption.DecryptFile(const AFile : String; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
var
  fs : TFileStream;
  ms : TStream;
begin
  ms := TMemoryStream.Create;
  try
    fs := TFileStream.Create(AFile, fmOpenRead);
    try
      Decrypt(fs, ms, AKey, AIV);
    finally
      fs.Free;
    end;
    (ms as TMemoryStream).SaveToFile(AFile);
  finally
    ms.Free;
  end;
end;

class procedure TEncryption.Decrypt(const AInStream : TStream; out AOutStream : TStream; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
var
  Factory : TElSymmetricCryptoFactory;
  Crypto  : TELSymmetricCrypto;
begin
  Factory := TElSymmetricCryptoFactory.Create;
  try
    Crypto := Factory.CreateInstance(SB_ALGORITHM_CNT_AES256, cmECB);
    Crypto.Padding := cpPKCS5;
    Crypto.KeyMaterial := GenerateKeyMaterial(AKey, AIV);
    Crypto.Decrypt(AInStream, AOutStream);
  finally
    Factory.Free;
  end;
end;

class procedure TEncryption.Encrypt(const AInStream : TStream; out AOutStream : TStream; const AKey : String = DEFAULT_CRYPT_KEY; const AIV : String = DEFAULT_CRYPT_IV);
var
  Factory : TElSymmetricCryptoFactory;
  Crypto  : TELSymmetricCrypto;
begin
  Factory := TElSymmetricCryptoFactory.Create;
  try
    Crypto := Factory.CreateInstance(SB_ALGORITHM_CNT_AES256, cmECB);
    Crypto.Padding := cpPKCS5;
    Crypto.KeyMaterial := GenerateKeyMaterial(AKey, AIV);
    Crypto.Encrypt(AInStream, AOutStream);
  finally
    Factory.Free;
  end;
end;

end.
