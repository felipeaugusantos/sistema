unit untQckRcxReciboCob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, RLFilters, RLDraftFilter, RLParser, StrUtils, Uni, DB,
  untFuncoesGenerica, MaskUtils,untRelQckRcxReciboCob,untFastPrintEditor,UniClientDataSet,
  RLPDFFilter, RLPreviewForm,
  frxClass; //MF: 290025 - 16/06/23

type
  TfrmQckRcxReciboCob = class(TForm)
    qckPagina: TRLReport;
    rlbHeader1: TRLBand;
    rllNomEmp: TRLLabel;
    rllFone: TRLLabel;
    rllCidade: TRLLabel;
    rllEndereco: TRLLabel;
    rllBairro: TRLLabel;
    rllCep: TRLLabel;
    rlbHeader2: TRLBand;
    rllNumDoc: TRLLabel;
    rllNomCliDup: TRLLabel;
    rllEndDup: TRLLabel;
    rllCodCliDup: TRLLabel;
    rllBairroDup: TRLLabel;
    rllMunicDup: TRLLabel;
    rllCgcCpfDup: TRLLabel;
    rllCepDup: TRLLabel;
    rllRgDup: TRLLabel;
    rllFone01: TRLLabel;
    rlbHeader3: TRLBand;
    rllCodigo: TRLLabel;
    rlbSumario1: TRLBand;
    rllTotPed: TRLLabel;
    rlbSumario2: TRLBand;
    rlbFooter1: TRLBand;
    rllImpressao: TRLLabel;
    rlbDetail: TRLBand;
    rdbCodIte: TRLDBText;
    rlbEspaco: TRLBand;
    rllFone02: TRLLabel;
    rllRecebi: TRLLabel;
    rllSegDuplic: TRLLabel;
    rllEmp: TRLLabel;
    rllEmissao: TRLLabel;
    rllVencimento: TRLLabel;
    RLLabel6: TRLLabel;
    rllJuros: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    rdbValTot: TRLDBResult;
    RLPanel1: TRLPanel;
    RLLabel10: TRLLabel;
    rllOperador: TRLLabel;
    rllData: TRLLabel;
    rllValExtenso: TRLLabel;
    RLExpressionParser1: TRLExpressionParser;
    rldFiltro: TRLDraftFilter;
    dtsRelat: TDataSource;
    rllDataImpressao: TRLLabel;
    rllTotGeral: TRLLabel;
    rllTotGer: TRLLabel;
    rpsSetup: TRLPreviewSetup;
    RLPDFFilter: TRLPDFFilter;
    procedure rlbHeader1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllNomEmpBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbHeader1AfterPrint(Sender: TObject);
    procedure rllFoneBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCidadeBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllEnderecoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllBairroBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCepBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbHeader2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllOperadorBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllDataBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetailBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllValExtensoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllNumDocBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rlbEspacoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbDetailAfterPrint(Sender: TObject);
    procedure rllRecebiBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllRgDupBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllSegDuplicBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllCodigoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllEmpBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllEmissaoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVencimentoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllJurosBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllImpressaoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllDataImpressaoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    intContador: Integer;
    qryGenEmp  : TUniQuery;
    FPais      : TPais;
    fltTotGer  : Double;
  public
    { Public declarations }
    strCodOpe: String;
    strCodCli: String;
    strTipImp: String;
    function fImprimirReciboCobranca(cdsRelCtr : TUniClientDataSet = Nil; strCodCli : String = '') : Boolean;
  end;


implementation

uses  untfuncoesSimples, untValorPorExtenso;

{$R *.dfm}

procedure TfrmQckRcxReciboCob.rlbHeader1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

end;

procedure TfrmQckRcxReciboCob.rllNomEmpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  If (strTipImp = 'M') Then
//    Text := #27 + 'P' + #18 + #27 + 'W' + #1 + '  '
//  Else
    Text := '';
    
  Text := Text + qryGenEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmQckRcxReciboCob.rlbHeader1AfterPrint(Sender: TObject);
begin
  fFecharTabela(qryGenEmp)
end;

procedure TfrmQckRcxReciboCob.rllFoneBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'FONE: ' + fFormataFone(qryGenEmp.FieldByName('EMP_FONE01').AsString);
//  If (strTipImp = 'M') Then
//    Text := Text + #27 + 'M' + #15 + #27 + 'W' + #0;
end;

procedure TfrmQckRcxReciboCob.rllImpressaoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'LA IMPRESION CONTINUA EN LA PAGINA SIGUIENTE'
  Else
    Text := 'IMPRESSAO CONTINUA NA PROXIMA PAGINA';
end;

procedure TfrmQckRcxReciboCob.rllJurosBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'INTERES'
  Else
    Text := 'VR. JUROS';
end;

procedure TfrmQckRcxReciboCob.rllCidadeBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'Ciudad: ' + fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
                         fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1)
  Else
    Text := 'Cidade: ' + fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
                         fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1);
end;

procedure TfrmQckRcxReciboCob.rllCodigoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'DUPLICADO'
  Else
    Text := 'DUPLICATA';
end;

procedure TfrmQckRcxReciboCob.rllEmissaoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'EMISION'
  Else
    Text := 'EMISSAO';
end;

procedure TfrmQckRcxReciboCob.rllEmpBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'NEG'
  Else
    Text := 'EMP';
end;

procedure TfrmQckRcxReciboCob.rllEnderecoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'Direccion: ' + qryGenEmp.FieldByName('EMP_ENDERE').AsString + IIF(fEmptyStr(qryGenEmp.FieldByName('EMP_ENDCMP').AsString), '', ', ') +
                            qryGenEmp.FieldByName('EMP_ENDCMP').AsString + ', ' + qryGenEmp.FieldByName('EMP_ENDNUM').AsString
  Else
    Text := 'Endereco: ' + qryGenEmp.FieldByName('EMP_ENDERE').AsString + IIF(fEmptyStr(qryGenEmp.FieldByName('EMP_ENDCMP').AsString), '', ', ') +
                           qryGenEmp.FieldByName('EMP_ENDCMP').AsString + ', ' + qryGenEmp.FieldByName('EMP_ENDNUM').AsString;
end;

procedure TfrmQckRcxReciboCob.rllBairroBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Bairro: ' + qryGenEmp.FieldByName('EMP_BAIRRO').AsString;
end;

procedure TfrmQckRcxReciboCob.rllCepBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cep: ' + qryGenEmp.FieldByName('EMP_C_E_P_').AsString;
end;

procedure TfrmQckRcxReciboCob.rlbHeader2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;

//    intContador: integer;
//    rllLabel   : TRLLabel;
begin
  qryGenCli := fCriaQuery(Self);

  {****************************}
  {* CARREGA DADOS DO CLIENTE *}
  {*************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

  qryGenCli.Close;
  qryGenCli.SQL.Clear;
  qryGenCli.SQL.Add(strSQL);
  qryGenCli.ParamByName('CODCLI').AsString := dtsRelat.DataSet.FieldByName('CODCLI').AsString;
  qryGenCli.Open;

  rllNomCliDup.Caption := qryGenCli.FieldByName('CLI_NOMCLI').AsString;
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
  Begin
    rllEndDup.Caption    := 'Dirección: '   + qryGenCli.FieldByName('CLI_ENDERE').AsString + IIF(Not fEmptyStr(qryGenCli.FieldByName('CLI_ENDNUM').AsString), ', ' +
                                              qryGenCli.FieldByName('CLI_ENDNUM').AsString, '');
    rllMunicDup.Caption  := 'Ciudad: '  + fRetNomCidade(qryGenCli.FieldByName('CLI_CODCID').AsString);
    rllCgcCpfDup.Caption := 'RUC: ' + FormatMaskText(IIF(qryGenCli.FieldByName('CLI_CGCCPF').AsString = '1', fRetMascaraC_G_C_(FPais, C_G_C_), fRetMascaraC_G_C_(FPais, C_P_F_)),
                                                            qryGenCli.FieldByName('CLI_C_G_C_').AsString);
  End
  Else
  Begin
    rllEndDup.Caption    := 'Endereço: '   + qryGenCli.FieldByName('CLI_ENDERE').AsString + IIF(Not fEmptyStr(qryGenCli.FieldByName('CLI_ENDNUM').AsString), ', ' +
                                             qryGenCli.FieldByName('CLI_ENDNUM').AsString, '');
    rllMunicDup.Caption  := 'Municipio: '  + fRetNomCidade(qryGenCli.FieldByName('CLI_CODCID').AsString);
    rllCgcCpfDup.Caption := 'CNPJ / CPF: ' + FormatMaskText(IIF(qryGenCli.FieldByName('CLI_CGCCPF').AsString = '1', fRetMascaraC_G_C_(FPais, C_G_C_), fRetMascaraC_G_C_(FPais, C_P_F_)),
                                                            qryGenCli.FieldByName('CLI_C_G_C_').AsString);
  End;

  rllCodCliDup.Caption := 'Codigo: '     + qryGenCli.FieldByName('CLI_CODCLI').AsString;
  rllBairroDup.Caption := 'Bairro: '     + qryGenCli.FieldByName('CLI_BAIRRO').AsString;
  rllCepDup.Caption    := 'Cep: '        + FormatMaskText('99999-999;0;_', qryGenCli.FieldByName('CLI_C_E_P_').AsString);
  rllRgDup.Caption     := 'IE / RG: '    + qryGenCli.FieldByName('CLI_I_E_S_').AsString;
  rllFone01.Caption    := 'Fone 1: '     + fFormataFone(qryGenCli.FieldByName('CLI_FONE01').AsString);
  rllFone02.Caption    := 'Fone 2: '     + fFormataFone(qryGenCli.FieldByName('CLI_FONE02').AsString);

  qryGenCli.Close;

  strCodCli := dtsRelat.DataSet.FieldByName('CODCLI').AsString;

  FreeAndNil(qryGenCli);

end;

procedure TfrmQckRcxReciboCob.RLDBText7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  fltTotGer := fltTotGer + dtsRelat.DataSet.FieldByName('VALTOT').AsFloat;
end;

procedure TfrmQckRcxReciboCob.rllOperadorBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetNomeOperador(strCodOpe);
end;

procedure TfrmQckRcxReciboCob.rllRecebiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'Recebidos de:'
  Else
    Text := 'Recebi de:';
end;

procedure TfrmQckRcxReciboCob.rllRgDupBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Visible := False
  Else
    Visible := True;
end;

procedure TfrmQckRcxReciboCob.rllSegDuplicBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'El seguiente Duplicados'
  Else
    Text := 'As seguinte Duplicatas';
end;

procedure TfrmQckRcxReciboCob.rllDataBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := AnsiUpperCase(fRetDataExtEsp(VS_Date,True))
  Else
    Text := AnsiUpperCase(fRetDataExtenso(VS_Date,True));
end;

procedure TfrmQckRcxReciboCob.rllDataImpressaoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := 'Data da Impressão: '+DateToStr(VS_Date) + ' - ' + TimeToStr(Time);
end;

procedure TfrmQckRcxReciboCob.rlbDetailBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  If strCodCli <> dtsRelat.DataSet.FieldByName('CODCLI').AsString Then
  Begin
    intContador := 0;
    fAtuCfgSis( 'CONREC', IIF( fCfgSisL('CONREC') = '', fStrZero( '1', 6), fStrZero( IntToStr( fCfgSisL('CONREC', varInteger) + 1 ), 6) ) );

    qckPagina.NewPage;
    Exit;
  End;

end;

procedure TfrmQckRcxReciboCob.rllValExtensoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
  Begin
    If Not fEmptyStr(Trim(rdbValTot.Caption)) Then
      Text := '(' + AnsiUpperCase(FGet_Extens(AnsiReplaceStr(rdbValTot.Caption,'-',''), 'E')) + ')';
  End
  Else
  Begin
    If Not fEmptyStr(Trim(rdbValTot.Caption)) Then
      Text := '(' + AnsiUpperCase(fRetExtensoNumero(AnsiReplaceStr(rdbValTot.Caption,'-',''))) + ')';
  End;
end;

procedure TfrmQckRcxReciboCob.rllVencimentoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'MADUREZ'
  Else
    Text := 'VENCIMENTO';
end;

procedure TfrmQckRcxReciboCob.rllNumDocBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  intContador := 0;

//  If (strTipImp = 'M') Then
//    Text := #27 + 'P' + #18 + #27 + 'W' + #1
//  Else
    Text := '';
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := Text + 'RECIBO DE COLECCION No - ' + fCfgSisL('CONREC') + ' - ' + VS_strCodEmp
  Else
    Text := Text + 'RECIBO DE COBRANCA No - ' + fCfgSisL('CONREC') + ' - ' + VS_strCodEmp;

//  If (strTipImp = 'M') Then
//    Text := Text + #27 + 'M' + #15 + #27 + 'W' + #0;

end;

procedure TfrmQckRcxReciboCob.FormCreate(Sender: TObject);
begin
  qryGenEmp := fCriaQuery(Self);

  intContador := 0;

  FPais := fSetaPais;
end;

procedure TfrmQckRcxReciboCob.rlbEspacoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  {*************************************}
  {* QUANDO CHEGA NESTE PONTO O REPORT *}
  {* JA DEU NEXT NA TABELA             *}
  {**********************************AF*}
  If strCodCli <> dtsRelat.DataSet.FieldByName('CODCLI').AsString Then
  Begin

    rlbSumario1.Visible := True;
    rlbSumario2.Visible := True;
    rlbFooter1.Visible  := False;

  End
  Else
  Begin

    If (intContador = 11) And (Not dtsRelat.DataSet.Eof) Then
    Begin

      rlbSumario1.Visible := False;
      rlbSumario2.Visible := False;
      rlbFooter1.Visible  := True;

    End
    Else
    Begin

      rlbSumario1.Visible := True;
      rlbSumario2.Visible := True;
      rlbFooter1.Visible  := False;

    End;

  End;

  If dtsRelat.DataSet.Eof Then
  Begin
    dtsRelat.DataSet.Last;
    rllTotGeral.visible := True;
    rllTotGer.Visible := True;
    rllTotGer.Caption := FormatFloat('#,##0.00', fltTotGer);
  End;
end;

function TfrmQckRcxReciboCob.fImprimirReciboCobranca(cdsRelCtr: TUniClientDataSet; strCodCli : String) : Boolean;
  Var
    editorFast: TFastPrintFileEditor;
    reciboCtrCob : TRelQckRcxReciboCob;
    blnEmpty : Boolean;
    Index: TIndexDef; //MF: 290025 - 16/06/23
begin
  Result := False;
  editorFast := TFastPrintFileEditor.Create(Self);
  reciboCtrCob  := TRelQckRcxReciboCob.CreateInstance(cdsRelCtr,strCodCli);
  reciboCtrCob.ModoProducao := True;
  editorFast.pSetFastPrintFile(reciboCtrCob);
  blnEmpty := reciboCtrCob.IsEmpty;

  If Not blnEmpty Then
  Begin
    If editorFast.fLoadReport Then
    Begin
      If (editorFast.FrxReport.FindObject('memOrdem') <> nil) Then //MF: 290025 - 16/06/23
      Begin
        cdsRelCtr.IndexDefs.Clear;
        Index := cdsRelCtr.IndexDefs.AddIndexDef;
        Index.Name   := 'IDXREP';
        Index.Fields := TfrxMemoView(editorFast.FrxReport.FindObject('memOrdem')).Text;

        cdsRelCtr.IndexName := 'IDXREP';
      End;

      editorFast.pConfigPrinter;
      editorFast.pPrint;
      Result := True;
    End;
  End;

  FreeAndNil(editorFast);
end;

procedure TfrmQckRcxReciboCob.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  fltTotGer := 0;
end;

procedure TfrmQckRcxReciboCob.rlbDetailAfterPrint(Sender: TObject);
begin
  If Not fEmptyStr(rdbCodIte.Caption) Then
    Inc(intContador);
end;

end.

