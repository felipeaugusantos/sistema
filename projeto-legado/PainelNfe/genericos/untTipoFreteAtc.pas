unit untTipoFreteAtc;

interface

uses SysUtils, untInterfaces;

function fFreteValido(strTipo: String): Boolean;
function fTipoFrete(strDescricao: String): String;
function fDescricaoFrete(strTipo: String): String;
function fConverteParaTipoNfe(strTipo: String): TTipoFrete;

implementation

Const
  TiposFreteNFe: Array[0..5] Of TTipoFrete = (tfCif, tfFob, tfTerceiros, tfSemFrete, tfTransporteProprioRemetente, tfTransporteProprioDestinatario);
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

end.
