unit untFatConfeEntDocNaoEntregues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Uni, UniClientDataSet;

type
  TfrmFatConfeEntDocNaoEntregues = class(TfrmPai)
    btnConfVolumes: TBitBtnLocked;
    btnDevProdutos: TBitBtnLocked;
    dbgDocs: TcxGrid;
    dbgDocsDBView: TcxGridDBTableView;
    dbgDocsDTAROM: TcxGridDBColumn;
    dbgDocsNUMROM: TcxGridDBColumn;
    dbgDocsDTADOC: TcxGridDBColumn;
    dbgDocsNOMCLI: TcxGridDBColumn;
    dbgDocsQTDVOL: TcxGridDBColumn;
    dbgDocslevel: TcxGridLevel;
    dbgDocsNUMDOC: TcxGridDBColumn;
    dtsDocs: TDataSource;
    dbgDocsESPDOC: TcxGridDBColumn;
    dbgDocsEMPDOC: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfVolumesClick(Sender: TObject);
    procedure btnDevProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDocs: TUniClientDataSet;

    procedure pCriaDataSet;
    procedure pCarregaDocumentos;
    procedure pAtualizaConferente(ABaiDev: Boolean = False);
    procedure pValidaDocumentoDevolvido;
    procedure pAfterScroll(ADataSet: TDataSet);

    function fCarregaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untFatRomConferenciaVolumes, untFatVendas;

{$R *.dfm}

procedure TfrmFatConfeEntDocNaoEntregues.btnConfVolumesClick(Sender: TObject);
var
  LConferenciaVolumes: TfrmFatRomConferenciaVolumes;
begin
  inherited;

  if (not btnConfVolumes.Enabled) then
    Exit;

  pCriarFormularios(TfrmFatRomConferenciaVolumes, LConferenciaVolumes);

  try
    LConferenciaVolumes.blnConfDocsRomNaoEntregues := True;
    LConferenciaVolumes.intQtdVolumes := fFloatToInt(FDocs.FieldByName('QTDVOL').AsFloat);
    LConferenciaVolumes.strNumDoc := FDocs.FieldByName('NUMDOC').AsString;
    LConferenciaVolumes.strEspDoc := FDocs.FieldByName('ESPDOC').AsString;
    LConferenciaVolumes.strCodEmp := FDocs.FieldByName('EMPDOC').AsString;

    if (LConferenciaVolumes.ShowModal = mrOk) then
    begin
      pAtualizaConferente;
      pCarregaDocumentos;
      pMensagemOk('Conferência realizada!');
    end;
  finally
    pFreeAndNil(LConferenciaVolumes);
  end;
end;

procedure TfrmFatConfeEntDocNaoEntregues.btnDevProdutosClick(Sender: TObject);
begin
  inherited;

  if (not btnDevProdutos.Enabled) then
    Exit;

  if (not fPergunta('Realizar devolução do documento agora?')) then
    Exit;

  pCriarFormularios(TfrmFatVendas, frmFatVendas);

  try
    frmFatVendas.blnDevDocNaoEntregueRom := True;
    frmFatVendas.strOpcDoc          := 'DV';
    frmFatVendas.strTitulo          := ' > Principal > Faturamento > Emissão de Faturamento > Devolução';
    frmFatVendas.strCodCliDef       := Copy(FDocs.FieldByName('NOMCLI').AsString, 1, 8);
    frmFatVendas.edtCodCli.Text     := Copy(FDocs.FieldByName('NOMCLI').AsString, 1, 8);
    frmFatVendas.strNumDocDev       := FDocs.FieldByName('NUMDOC').AsString;
    frmFatVendas.strEspDocDev       := FDocs.FieldByName('ESPDOC').AsString;
    frmFatVendas.strCodEmpDev       := FDocs.FieldByName('EMPDOC').AsString;
    frmFatVendas.blnFecharForm      := True;
    frmFatVendas.blnApenasPrazo     := False;
    frmFatVendas.blnApenasVista     := False;
    frmFatVendas.blnDevBaiEntFut    := False;
    frmFatVendas.blnSatComplementar := False;
    frmFatVendas.blnNFCeComplementar:= False;
    frmFatVendas.blnConEqu          := False;

    frmFatVendas.ShowModal;
  finally
    pFreeAndNil(frmFatVendas);
  end;

  pValidaDocumentoDevolvido;
end;

function TfrmFatConfeEntDocNaoEntregues.fCarregaDocumentos(pgbProgresso: TcxProgressBar): Boolean;
var
  LQry: TUniQuery;
begin
  Result := True;

  LQry := fCriaQuery;
  FDocs.EmptyDataSet;

  try
    LQry.SQL.Add('SELECT R.AUTOINCREM AUTINC, RCF_NUMROM NUMROM, RCF_EMPROM EMPROM, RCF_DTAROM DTAROM, ');
    LQry.SQL.Add('  RCF_NUMDOC NUMDOC, RCF_ESPDOC ESPDOC, RCF_EMPDOC EMPDOC, RCF_DTADOC DTADOC, ');
    LQry.SQL.Add('  CONCAT(RCF_CODCLI, "-", CLI_NOMCLI) NOMCLI, RCF_QTDVOL QTDVOL ');
    LQry.SQL.Add('FROM ROMCNF R ');
    LQry.SQL.Add('INNER JOIN CADCLI ON RCF_CODCLI = CLI_CODCLI ');
    LQry.SQL.Add('WHERE RCF_DTACNF IS NULL ');
    LQry.SQL.Add('  AND RCF_EMPROM = :CODEMP ');
    LQry.SQL.Add('ORDER BY RCF_NUMROM, RCF_NUMDOC, RCF_ESPDOC, RCF_EMPDOC ');
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    btnConfVolumes.Enabled := (not LQry.IsEmpty);
    btnDevProdutos.Enabled := btnConfVolumes.Enabled;

    if LQry.IsEmpty then
      Exit(False);

    while not LQry.Eof do
    begin
      pCopiaRegistroDataSet(LQry, FDocs);
      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatConfeEntDocNaoEntregues.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
  pCarregaDocumentos;
end;

procedure TfrmFatConfeEntDocNaoEntregues.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDocs);
end;

procedure TfrmFatConfeEntDocNaoEntregues.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2: btnConfVolumes.Click;
    VK_F3: btnDevProdutos.Click;
  end;
end;

procedure TfrmFatConfeEntDocNaoEntregues.pAfterScroll(ADataSet: TDataSet);
begin
  btnDevProdutos.Visible := (Copy(FDocs.FieldByName('NUMDOC').AsString, 14, 2) <> 'PD');
end;

procedure TfrmFatConfeEntDocNaoEntregues.pAtualizaConferente(ABaiDev: Boolean = False);
var
  LUpd: TUniQuery;
begin
  LUpd := fCriaQuery;

  try
    LUpd.SQL.Add('UPDATE ROMCNF ');
    LUpd.SQL.Add('SET RCF_OPECNF = :OPECNF, ');
    LUpd.SQL.Add('    RCF_DTACNF = :DTACNF, ');
    LUpd.SQL.Add('    RCF_HORCNF = :HORCNF,  ');
    LUpd.SQL.Add('    RCF_BAIDEV = :BAIDEV  ');
    LUpd.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    LUpd.ParamByName('AUTINC').AsString   := FDocs.FieldByName('AUTINC').AsString;
    LUpd.ParamByName('OPECNF').AsString   := strLoginUsuarioLogado;
    LUpd.ParamByName('DTACNF').AsDateTime := VS_Date;
    LUpd.ParamByName('HORCNF').AsDateTime := fTime();
    LUpd.ParamByName('BAIDEV').AsString   := IIF(ABaiDev, 'S', 'N');
    LUpd.ExecSQL;
  finally
    FreeAndNil(LUpd);
  end;
end;

procedure TfrmFatConfeEntDocNaoEntregues.pCarregaDocumentos;
begin
  fChamaTelaGravando(fCarregaDocumentos, 'Carregando documentos...');
end;

procedure TfrmFatConfeEntDocNaoEntregues.pCriaDataSet;
begin
  FDocs := TUniClientDataSet.Create(Self);
  FDocs.FieldDefs.Add('AUTINC', ftString, 20);
  FDocs.FieldDefs.Add('NUMROM', ftString,  6);
  FDocs.FieldDefs.Add('EMPROM', ftString,  3);
  FDocs.FieldDefs.Add('DTAROM', ftString, 16);
  FDocs.FieldDefs.Add('NUMDOC', ftString, 12);
  FDocs.FieldDefs.Add('ESPDOC', ftString,  2);
  FDocs.FieldDefs.Add('EMPDOC', ftString,  3);
  FDocs.FieldDefs.Add('DTADOC', ftString, 16);
  FDocs.FieldDefs.Add('NOMCLI', ftString, 70);
  FDocs.FieldDefs.Add('QTDVOL', ftFloat);
  FDocs.CreateDataSet;

  (FDocs.FieldByName('QTDVOL') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FDocs.FieldByName('QTDVOL') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  dtsDocs.DataSet := FDocs;
  FDocs.AfterScroll := pAfterScroll;
end;

procedure TfrmFatConfeEntDocNaoEntregues.pValidaDocumentoDevolvido;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT COUNT(1) QTDDEV ');
    LQry.SQL.Add('FROM MOVDET D ');
    LQry.SQL.Add('INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_INCDEV     ');
    LQry.SQL.Add('INNER JOIN MOVDET DEV ON T.DET_SEQGER = DEV.AUTOINCREM ');
    LQry.SQL.Add('WHERE D.DET_NUMDOC = :NUMDOC ');
    LQry.SQL.Add('  AND D.DET_ESPDOC = :ESPDOC ');
    LQry.SQL.Add('  AND D.DET_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND DEV.DET_DTAENT = CURRENT_DATE ');
    LQry.ParamByName('NUMDOC').AsString := FDocs.FieldByName('NUMDOC').AsString;
    LQry.ParamByName('ESPDOC').AsString := FDocs.FieldByName('ESPDOC').AsString;
    LQry.ParamByName('CODEMP').AsString := FDocs.FieldByName('EMPDOC').AsString;
    LQry.Open;

    if (LQry.FieldByName('QTDDEV').AsInteger = 0) then
      Exit;

    pAtualizaConferente(True);
    pCarregaDocumentos;
  finally
    FreeAndNil(LQry);
  end;
end;

end.
