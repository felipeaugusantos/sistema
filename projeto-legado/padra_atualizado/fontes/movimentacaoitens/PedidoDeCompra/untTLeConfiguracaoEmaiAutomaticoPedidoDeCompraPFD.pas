unit untTLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD;

interface
   uses Data.DB, uni,SysUtils, untFuncoesSimples;

   type
     TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD = class
     private
       FcbxLayout       : String;
       FchkCodbarras    : string;
       FchkCodFab       : string;
       FchkImpObs       : string;
       FchkImpVenda     : string;
       FChkImpReferencia: string;
       FchkLocFis       : string;
       FchkMarca        : string;
       FchkMltCmp       : string;
       FedtContato      : string;
       FedtEmail        : string;
       FgbOrdem        : Char;
       FchkPreco        : string;
       FedtTipExp       : string;
       FrdgOrientacao   : string;
       FrdgQuantidade   : string;
       FEdtCodLay       : String;
       qryConsulta: TUniQuery;
       FTemCadInd: Boolean;
       function fGetValueCbxlayout: String;
       function fGetchkPreco: Boolean;
       function fGetchkMarca: Boolean;
       function fGetchkCodbarras: Boolean;
       function fGetChkImpReferencia: Boolean;
       function fchkImpVen: Boolean;
       function fGetrdgQuantidade: integer;
       function fGetedtTipExp: string;
       function fGetchkImpObs: Boolean;
       function fGetedtContato: string;
       function fGetgbOrdem: Char;
       function fGetchkMltCmp: Boolean;
       function fGetrdgOrientacao: integer;
       function fGetedtEmail: string;
       function fGetchkCodFab: Boolean;
       function fGetchkLocFis: Boolean;
       function fGetEdtCodLay: String;
       procedure pCarregaValoresPadrao;
       function fLocateComponenteValue(NomeComponente: string; var AValue: string): Boolean;
     public
       constructor Create(FChave: String); reintroduce;
       destructor Destroy; override;
       property blnTemCadInt: Boolean read FTemCadInd;
       property cbxLayout           : String     read fGetValueCbxlayout;
       property chkCodbarras        : Boolean    read fGetchkCodbarras;
       property chkCodFab           : Boolean    read fGetchkCodFab;
       property chkImpObs           : Boolean    read fGetchkImpObs;
       property ChkImpReferencia    : Boolean    read fGetChkImpReferencia;
       property chkImpVen           : Boolean    read fchkImpVen;
       property chkLocFis           : Boolean    read fGetchkLocFis;
       property chkMarca            : Boolean    read fGetchkMarca;
       property chkMltCmp           : Boolean    read fGetchkMltCmp;
       property edtContato          : string     read fGetedtContato;
       property edtEmail            : string     read fGetedtEmail;
       property gbOrdem            : char     read fGetgbOrdem;
       property chkPreco            : Boolean     read fGetchkPreco;
       property edtTipExp           : string     read fGetedtTipExp;
       property rdgOrientacao       : integer    read fGetrdgOrientacao;
       property rdgQuantidade       : integer    read fGetrdgQuantidade;
       property edtCodLay           : string     read fGetEdtCodLay;
     end;


implementation

{ TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD }

constructor TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.Create(
  FChave: String);
begin
  FTemCadInd := True;
  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add('SELECT * FROM CADINT WHERE INT_VALKEY = "'+FChave+'"');
  qryConsulta.Open;
  If qryConsulta.IsEmpty Then
  begin
    pCarregaValoresPadrao;
    FTemCadInd := False;
  End
end;

destructor TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.Destroy;
begin
  FreeAndNil(qryConsulta);
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fchkImpVen: Boolean;
var Value: string;
begin
  Result := FchkImpVenda = '1';
  If fLocateComponenteValue('chkImpVen', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkCodbarras: Boolean;
var Value: string;
begin
  Result := FchkCodbarras = '1';
  If fLocateComponenteValue('chkCodbarras', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkCodFab: Boolean;
var Value: string;
begin
  Result := FchkCodFab = '1';
  If fLocateComponenteValue('chkCodFab', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkImpObs: Boolean;
var Value: string;
begin
  Result := FchkImpObs = '1';
  If fLocateComponenteValue('chkImpObs', Value) Then
    Result := Value = '1';


end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetChkImpReferencia: Boolean;
var Value: string;
begin
  Result := FChkImpReferencia = '1';
  If fLocateComponenteValue('ChkImpReferencia', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkLocFis: Boolean;
var Value: string;
begin
  Result := FchkLocFis = '1';
  If fLocateComponenteValue('chkLocFis', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkMarca: Boolean;
var Value: string;
begin
  Result := FchkMarca = '1';
  If fLocateComponenteValue('chkMarca', Value) Then
    Result := Value = '1';

end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkMltCmp: Boolean;
var Value: string;
begin
  Result := FchkMltCmp = '1';
  If fLocateComponenteValue('chkMltCmp', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetEdtCodLay: String;
  var Value: string;
begin
  Result := FedtCodLay;
  If fLocateComponenteValue('edtCodLay', Value) Then
    Result := Value;
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetedtContato: string;
var Value: string;
begin
  Result := FedtContato;
  If fLocateComponenteValue('edtContato', Value) Then
    Result := Value;
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetedtEmail: string;
var Value: string;
begin
  Result := FedtEmail;
  If fLocateComponenteValue('edtEmail', Value) Then
    Result := Value;
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetgbOrdem: char;
var Value: string;
begin
  Result := FgbOrdem;
  If fLocateComponenteValue('gbOrdem', Value) Then
  begin
    Result := 'D';
    If Value = 'Digitação' then
      Result := 'D';
    If Value = 'Alfabética' then
      Result := 'A';
    If Value = 'Cód. Fábrica' then
      Result := 'F';
  End;
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetchkPreco: Boolean;
var Value: string;
begin
  Result := FchkPreco = '1';
  If fLocateComponenteValue('chkPreco', Value) Then
    Result := Value = '1';
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetedtTipExp: string;
  var Value: string;
begin
  Result := FedtTipExp;
  If fLocateComponenteValue('edtTipExp', Value) Then
    Result := Value;

end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetrdgOrientacao: integer;
  var Value: string;
begin
  Result := 0;
  If fLocateComponenteValue('rdgOrientacao', Value) Then
  Begin
    If Value = 'Retrato' Then
      Result := 0
    Else
      Result := 1;
  End;
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetrdgQuantidade: integer;
  var Value: string;
begin
  Result := 0;
  If fLocateComponenteValue('rdgQuantidade', Value) Then
  Begin
    If Value = 'Total' Then
      Result := 0
    Else If Value = 'Pendente' Then
      Result := 1
    Else
      Result := 2;
  End;

end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fGetValueCbxlayout: string;
  var Value: string;
begin
  Result := FcbxLayout;
  If fLocateComponenteValue('cbxLayout', Value) Then
    Result := Value
end;

function TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.fLocateComponenteValue(NomeComponente: string; var AValue: string): Boolean;
begin
  AValue := '';
  Result := false;
  If qryConsulta.IsEmpty Then
    Exit;

  qryConsulta.First;
  If qryConsulta.Locate('INT_NOMCOM', NomeComponente, []) Then
  Begin
    Result := True;
    AValue :=  qryConsulta.FieldByName('INT_VALCOM').AsString;
  End;
end;

procedure TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.pCarregaValoresPadrao;
begin
  FcbxLayout := '';
  FchkCodbarras := '1';
  FchkCodFab :=  '1';
  FchkImpObs :=  '1';
  FChkImpReferencia :=  '1';
  FchkImpVenda := '0';
  FchkLocFis :=  '1';
  FchkMarca :=  '1';
  FchkMltCmp :=  '0';
  FedtContato := '';
  FedtEmail := '';
  FgbOrdem := 'D';
  FchkPreco := '1';
  FedtTipExp := '';
  FrdgOrientacao := 'Retrato';
  FrdgQuantidade := 'Total';
  FEdtCodLay := '';
end;

end.


