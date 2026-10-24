unit Produto.GS1CNP.Shared.Exception;

interface

uses System.SysUtils;

type
  ErroConsultaView = class(Exception)
  end;

type
  TConvertCamposObrigatorios = class
  private
    class function GetMessageClassificaoDoProduto(const AValue: String): Boolean;
    class function GetMessageCodigoDaUnidadeDeMedida(const AValue: String): Boolean;
  public
    class function GetMessage(const AValue: String): String;
  end;

implementation

{ TConvertCamposObrigatorios }

class function TConvertCamposObrigatorios.GetMessage(
  const AValue: String): String;
begin
  Result := AValue;

  If GetMessageClassificaoDoProduto(AValue) Then
    Result := 'Valor da Classificação do produto tem que ser preenchido!';

  If GetMessageCodigoDaUnidadeDeMedida(AValue) Then
    Result := 'Código da unidade de medida GS1 tem que ser preenchido!';
end;

class function TConvertCamposObrigatorios.GetMessageClassificaoDoProduto(
  const AValue: String): Boolean;
begin
  Result := False;

  If (Pos('additionalTradeItemClassificationCodeValue', AValue) <= 0) Then
    Exit;

  If (Pos('is not allowed to be empty', AValue) <= 0) Then
    Exit;

  Result := True;
end;

class function TConvertCamposObrigatorios.GetMessageCodigoDaUnidadeDeMedida(
  const AValue: String): Boolean;
begin
  Result := False;

  If (Pos('measurementUnitCode', AValue) <= 0) Then
    Exit;

  If (Pos('is not allowed to be empty', AValue) <= 0) Then
    Exit;

  Result := True;
end;

end.
