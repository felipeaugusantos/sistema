unit untTEditFocusWithTConsultasArray;

interface

  uses SysUtils, MaskEditFocus, EditFocus, Winapi.Messages, Vcl.Controls, System.Classes, Vcl.Graphics, System.UITypes, untTypesSistema;

  Type
    TFuncoesExtend = Record
      Size: integer;
      function fConsultasArrayToText(AConsultasArray: TConsultasArray): String;
      function fTextToConsultasArray(var ATtext: String): TConsultasArray;
    End;

    TEditFocus = class(EditFocus.TEditFocus)
    private
      FuncoesExtend: TFuncoesExtend;
    public
      ConsultasArray: TConsultasArray;
      function ExtraiListaAConsultasArray: string;
      procedure pIncorporaConsultaArray(ATexto: string);
      constructor Create(AOwner: TComponent); override;
    End;

    TMaskEditFocus = class(MaskEditFocus.TMaskEditFocus)
    private
      FuncoesExtend: TFuncoesExtend;
    public
      TamanhoCodigo: integer;
      ConsultasArray: TConsultasArray;
      function ExtraiListaAConsultasArray: string;
      procedure pIncorporaConsultaArray(ATexto: string);
      constructor Create(AOwner: TComponent); override;

    End;

    const cChaveIdentificaConsultasArray = 'ConsultasArray=';

implementation

{ TFuncoesExtend }

function TFuncoesExtend.fConsultasArrayToText(
  AConsultasArray: TConsultasArray): String;
  var Consulta: TConsultas;
begin
  Result := cChaveIdentificaConsultasArray;
  For Consulta in AConsultasArray do
    Result := Result + Consulta.strCodigo + '|' ;
  Result := Copy(Result, 0, Length(Result) -1);
end;

function TFuncoesExtend.fTextToConsultasArray(
  var ATtext: String): TConsultasArray;
  var  List: TStringList;
  i: integer;
begin
  If (Pos(cChaveIdentificaConsultasArray, ATtext) < 1) Then
    Exit;

  List := TStringList.Create;
  Try
    List.Delimiter := '|';
    List.DelimitedText := StringReplace(ATtext , cChaveIdentificaConsultasArray, '', []);
    SetLength(Result, List.Count);

    For i := 0 To List.Count -1 Do
      Result[i].strCodigo := List[i];

    If High(Result) > 0 Then
      Size := Length(Result[0].strCodigo)
  Finally
    FreeAndNil(List);
  End;

end;

{ TEditFocus }

constructor TEditFocus.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(ConsultasArray, 0);
end;

function TEditFocus.ExtraiListaAConsultasArray: string;
begin
  Result := FuncoesExtend.fConsultasArrayToText(ConsultasArray);
end;

procedure TEditFocus.pIncorporaConsultaArray(ATexto: string);
begin
  ConsultasArray := FuncoesExtend.fTextToConsultasArray(ATexto);
end;

{ TMaskEditFocus }

constructor TMaskEditFocus.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(ConsultasArray, 0);
end;

function TMaskEditFocus.ExtraiListaAConsultasArray: string;
begin
  Result := FuncoesExtend.fConsultasArrayToText(ConsultasArray);
end;

procedure TMaskEditFocus.pIncorporaConsultaArray(ATexto: string);
begin
  ConsultasArray := FuncoesExtend.fTextToConsultasArray(ATexto);
  TamanhoCodigo := FuncoesExtend.Size;
end;

end.
