unit uSerialValidator;

interface

type
  TSerial          = String[50];
  TSerialValidator = class
                     private
                     protected
                     public
                       class function Validate(const ASerial: TSerial): Boolean;
                     end;

implementation

uses
  System.SysUtils;

class function TSerialValidator.Validate(const ASerial: TSerial): Boolean;
var
  raw: String;
  ch : Char;
begin
  raw := '';
  for ch in UpperCase(String(ASerial)) do
    if CharInSet(ch, ['0'..'9', 'A'..'Z']) then
      raw := raw + ch;

  result := raw = '3K1AGCG88ATX80M193AXSKAP4'; // 3K1AGCG88ATX80M193AXSKAP4 >>> 3K1AG-CG88A-TX80M-193AX-SKAP4
end;

end.

