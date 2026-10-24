unit untTipoFreteAtc;

interface

uses SysUtils, untInterfaces, Classes;

function fFreteValido(strTipo: String): Boolean;
function fTipoFrete(strDescricao: String): String;
function fDescricaoFrete(strTipo: String): String;
function fConverteParaTipoNfe(strTipo: String): TTipoFrete;
function fRetSQLDescricaoFrete(strCampo: String): string;
function fCalculaFrete(const strTipo, strCadFrgTipFre: String): Boolean;
procedure pCarregarDescricaoFrete(const AItems : TStrings);

Const
  TiposFreteNFe: Array[0..5] Of TTipoFrete = (tfCif, tfFob, tfTerceiros, tfSemFrete, tfTransporteProprioRemetente, tfTransporteProprioDestinatario);

implementation

Const
  TiposFrete: Array[0..5] Of Integer = (1, 2, 3, 9, 4, 5);
  DescricoesFrete: Array[0..5] Of String = ('Emitente(CIF)', 'Destinatário(FOB)', 'Terceiros', 'Sem Frete', 'Transporte Próprio Remetente', 'Transporte Próprio Destinatário');

function fFreteValido(strTipo: String): Boolean;
  Var
    intIndice: Integer;
    intTipo: Integer;
begin
  Result := False;
  intTipo := StrToIntDef(strTipo, -1);
  For intIndice := Low(TiposFrete) To High(TiposFrete) Do
  Begin
    If intTipo = TiposFrete[intIndice] Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function fTipoFrete(strDescricao: String): String;
  Var
    intIndice: Integer;
begin
  Result := '';
  For intIndice := Low(TiposFrete) To High(TiposFrete) Do
  Begin
    If strDescricao = DescricoesFrete[intIndice] Then
    Begin
      Result := IntToStr(TiposFrete[intIndice]);
      Break;
    End;
  End;
end;

function fDescricaoFrete(strTipo: String): String;
  Var
    intIndice: Integer;
    intTipo: Integer;
begin
  Result := 'Inválido';
  intTipo := StrToIntDef(strTipo, -1);
  For intIndice := Low(TiposFrete) To High(TiposFrete) Do
  Begin
    If intTipo = TiposFrete[intIndice] Then
    Begin
      Result := DescricoesFrete[intIndice];
      Break;
    End;
  End;
end;

function fConverteParaTipoNfe(strTipo: String): TTipoFrete;
  Var
    intIndice: Integer;
    intTipo: Integer;
begin
  Result := tfSemFrete;
  intTipo := StrToIntDef(strTipo, -1);
  For intIndice := Low(TiposFrete) To High(TiposFrete) Do
  Begin
    If intTipo = TiposFrete[intIndice] Then
    Begin
      Result := TiposFreteNFe[intIndice];
      Break;
    End;
  End;
end;

function fRetSQLDescricaoFrete(strCampo: String): string;
var i: integer;
begin
  Result := '';

  Result := Result + ' CASE ';
  For i := 0 To High(TiposFrete) Do
    Result := Result + '  WHEN ' + strCampo + ' = ' + IntToStr(TiposFrete[i]) + ' THEN "' + DescricoesFrete[i] + '" ';
  Result := Result + ' END ';
End;

function fCalculaFrete(const strTipo, strCadFrgTipFre: String): Boolean;
var
  intIndice: Integer;
begin
  Result := False;
  For intIndice := Low(DescricoesFrete) To High(DescricoesFrete) Do
  Begin
    If strTipo = DescricoesFrete[intIndice] Then
    Begin
      Result := Copy(strCadFrgTipFre, intIndice + 1, 1) = 'S';
      Break;
    End;
  End;
end;

procedure pCarregarDescricaoFrete(const AItems : TStrings);
  Var
    strDescricaoFrete : String;
begin
  For strDescricaoFrete in DescricoesFrete Do
    AItems.Add(strDescricaoFrete);
end;

end.
