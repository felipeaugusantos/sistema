unit untImportCadFreteTranspCidadeFaixaConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ComCtrls, untZClient, cxProgressBar,
  untFuncoesSimples, untGravando, UniClientDataSet, Vcl.Grids, Vcl.DBGrids, Uni,
  frxDBSet, Datasnap.DBClient;

type
  TfrmImportCadFreteTranspCidadeFaixaConfirma = class(TfrmPaiConfirma)
    pgcContainer: TPageControl;
    tbsAltera: TTabSheet;
    cxgTransportadora: TcxGrid;
    cxgTransportadoraView: TcxGridDBTableView;
    cxgTransportadoraViewUpdMARCADO: TcxGridDBColumn;
    cxgTransportadoraLevel1: TcxGridLevel;
    Panel1: TPanel;
    btnDesmUpdAll: TBitBtnLocked;
    btnMarcUpdAll: TBitBtnLocked;
    btnMarcarUpd: TBitBtnLocked;
    tbsInclui: TTabSheet;
    cxgTransportadoraInsert: TcxGrid;
    cxgTransportadoraIns: TcxGridDBTableView;
    cxgTransportadoraLlv: TcxGridLevel;
    dtsDadosUpd: TDataSource;
    dtsDadosIns: TDataSource;
    cxgTransportadoraViewUpdCODTRA: TcxGridDBColumn;
    cxgTransportadoraViewUpdNOMTRA: TcxGridDBColumn;
    cxgTransportadoraViewUpdCODCID: TcxGridDBColumn;
    cxgTransportadoraViewUpdNOMCID: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFTI: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFTF: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALDTF: TcxGridDBColumn;
    cxgTransportadoraInsMARCADO: TcxGridDBColumn;
    cxgTransportadoraInsCODTRA: TcxGridDBColumn;
    cxgTransportadoraInsNOMTRA: TcxGridDBColumn;
    cxgTransportadoraInsCODCID: TcxGridDBColumn;
    cxgTransportadoraInsNOMCID: TcxGridDBColumn;
    cxgTransportadoraInsVALFTI: TcxGridDBColumn;
    cxgTransportadoraInsVALFTF: TcxGridDBColumn;
    cxgTransportadoraInsVALDTF: TcxGridDBColumn;
    Panel2: TPanel;
    btnDesmarcarIncAll: TBitBtnLocked;
    btnMarcarIncAll: TBitBtnLocked;
    btnMarcarInc: TBitBtnLocked;
    cxgTransportadoraViewUpdVALFTI_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFTF_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALDTF_NOVO: TcxGridDBColumn;
    btnVisProdNaoImp: TBitBtnLocked;
    frxRepNaoImp: TfrxReport;
    frxRelatorio_Transportadora: TfrxDBDataset;
    cdsTranspNaoImportadaRelatorio: TUniClientDataSet;
    dtsTranspNaoImportadaRelatorio: TDataSource;
    cdsTranspNaoImportadaRelatorioCODTRA: TStringField;
    cdsCidadeNaoImportadaRelatorio: TUniClientDataSet;
    cdsCidadeNaoImportadaRelatorioCODCID: TStringField;
    dtsCidadeNaoImportadaRelatorio: TDataSource;
    frxRelatorio_Cidade: TfrxDBDataset;
    cdsDadosIns: TUniClientDataSet;
    cdsDadosUpd: TUniClientDataSet;
    cdsDadosInsMARCADO: TIntegerField;
    cdsDadosInsCODTRA: TStringField;
    cdsDadosInsNOMTRA: TStringField;
    cdsDadosInsCODCID: TStringField;
    cdsDadosInsNOMCID: TStringField;
    cdsDadosUpdMARCADO: TIntegerField;
    cdsDadosUpdCODTRA: TStringField;
    cdsDadosUpdNOMTRA: TStringField;
    cdsDadosUpdCODCID: TStringField;
    cdsDadosUpdNOMCID: TStringField;
    cdsDadosInsVALFTI: TFloatField;
    cdsDadosInsVALFTF: TFloatField;
    cdsDadosInsVALDTF: TFloatField;
    cdsDadosUpdVALFTI: TFloatField;
    cdsDadosUpdVALFTF: TFloatField;
    cdsDadosUpdVALDTF: TFloatField;
    cdsDadosUpdVALFTI_NOVO: TFloatField;
    cdsDadosUpdVALFTF_NOVO: TFloatField;
    cdsDadosUpdVALDTF_NOVO: TFloatField;
    cdsDadosInsSEQFRE: TStringField;
    cdsDadosUpdSEQFRE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnMarcarUpdClick(Sender: TObject);
    procedure btnMarcUpdAllClick(Sender: TObject);
    procedure btnDesmUpdAllClick(Sender: TObject);
    procedure btnMarcarIncClick(Sender: TObject);
    procedure btnMarcarIncAllClick(Sender: TObject);
    procedure btnDesmarcarIncAllClick(Sender: TObject);


    procedure pMarcar(cdsDados: TUniClientDataSet);
    procedure pMarcaDesmarcaTodos(blnMarca: boolean);

    function  fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
    procedure tbsAlteraShow(Sender: TObject);
    procedure tbsIncluiShow(Sender: TObject);
    procedure cxgTransportadoraViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgTransportadoraInsCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgTransportadoraViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgTransportadoraInsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnVisProdNaoImpClick(Sender: TObject);


  private

    cdsDados: TUniClientDataSet;

    blnMarcar: Boolean;

    procedure pVerificaSeRegistroEstaMarcado(intMarcado: Integer);

    function fValidaRetornaInfo(strInfoOld, strInfoNovo: String): Variant;
    function fIncluirRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
    function fAlterarRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;

  public
    procedure pIncluiTransportadoraNaoImportada(strCodigo: String);
    procedure pIncluiCidadeNaoImportada(strCodigo: String);

  end;

implementation

{$R *.dfm}

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnConfirmaClick(
  Sender: TObject);
Var
  frmIns: TfrmGravando;
  frmAlt: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmIns);
  Try
    frmIns.fExecutarAcao := fIncluirRegistroNoBanco;
    frmIns.lblGravando.Caption := 'Aguarde... Importando o Cadastro de Frete ';
    frmIns.Showmodal
  Finally
    pFreeAndNil(frmIns);
  End;

  pCriarFormularios(TfrmGravando, frmAlt);
  Try
    frmAlt.fExecutarAcao := fAlterarRegistroNoBanco;
    frmAlt.lblGravando.Caption := 'Aguarde... Atualizando o Cadastro de Frete';
    frmAlt.Showmodal
  Finally
    pFreeAndNil(frmAlt);
  End;

end;

function TfrmImportCadFreteTranspCidadeFaixaConfirma.fIncluirRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  inherited;
  Result:= True;
  ModalResult := mrOK;
  cdsDadosIns.First;

  If (Not(cdsDadosIns.Locate('MARCADO', '1', []))) Then
  Begin
    Exit;
  End;

  cdsDadosIns.First;

  pgbProgresso.Properties.Max := cdsDadosIns.RecordCount -1;

  qryGravar:= fCriaQuery();
  Try
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('INSERT INTO FREFAI( ');
    qryGravar.SQL.Add('       FAI_SEQFRE ');
    qryGravar.SQL.Add('     , FAI_FATINI ');
    qryGravar.SQL.Add('     , FAI_FATFIN ');
    qryGravar.SQL.Add('     , FAI_PERDES ');
    qryGravar.SQL.Add('     , AUTOINCREM ');
    qryGravar.SQL.Add(') VALUES ( ');
    qryGravar.SQL.Add('       :FAI_SEQFRE ');
    qryGravar.SQL.Add('     , :FAI_FATINI ');
    qryGravar.SQL.Add('     , :FAI_FATFIN ');
    qryGravar.SQL.Add('     , :FAI_PERDES ');
    qryGravar.SQL.Add('     , :AUTOINCREM ');
    qryGravar.SQL.Add(') ');

    While Not(cdsDadosIns.Eof) do
    Begin
      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosIns.FieldByName('MARCADO').AsInteger);

        qryGravar.Close;
        qryGravar.ParamByName('FAI_SEQFRE').AsString := cdsDadosIns.FieldByName('SEQFRE').AsString;
        qryGravar.ParamByName('FAI_FATINI').AsString := cdsDadosIns.FieldByName('VALFTI').AsString;
        qryGravar.ParamByName('FAI_FATFIN').AsFloat  := cdsDadosIns.FieldByName('VALFTF').AsFloat;
        qryGravar.ParamByName('FAI_PERDES').AsFloat  := cdsDadosIns.FieldByName('VALDTF').AsFloat;
        qryGravar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FREFAI', VS_strCodEmp);
        qryGravar.ExecSQL;
      Except
        On E: Exception Do
        Begin

        End;
      End;
      cdsDadosIns.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

function TfrmImportCadFreteTranspCidadeFaixaConfirma.fAlterarRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  inherited;
  Result:= True;
  ModalResult := mrOk;
  cdsDadosUpd.First;

  If (Not(cdsDadosUpd.Locate('MARCADO', '1', []))) Then
  Begin
    Exit;
  End;

  cdsDadosUpd.First;

  pgbProgresso.Properties.Max := cdsDadosUpd.RecordCount -1;

  qryGravar:= fCriaQuery();
  Try
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('UPDATE FREFAI ');
    qryGravar.SQL.Add('   SET FAI_FATINI = :FAI_FATINI ');
    qryGravar.SQL.Add('     , FAI_FATFIN = :FAI_FATFIN ');
    qryGravar.SQL.Add('     , FAI_PERDES = :FAI_PERDES ');
    qryGravar.SQL.Add(' WHERE FREFAI.FAI_SEQFRE in (SELECT FRETRA.AUTOINCREM FROM FRETRA ');
    qryGravar.SQL.Add('                              WHERE FRETRA.FRE_CODTRA = :FRE_CODTRA ');
    qryGravar.SQL.Add('                                AND FRETRA.FRE_CODCID = :FRE_CODCID) ');
    qryGravar.SQL.Add('   AND FREFAI.FAI_FATINI = :OLD_FATINI ');
    qryGravar.SQL.Add('   AND FREFAI.FAI_FATFIN = :OLD_FATFIN ');

    While Not(cdsDadosUpd.Eof) do
    Begin
      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosUpd.FieldByName('MARCADO').AsInteger);

        qryGravar.Close;
        qryGravar.ParamByName('FRE_CODTRA').AsString := cdsDadosUpd.FieldByName('CODTRA').AsString;
        qryGravar.ParamByName('FRE_CODCID').AsString := cdsDadosUpd.FieldByName('CODCID').AsString;
        qryGravar.ParamByName('OLD_FATINI').AsFloat  := cdsDadosUpd.FieldByName('VALFTI').AsFloat;
        qryGravar.ParamByName('OLD_FATFIN').AsFloat  := cdsDadosUpd.FieldByName('VALFTF').AsFloat;

        qryGravar.ParamByName('FAI_FATINI').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALFTI').AsString,
                                                                           cdsDadosUpd.FieldByName('VALFTI_NOVO').AsString);
        qryGravar.ParamByName('FAI_FATFIN').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALFTF').AsString,
                                                                           cdsDadosUpd.FieldByName('VALFTF_NOVO').AsString);
        qryGravar.ParamByName('FAI_PERDES').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALDTF').AsString,
                                                                           cdsDadosUpd.FieldByName('VALDTF_NOVO').AsString);
        qryGravar.ExecSQL;
      Except
      on E: Exception Do
        Begin

        End;
      End;
      cdsDadosUpd.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnDesmarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnDesmUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnMarcUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnVisProdNaoImpClick(
  Sender: TObject);
Var
  strNomEmp: String;
begin
  inherited;

  strNomEmp:= fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

  frxRepNaoImp.Script.Variables['NOMREL'] := 'RELATÓRIO DE REGISTROS NÃO IMPORTADOS';
  frxRepNaoImp.Script.Variables['NOMEMP'] := strNomEmp;
  frxRepNaoImp.DotMatrixReport            := False;
  frxRepNaoImp.PrintOptions.PrintMode     := pmScale;
  pPreviewReport(Self.Name, Self.Caption + ' (Registros não importados)', frxRepNaoImp);

end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.cxgTransportadoraInsCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsDadosIns.RecordCount = 0 Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgTransportadoraInsMARCADO.Index]) = '1' Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.cxgTransportadoraInsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarIncClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.cxgTransportadoraViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsDadosUpd.RecordCount = 0 Then
    Exit;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgTransportadoraViewUpdMARCADO.Index] = '1') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
  If Pos('Novo', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clMoneyGreen
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.cxgTransportadoraViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarUpdClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.pMarcar(cdsDados: TUniClientDataSet);
Begin
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsInteger  := IIf(cdsDados.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDados.Post;
End;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.pVerificaSeRegistroEstaMarcado(
  intMarcado: Integer);
begin
  If intMarcado < 1 Then
    raise Exception.Create('O Registro não está marcado!');
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.tbsAlteraShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosUpd;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.tbsIncluiShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosIns;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnMarcarUpdClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosUpd);
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnMarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.btnMarcarIncClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosIns);
end;

function TfrmImportCadFreteTranspCidadeFaixaConfirma.fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
begin
  prgProgresso.Properties.Max := cdsDados.RecordCount -1;
  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('MARCADO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsDados.Post;
      cdsDados.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsDados.EnableControls;
  End;

end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  dtsDadosIns.DataSet:= cdsDadosIns;
  dtsDadosUpd.DataSet:= cdsDadosUpd
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If pgcContainer.ActivePage = tbsInclui Then
  Begin
    Case Key Of
      VK_F2   : btnMarcarIncAllClick(Sender);
      VK_F3   : btnDesmarcarIncAllClick(Sender);
    End;
  End;

  If pgcContainer.ActivePage = tbsAltera Then
  Begin
    Case Key Of
      VK_F2   : btnMarcUpdAllClick(Sender);
      VK_F3   : btnDesmUpdAllClick(Sender);
    End;
  End;


end;

function TfrmImportCadFreteTranspCidadeFaixaConfirma.fValidaRetornaInfo(strInfoOld,
  strInfoNovo: String): Variant;
begin
  Result:= Null;
  If (Not(fEmptyStr(strInfoNovo))) Then
    Result  := strInfoNovo
  Else If Not(fEmptyStr(strInfoOld)) Then
    Result  := strInfoOld;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.pIncluiCidadeNaoImportada(
  strCodigo: String);
begin
  cdsCidadeNaoImportadaRelatorio.Insert;
  cdsCidadeNaoImportadaRelatorioCODCID.AsString := strCodigo;
  cdsCidadeNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.pIncluiTransportadoraNaoImportada(
  strCodigo: String);
begin
  cdsTranspNaoImportadaRelatorio.Insert;
  cdsTranspNaoImportadaRelatorioCODTRA.AsString := strCodigo;
  cdsTranspNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeFaixaConfirma.pMarcaDesmarcaTodos(
  blnMarca: boolean);
var frmMarca: TfrmGravando;
begin
  blnMarcar := blnMarca;
  pCriarFormularios(TfrmGravando, frmMarca);
  Try
    frmMarca.lblGravando.Caption := 'Gerando informações ...';
    frmMarca.fExecutarAcao := fMarcaDesmarcaTodosAux;
    frmMarca.Showmodal;
  Finally
    pFreeAndNil(frmMarca);
  End;

end;

end.
