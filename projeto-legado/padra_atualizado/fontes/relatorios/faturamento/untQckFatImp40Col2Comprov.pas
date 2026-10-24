unit untQckFatImp40Col2Comprov;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, frxDMPClass, frxDMPExport, DB, Uni, UniClientDataSet,
  StrUtils, untFuncoesGenerica, MemDS, DBAccess, Datasnap.DBClient;

type
  TProGuilhotina = Procedure Of Object;

  TfrmQckFatImp40Col2Comprov = class(TForm)
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxComprovM: TfrxReport;
    frxComprovJ: TfrxReport;
    frxCompro: TfrxReport;
    procedure FormCreate(Sender: TObject);
    function frxComprovMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    strSalto: String;
    pAcionaGuilhotina: TProGuilhotina;
    qryFatGor : TUniQuery;
    qryCfgRel: TUniQuery;
    procedure pCarregarDocumento(strNumDoc, strEspDoc, strCodEmp: String);
    function fRetornaTituloEspDoc(strEspDoc, strNumDoc: String):String;
  public
    { Public declarations }
    procedure pImprimeComprovante(strNumDoc, strEspDoc, strCodEmp: String);
  end;


implementation

uses untFuncoesSimples, untCfgRel, untFuncoes, untConstantes;

{$R *.dfm}

procedure TfrmQckFatImp40Col2Comprov.FormCreate(Sender: TObject);
  Var
    intContador : Integer;
begin
  qryCfgRel := fCriaQuery(Self);
  qryFatgor := fCriaQuery(Self);

  frxComprovM.AddFunction('procedure pAcionaGuilhotina');

  strSalto := '';

  If fCfgSis('QTDSAL', varInteger) > 0 Then
  Begin
    For intContador := 1 To fCfgSis('QTDSAL', varInteger) Do
      strSalto := strSalto + '       ' + #13#10;
  End;
end;

procedure TfrmQckFatImp40Col2Comprov.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryFatgor);
  FreeAndNil(qryCfgRel);
end;

function TfrmQckFatImp40Col2Comprov.frxComprovMUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText('pAcionaGuilhotina', MethodName) And
     (fCfgSis('CMP40C') = 2) Then
  Begin
    If Assigned(pAcionaGuilhotina) Then
      pAcionaGuilhotina;
  End;
end;

procedure TfrmQckFatImp40Col2Comprov.pCarregarDocumento(strNumDoc, strEspDoc, strCodEmp: String);
begin
  With qryFatgor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  IF(LOCATE("CONSUMIDOR", CLI_NOMCLI) > 0, FGO_NOMCON, CONCAT(FGO_CODCLI, " - ", CLI_NOMCLI)) AS CLIENT, ');
    SQL.Add('  CONCAT(FGO_CODVEN, " - ", OPE_NOMOPE) AS VENDED, ');
    SQL.Add('  IFNULL(CONCAT(FGO_CODCND, " - ", CND_DESCRI), "") AS CONDIC, ');
    SQL.Add('  IFNULL(CONCAT(FGO_CODFPG, " - ", FPG_DESCRI), "") AS FPGPGO, ');
    SQL.Add('  FGO_DTAENT, FGO_HORENT, FGO_VLRCON, FGO_CONPAG, ');
    SQL.Add('  FATGOR.AUTOINCREM AS FGOINC, FGO_TIPOPE ');
    SQL.Add('FROM ');
    SQL.Add('  FATGOR ');
    SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
    SQL.Add('  JOIN CADOPE ON OPE_CODOPE = FGO_CODVEN ');
    SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND ');
    SQL.Add('  LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG ');
    SQL.Add('WHERE ');
    SQL.Add('  FGO_NUMDOC = :NUMDOC ');
    SQL.Add('  AND FGO_ESPDOC = :ESPDOC ');
    SQL.Add('  AND FGO_CODEMP = :CODEMP ');
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
end;

procedure TfrmQckFatImp40Col2Comprov.pImprimeComprovante(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    strTipImp: String;
    blnImprime: Boolean;
    strVended2: String;
    strConPag: String;
    strFilaDoc: String;
    strCompro: String;
    frxComprov: TfrxReport;
begin
  If (Pos(strEspDoc, 'OR_PD_') <= 0) Then
    Exit;

  If Not (fCfgSis('IMPCPV', varBoolean)) Then
    Exit;

  pCarregarDocumento(strNumDoc, strEspDoc, strCodEmp);

  if FileExists(fCfgSis('PATETI') + '\frxDefComprovante.fr3') then
     strCompro := fCfgSis('PATETI') + '\frxDefComprovante.fr3';

  blnImprime := True;
  strFilaDoc := '';

  If fCfgSis('PERIOR', varBoolean) Then
    blnImprime := (fMensagem('ATENÇÃO!', 'Imprimir comprovante 40c?', ['&Sim', '&Não']) = 1);

  If (blnImprime) Then
  Begin
    pCarregaConfImpr(qryCfgRel, 'frmFatVendas_COMPROVANTE', VS_strCodEmp);
    blnImprime := fPreImpressao(qryCfgRel, strFilaDoc, strTipImp, False);

    If (blnImprime) Then
    Begin
      If (strTipImp = 'M') Then
        frxComprov := frxComprovM
      Else
      Begin
        If Not fEmptyStr(strCompro) Then
        Begin
          frxCompro.LoadFromFile(strCompro);
          frxComprov := frxCompro;
        End
        Else
          frxComprov := frxComprovJ;
      End;

      strVended2 := fRetVendedor2PedOrc(qryFatGor.FieldByName('FGOINC').AsString);
      If (Not fEmptyStr(strVended2)) Then
        strVended2 := strVended2 + ' - ' + fRetNomVendRep(strVended2);

      If (fStatusCndPag(qryFatGor.FieldByName('FGO_CONPAG').AsString) = A_PRAZO) Then
        strConPag := fFormataCondPag(qryFatGor.FieldByName('FGO_CONPAG').AsString)
      Else
        strConPag := 'A VISTA';

      frxComprov.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxComprov.Script.Variables['TITULO'] := fRetornaTituloEspDoc(strEspDoc, strNumDoc);
      frxComprov.Script.Variables['CLIENT'] := qryFatGor.FieldByName('CLIENT').AsString;
      frxComprov.Script.Variables['VENDED'] := qryFatGor.FieldByName('VENDED').AsString;
      frxComprov.Script.Variables['VENDE2'] := strVended2;

      frxComprov.Script.Variables['DTAENT'] := FormatDateTime('dd/mm/yyyy', qryFatGor.FieldByName('FGO_DTAENT').AsDateTime);
      frxComprov.Script.Variables['HORENT'] := FormatDateTime('hh:nn:ss', qryFatGor.FieldByName('FGO_HORENT').AsDateTime);
      frxComprov.Script.Variables['VLRCON'] := FloatToStrF(qryFatGor.FieldByName('FGO_VLRCON').AsFloat, ffFixed, 12, 2);
      frxComprov.Script.Variables['CODVEN'] := LeftStr(qryFatGor.FieldByName('VENDED').AsString, 3);
      frxComprov.Script.Variables['NUMDOC'] := strNumDoc;

      frxComprov.Script.Variables['CONDI1'] := strConPag;
      If (fCfgSis('USACND', varBoolean)) Then
        frxComprov.Script.Variables['CONDI2'] := qryFatGor.FieldByName('CONDIC').AsString
      Else
        frxComprov.Script.Variables['CONDI2'] := '';

      frxComprov.Script.Variables['FPGPGO'] := qryFatGor.FieldByName('FPGPGO').AsString;

      frxComprov.Script.Variables['SALTO'] := strSalto;

      If fEmptyStr(strCompro) Then
      Begin
        If fCfgSis('CMP40C') = 1 Then
        Begin
          TfrxDMPMemoView(frxComprov.FindObject('CComprovante')).Visible              := True;
          TfrxDMPMemoView(frxComprov.FindObject('CComprovanteSimplificado')).Visible  := False;
        End
        Else
        Begin
          TfrxDMPMemoView(frxComprov.FindObject('CComprovante')).Visible              := False;
          TfrxDMPMemoView(frxComprov.FindObject('CComprovanteSimplificado')).Visible  := True;
        End;
      End;

      If fEmptyStr(strFilaDoc) Then
        frxComprov.PrintOptions.ShowDialog := True
      Else
        frxComprov.PrintOptions.Printer := AnsiReplaceText(strFilaDoc,'\\' + fRetNomeRede + '\','');

      If frxComprov.PrepareReport Then
        pPrintReport('frmFatVendas_COMPROVANTE', 'Faturamento - Impressão de comprovante', strFilaDoc, frxComprov);
    End;
  End;
end;

function TfrmQckFatImp40Col2Comprov.fRetornaTituloEspDoc(strEspDoc, strNumDoc: String): String;
  Var
    strEspecie: String;
begin
  strEspecie := '';

  If (strEspDoc = 'PR') Then
    strEspecie := 'PEDIDO RETIRA '
  Else If (strEspDoc = 'OR') Then
    strEspecie := 'ORCAMENTO '
  Else If (strEspDoc = 'PD') Then
  Begin
    If (qryFatGor.FieldByName('FGO_TIPOPE').AsString = 'B') Then
      strEspecie := 'PD-BONIFICACAO '
    Else If (qryFatGor.FieldByName('FGO_TIPOPE').AsString = 'C') Then
      strEspecie := 'PD-CONTA E ORDEM '
    Else
      strEspecie := 'PEDIDO ';
  End;

  Result := strEspecie + 'Nº ' + strNumDoc;
end;

End.

