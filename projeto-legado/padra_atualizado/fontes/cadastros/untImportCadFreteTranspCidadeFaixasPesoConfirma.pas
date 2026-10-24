unit untImportCadFreteTranspCidadeFaixasPesoConfirma;

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
  TfrmImportCadFreteTranspCidadeFaixasPesoConfirma = class(TfrmPaiConfirma)
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
    cxgTransportadoraViewUpdPESINI: TcxGridDBColumn;
    cxgTransportadoraViewUpdPESFIN: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFRE: TcxGridDBColumn;
    cxgTransportadoraInsMARCADO: TcxGridDBColumn;
    cxgTransportadoraInsCODTRA: TcxGridDBColumn;
    cxgTransportadoraInsNOMTRA: TcxGridDBColumn;
    cxgTransportadoraInsCODCID: TcxGridDBColumn;
    cxgTransportadoraInsNOMCID: TcxGridDBColumn;
    cxgTransportadoraInsPESINI: TcxGridDBColumn;
    cxgTransportadoraInsPESFIN: TcxGridDBColumn;
    cxgTransportadoraInsVALFRE: TcxGridDBColumn;
    Panel2: TPanel;
    btnDesmarcarIncAll: TBitBtnLocked;
    btnMarcarIncAll: TBitBtnLocked;
    btnMarcarInc: TBitBtnLocked;
    cxgTransportadoraViewUpdPESINI_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdPESFIN_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFRE_NOVO: TcxGridDBColumn;
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
    cdsDadosInsSEQFRE: TStringField;
    cdsDadosUpdSEQFRE: TStringField;
    cdsDadosInsPESINI: TFloatField;
    cdsDadosInsPESFIN: TFloatField;
    cdsDadosInsVALFRE: TFloatField;
    cdsDadosUpdPESINI: TFloatField;
    cdsDadosUpdPESFIN: TFloatField;
    cdsDadosUpdVALFRE: TFloatField;
    cdsDadosUpdPESINI_NOVO: TFloatField;
    cdsDadosUpdPESFIN_NOVO: TFloatField;
    cdsDadosUpdVALFRE_NOVO: TFloatField;
    cdsDadosInsVALPKG: TFloatField;
    cdsDadosUpdVALPKG: TFloatField;
    cdsDadosUpdVALPKG_NOVO: TFloatField;
    cxgTransportadoraInsVALPKG: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALPKG: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALPKG_NOVO: TcxGridDBColumn;
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
    procedure pGravarValorQuilo(const strSeqFre: String; fltValPkg: Double);

  public
    procedure pIncluiTransportadoraNaoImportada(strCodigo: String);
    procedure pIncluiCidadeNaoImportada(strCodigo: String);

  end;

implementation

{$R *.dfm}

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnConfirmaClick(
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

function TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.fIncluirRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  inherited;
  Result:= True;
  ModalResult := mrOK;
  cdsDadosIns.First;

  If (Not cdsDadosIns.Locate('MARCADO', '1', [])) Then
    Exit;

  cdsDadosIns.First;

  pgbProgresso.Properties.Max := cdsDadosIns.RecordCount -1;

  qryGravar:= fCriaQuery();
  Try
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('INSERT INTO FREFXP( ');
    qryGravar.SQL.Add('       FAI_SEQFRE ');
    qryGravar.SQL.Add('     , FAI_PESINI ');
    qryGravar.SQL.Add('     , FAI_PESFIN ');
    qryGravar.SQL.Add('     , FAI_VALFRE ');
    qryGravar.SQL.Add('     , AUTOINCREM ');
    qryGravar.SQL.Add(') VALUES ( ');
    qryGravar.SQL.Add('       :FAI_SEQFRE ');
    qryGravar.SQL.Add('     , :FAI_PESINI ');
    qryGravar.SQL.Add('     , :FAI_PESFIN ');
    qryGravar.SQL.Add('     , :FAI_VALFRE ');
    qryGravar.SQL.Add('     , :AUTOINCREM ');
    qryGravar.SQL.Add(') ');

    While Not(cdsDadosIns.Eof) do
    Begin
      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosIns.FieldByName('MARCADO').AsInteger);

        pGravarValorQuilo(cdsDadosIns.FieldByName('SEQFRE').AsString,
                          cdsDadosIns.FieldByName('VALPKG').AsFloat);

        qryGravar.Close;
        qryGravar.ParamByName('FAI_SEQFRE').AsString := cdsDadosIns.FieldByName('SEQFRE').AsString;
        qryGravar.ParamByName('FAI_PESINI').AsFloat  := cdsDadosIns.FieldByName('PESINI').AsFloat;
        qryGravar.ParamByName('FAI_PESFIN').AsFloat  := cdsDadosIns.FieldByName('PESFIN').AsFloat;
        qryGravar.ParamByName('FAI_VALFRE').AsFloat  := cdsDadosIns.FieldByName('VALFRE').AsFloat;
        qryGravar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FREFXP', VS_strCodEmp);
        qryGravar.ExecSQL;
      Except
      End;
      cdsDadosIns.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

function TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.fAlterarRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  inherited;
  Result:= True;
  ModalResult := mrOk;
  cdsDadosUpd.First;

  If (Not cdsDadosUpd.Locate('MARCADO', '1', [])) Then
    Exit;

  cdsDadosUpd.First;

  pgbProgresso.Properties.Max := cdsDadosUpd.RecordCount -1;

  qryGravar:= fCriaQuery();
  Try
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('UPDATE FREFXP ');
    qryGravar.SQL.Add('   SET FAI_PESINI = :FAI_PESINI ');
    qryGravar.SQL.Add('     , FAI_PESFIN = :FAI_PESFIN ');
    qryGravar.SQL.Add('     , FAI_VALFRE = :FAI_VALFRE ');
    qryGravar.SQL.Add(' WHERE FREFXP.FAI_SEQFRE in (SELECT FRETRA.AUTOINCREM FROM FRETRA ');
    qryGravar.SQL.Add('                              WHERE FRETRA.FRE_CODTRA = :FRE_CODTRA ');
    qryGravar.SQL.Add('                                AND FRETRA.FRE_CODCID = :FRE_CODCID) ');
    qryGravar.SQL.Add('   AND FREFXP.FAI_PESINI = :OLD_PESINI ');
    qryGravar.SQL.Add('   AND FREFXP.FAI_PESFIN = :OLD_PESFIN ');

    While Not(cdsDadosUpd.Eof) do
    Begin
      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosUpd.FieldByName('MARCADO').AsInteger);

        pGravarValorQuilo(cdsDadosIns.FieldByName('SEQFRE').AsString,
                          fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALPKG').AsString,
                                             cdsDadosUpd.FieldByName('VALPKG_NOVO').AsString));

        qryGravar.Close;
        qryGravar.ParamByName('FRE_CODTRA').AsString := cdsDadosUpd.FieldByName('CODTRA').AsString;
        qryGravar.ParamByName('FRE_CODCID').AsString := cdsDadosUpd.FieldByName('CODCID').AsString;
        qryGravar.ParamByName('OLD_PESINI').AsFloat  := cdsDadosUpd.FieldByName('PESINI').AsFloat;
        qryGravar.ParamByName('OLD_PESFIN').AsFloat  := cdsDadosUpd.FieldByName('PESFIN').AsFloat;

        qryGravar.ParamByName('FAI_PESINI').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('PESINI').AsString,
                                                                           cdsDadosUpd.FieldByName('PESINI_NOVO').AsString);
        qryGravar.ParamByName('FAI_PESFIN').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('PESFIN').AsString,
                                                                           cdsDadosUpd.FieldByName('PESFIN_NOVO').AsString);
        qryGravar.ParamByName('FAI_VALFRE').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALFRE').AsString,
                                                                           cdsDadosUpd.FieldByName('VALFRE_NOVO').AsString);
        qryGravar.ExecSQL;
      Except
      End;
      cdsDadosUpd.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnDesmarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnDesmUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnMarcUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnVisProdNaoImpClick(
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

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.cxgTransportadoraInsCustomDrawCell(
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

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.cxgTransportadoraInsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarIncClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.cxgTransportadoraViewCustomDrawCell(
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

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.cxgTransportadoraViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarUpdClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pMarcar(cdsDados: TUniClientDataSet);
Begin
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsInteger  := IIf(cdsDados.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDados.Post;
End;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pVerificaSeRegistroEstaMarcado(
  intMarcado: Integer);
begin
  If intMarcado < 1 Then
    raise Exception.Create('O Registro não está marcado!');
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.tbsAlteraShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosUpd;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.tbsIncluiShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosIns;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnMarcarUpdClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosUpd);
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnMarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.btnMarcarIncClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosIns);
end;

function TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
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

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  dtsDadosIns.DataSet:= cdsDadosIns;
  dtsDadosUpd.DataSet:= cdsDadosUpd
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.FormKeyDown(Sender: TObject;
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

function TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.fValidaRetornaInfo(strInfoOld,
  strInfoNovo: String): Variant;
begin
  Result:= Null;
  If (Not(fEmptyStr(strInfoNovo))) Then
    Result  := strInfoNovo
  Else If Not(fEmptyStr(strInfoOld)) Then
    Result  := strInfoOld;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pGravarValorQuilo(
  const strSeqFre: String; fltValPkg: Double);
var
  qryFretra: TUniQuery;
begin
  qryFretra := fCriaQuery();
  Try
    qryFretra.SQL.Text := 'UPDATE FRETRA '
                        + '   SET FRE_VALKIL = :VALKIL '
                        + ' WHERE AUTOINCREM = :AUTINC ';

    qryFretra.ParamByName('AUTINC').AsString := strSeqFre;
    qryFretra.ParamByName('VALKIL').AsFloat  := fltValPkg;
    qryFretra.ExecSQL;
  Finally
    FreeAndNil(qryFretra);
  End;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pIncluiCidadeNaoImportada(
  strCodigo: String);
begin
  cdsCidadeNaoImportadaRelatorio.Insert;
  cdsCidadeNaoImportadaRelatorioCODCID.AsString := strCodigo;
  cdsCidadeNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pIncluiTransportadoraNaoImportada(
  strCodigo: String);
begin
  cdsTranspNaoImportadaRelatorio.Insert;
  cdsTranspNaoImportadaRelatorioCODTRA.AsString := strCodigo;
  cdsTranspNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeFaixasPesoConfirma.pMarcaDesmarcaTodos(
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
