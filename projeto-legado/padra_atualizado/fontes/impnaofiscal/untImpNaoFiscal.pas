unit untImpNaoFiscal;

interface

uses Windows, SysUtils, ComCtrls;

Const
  NAOFISCAL_BEMATECH = 'BEMATECH';
  NAOFISCAL_DARUMA = 'DARUMA';
  NAOFISCAL_SWEDA = 'SWEDA';
  NAOFISCAL_EPSON = 'EPSON';

Type
  TImpNaoFiscal = class(TObject)

    private
    protected
      FEditor: TRichEdit;
      FHandle: THandle;
      strPatDll: String;

      procedure pCarregaDll; virtual;
    public
      class function fCriaImpressora(const strImpressora: String): TImpNaoFiscal;

      procedure pEscreveNormal(strTexto: String);
      procedure pEscreveNegrito(strTexto: String); virtual;
      procedure pAcionaGuilhotina(blnCorteTotal: Boolean); virtual; abstract;
      procedure pAbreGaveta; virtual; abstract;
  End;

implementation

uses untImpNaoFiscalBematech, untImpNaoFiscalDaruma, untImpNaoFiscalSweda,
     untImpNaoFiscalEpson;

{ TImpNaoFiscal }

class function TImpNaoFiscal.fCriaImpressora(
  const strImpressora: String): TImpNaoFiscal;
begin

  Result := Nil;

  If (strImpressora = NAOFISCAL_BEMATECH) Then
    Result := TImpNaoFiscalBematech.Create
  Else If (strImpressora = NAOFISCAL_DARUMA) Then
    Result := TImpNaoFiscalDaruma.Create
  Else If (strImpressora = NAOFISCAL_SWEDA) Then
    Result := TImpNaoFiscalSweda.Create
  Else If (strImpressora = NAOFISCAL_EPSON) Then
    Result := TImpNaoFiscalEpson.Create;

end;

procedure TImpNaoFiscal.pCarregaDll;
begin

  If (Not FileExists(strPatDll)) Then
    Raise Exception.CreateFmt('Dll: %s não existe', [strPatDll]);

  FHandle := LoadLibrary(PChar(strPatDll));
  If (FHandle = 0) Then
    Raise Exception.Create('Não foi possível carregar a Dll');
end;

{*****************************************}
{* QUANDO FOR IMPLEMENTAR UMA IMPRESSÃO  *}
{* MAIS SOFISTICADA EM IMPRESSORAS NÃO   *}
{* FISCAIS, REVER ESSE JEITO DE FAZER.   *}
{**************************************MV*}
procedure TImpNaoFiscal.pEscreveNegrito(strTexto: String);
begin
  pEscreveNormal(strTexto);
end;

procedure TImpNaoFiscal.pEscreveNormal(strTexto: String);
begin
  FEditor.Lines.Add(strTexto);
end;

end.
