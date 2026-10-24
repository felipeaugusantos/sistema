unit untImportCadFreteTranspCidadeConfirma;

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
  TfrmImportCadFreteTranspCidadeConfirma = class(TfrmPaiConfirma)
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
    cxgTransportadoraViewUpdVALISE: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFTE: TcxGridDBColumn;
    cxgTransportadoraViewUpdPERVNF: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALKLG: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALPED: TcxGridDBColumn;
    cxgTransportadoraViewUpdPERGRI: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALGRI: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALTAS: TcxGridDBColumn;
    cxgTransportadoraInsMARCADO: TcxGridDBColumn;
    cxgTransportadoraInsCODTRA: TcxGridDBColumn;
    cxgTransportadoraInsNOMTRA: TcxGridDBColumn;
    cxgTransportadoraInsCODCID: TcxGridDBColumn;
    cxgTransportadoraInsNOMCID: TcxGridDBColumn;
    cxgTransportadoraInsVALISE: TcxGridDBColumn;
    cxgTransportadoraInsVALFTE: TcxGridDBColumn;
    cxgTransportadoraInsPERVNF: TcxGridDBColumn;
    cxgTransportadoraInsVALKLG: TcxGridDBColumn;
    cxgTransportadoraInsVALPED: TcxGridDBColumn;
    cxgTransportadoraInsPERGRI: TcxGridDBColumn;
    cxgTransportadoraInsVALGRI: TcxGridDBColumn;
    cxgTransportadoraInsVALTAS: TcxGridDBColumn;
    Panel2: TPanel;
    btnDesmarcarIncAll: TBitBtnLocked;
    btnMarcarIncAll: TBitBtnLocked;
    btnMarcarInc: TBitBtnLocked;
    cxgTransportadoraViewUpdVALISE_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALFTE_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdPERVNF_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALKLG_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALPED_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdPERGRI_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALGRI_NOVO: TcxGridDBColumn;
    cxgTransportadoraViewUpdVALTAS_NOVO: TcxGridDBColumn;
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
    cdsDadosInsVALISE: TFloatField;
    cdsDadosInsVALFTE: TFloatField;
    cdsDadosInsPERVNF: TFloatField;
    cdsDadosInsVALKLG: TFloatField;
    cdsDadosInsVALPED: TFloatField;
    cdsDadosInsPERGRI: TFloatField;
    cdsDadosInsVALGRI: TFloatField;
    cdsDadosInsVALTAS: TFloatField;
    cdsDadosUpdMARCADO: TIntegerField;
    cdsDadosUpdCODTRA: TStringField;
    cdsDadosUpdNOMTRA: TStringField;
    cdsDadosUpdCODCID: TStringField;
    cdsDadosUpdNOMCID: TStringField;
    cdsDadosUpdVALISE: TFloatField;
    cdsDadosUpdVALFTE: TFloatField;
    cdsDadosUpdPERVNF: TFloatField;
    cdsDadosUpdVALKLG: TFloatField;
    cdsDadosUpdVALPED: TFloatField;
    cdsDadosUpdPERGRI: TFloatField;
    cdsDadosUpdVALGRI: TFloatField;
    cdsDadosUpdVALTAS: TFloatField;
    cdsDadosUpdVALISE_NOVO: TFloatField;
    cdsDadosUpdVALFTE_NOVO: TFloatField;
    cdsDadosUpdPERVNF_NOVO: TFloatField;
    cdsDadosUpdVALKLG_NOVO: TFloatField;
    cdsDadosUpdVALPED_NOVO: TFloatField;
    cdsDadosUpdPERGRI_NOVO: TFloatField;
    cdsDadosUpdVALGRI_NOVO: TFloatField;
    cdsDadosUpdVALTAS_NOVO: TFloatField;
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

var
  frmImportCadFreteTranspCidadeConfirma: TfrmImportCadFreteTranspCidadeConfirma;

implementation

{$R *.dfm}

procedure TfrmImportCadFreteTranspCidadeConfirma.btnConfirmaClick(
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

function TfrmImportCadFreteTranspCidadeConfirma.fIncluirRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
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
    While Not(cdsDadosIns.Eof) do
    Begin
      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosIns.FieldByName('MARCADO').AsInteger);
        Begin
          qryGravar.Close;
          qryGravar.SQL.Clear;
          qryGravar.SQL.Add('INSERT INTO FRETRA(FRE_CODTRA, FRE_CODCID, FRE_VALISE, ');
          qryGravar.SQL.Add('FRE_MINFRE, FRE_PERTOT, FRE_VALKIL, FRE_PD100K, FRE_PERGRI, ');
          qryGravar.SQL.Add('FRE_MINGRI, FRE_VALTAS, AUTOINCREM)');
          qryGravar.SQL.Add('VALUES(:FRE_CODTRA, :FRE_CODCID, :FRE_VALISE, ');
          qryGravar.SQL.Add(':FRE_MINFRE, :FRE_PERTOT, :FRE_VALKIL, :FRE_PD100K, :FRE_PERGRI, ');
          qryGravar.SQL.Add(':FRE_MINGRI, :FRE_VALTAS, :AUTOINCREM)');

          qryGravar.ParamByName('FRE_CODTRA').AsString := cdsDadosIns.FieldByName('CODTRA').AsString;
          qryGravar.ParamByName('FRE_CODCID').AsString := cdsDadosIns.FieldByName('CODCID').AsString;
          qryGravar.ParamByName('FRE_VALISE').AsFloat  := cdsDadosIns.FieldByName('VALISE').AsFloat;
          qryGravar.ParamByName('FRE_MINFRE').AsFloat  := cdsDadosIns.FieldByName('VALFTE').AsFloat;
          qryGravar.ParamByName('FRE_PERTOT').AsFloat  := cdsDadosIns.FieldByName('PERVNF').AsFloat;
          qryGravar.ParamByName('FRE_VALKIL').AsFloat  := cdsDadosIns.FieldByName('VALKLG').AsFloat;
          qryGravar.ParamByName('FRE_PD100K').AsFloat  := cdsDadosIns.FieldByName('VALPED').AsFloat;
          qryGravar.ParamByName('FRE_PERGRI').AsFloat  := cdsDadosIns.FieldByName('PERGRI').AsFloat;
          qryGravar.ParamByName('FRE_MINGRI').AsFloat  := cdsDadosIns.FieldByName('VALGRI').AsFloat;
          qryGravar.ParamByName('FRE_VALTAS').AsFloat  := cdsDadosIns.FieldByName('VALTAS').AsFloat;
          qryGravar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FRETRA', VS_strCodEmp);
          qryGravar.ExecSQL;
        End;
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

function TfrmImportCadFreteTranspCidadeConfirma.fAlterarRegistroNoBanco(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryGravar: TUniQuery;
begin
  inherited;
  Result:= True;
  ModalResult := mrOK;
  cdsDadosUpd.First;

  If (Not(cdsDadosUpd.Locate('MARCADO', '1', []))) Then
  Begin
    Exit;
  End;

  cdsDadosUpd.First;

  pgbProgresso.Properties.Max := cdsDadosUpd.RecordCount -1;

  qryGravar:= fCriaQuery();
  Try
    While Not(cdsDadosUpd.Eof) do
    Begin

      Try
        pVerificaSeRegistroEstaMarcado(cdsDadosUpd.FieldByName('MARCADO').AsInteger);

        qryGravar.Close;
        qryGravar.SQL.Clear;
        qryGravar.SQL.Add('UPDATE FRETRA SET FRE_VALISE = :FRE_VALISE, ');
        qryGravar.SQL.Add('FRE_MINFRE = :FRE_MINFRE, FRE_PERTOT = :FRE_PERTOT, ');
        qryGravar.SQL.Add('FRE_VALKIL = :FRE_VALKIL, FRE_PD100K = :FRE_PD100K, ');
        qryGravar.SQL.Add('FRE_PERGRI = :FRE_PERGRI, FRE_MINGRI = :FRE_MINGRI, ');
        qryGravar.SQL.Add('FRE_VALTAS = :FRE_VALTAS WHERE FRE_CODTRA = :FRE_CODTRA ');
        qryGravar.SQL.Add('AND FRE_CODCID = :FRE_CODCID');

        qryGravar.ParamByName('FRE_CODTRA').AsString := cdsDadosUpd.FieldByName('CODTRA').AsString;
        qryGravar.ParamByName('FRE_CODCID').AsString := cdsDadosUpd.FieldByName('CODCID').AsString;

        qryGravar.ParamByName('FRE_VALISE').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALISE').AsString,
                                                                        cdsDadosUpd.FieldByName('VALISE_NOVO').AsString);


        qryGravar.ParamByName('FRE_MINFRE').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALFTE').AsString,
                                                                        cdsDadosUpd.FieldByName('VALFTE_NOVO').AsString);

        qryGravar.ParamByName('FRE_PERTOT').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('PERVNF').AsString,
                                                                        cdsDadosUpd.FieldByName('PERVNF_NOVO').AsString);

        qryGravar.ParamByName('FRE_VALKIL').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALKLG').AsString,
                                                                        cdsDadosUpd.FieldByName('VALKLG_NOVO').AsString);

        qryGravar.ParamByName('FRE_PD100K').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALPED').AsString,
                                                                        cdsDadosUpd.FieldByName('VALPED_NOVO').AsString);

        qryGravar.ParamByName('FRE_PERGRI').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('PERGRI').AsString,
                                                                        cdsDadosUpd.FieldByName('PERGRI_NOVO').AsString);

        qryGravar.ParamByName('FRE_MINGRI').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALGRI').AsString,
                                                                        cdsDadosUpd.FieldByName('VALGRI_NOVO').AsString);

        qryGravar.ParamByName('FRE_VALTAS').AsFloat  := fValidaRetornaInfo(cdsDadosUpd.FieldByName('VALTAS').AsString,
                                                                        cdsDadosUpd.FieldByName('VALTAS_NOVO').AsString);

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

procedure TfrmImportCadFreteTranspCidadeConfirma.btnDesmarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnDesmUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnMarcUpdAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnVisProdNaoImpClick(
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
  pPreviewReport(Self.Name, Self.Caption + ' (Registros não Importados)', frxRepNaoImp);

end;

procedure TfrmImportCadFreteTranspCidadeConfirma.cxgTransportadoraInsCustomDrawCell(
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

procedure TfrmImportCadFreteTranspCidadeConfirma.cxgTransportadoraInsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarIncClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeConfirma.cxgTransportadoraViewCustomDrawCell(
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

procedure TfrmImportCadFreteTranspCidadeConfirma.cxgTransportadoraViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_SPACE: btnMarcarUpdClick(Sender);
  End;

end;

procedure TfrmImportCadFreteTranspCidadeConfirma.pMarcar(cdsDados: TUniClientDataSet);
Begin
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsInteger  := IIf(cdsDados.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDados.Post;
End;

procedure TfrmImportCadFreteTranspCidadeConfirma.pVerificaSeRegistroEstaMarcado(
  intMarcado: Integer);
begin
  If intMarcado < 1 Then
    raise Exception.Create('O Registro não está marcado!');
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.tbsAlteraShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosUpd;
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.tbsIncluiShow(Sender: TObject);
begin
  inherited;
  cdsDados:= cdsDadosIns;
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnMarcarUpdClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosUpd);
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnMarcarIncAllClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.btnMarcarIncClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(cdsDadosIns);
end;

function TfrmImportCadFreteTranspCidadeConfirma.fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
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

procedure TfrmImportCadFreteTranspCidadeConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  dtsDadosIns.DataSet:= cdsDadosIns;
  dtsDadosUpd.DataSet:= cdsDadosUpd
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.FormKeyDown(Sender: TObject;
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

function TfrmImportCadFreteTranspCidadeConfirma.fValidaRetornaInfo(strInfoOld,
  strInfoNovo: String): Variant;
begin
  Result:= Null;
  If (Not(fEmptyStr(strInfoNovo))) Then
    Result  := strInfoNovo
  Else If Not(fEmptyStr(strInfoOld)) Then
    Result  := strInfoOld;
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.pIncluiCidadeNaoImportada(
  strCodigo: String);
begin
  cdsCidadeNaoImportadaRelatorio.Insert;
  cdsCidadeNaoImportadaRelatorioCODCID.AsString := strCodigo;
  cdsCidadeNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.pIncluiTransportadoraNaoImportada(
  strCodigo: String);
begin
  cdsTranspNaoImportadaRelatorio.Insert;
  cdsTranspNaoImportadaRelatorioCODTRA.AsString := strCodigo;
  cdsTranspNaoImportadaRelatorio.Post;
end;

procedure TfrmImportCadFreteTranspCidadeConfirma.pMarcaDesmarcaTodos(
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
