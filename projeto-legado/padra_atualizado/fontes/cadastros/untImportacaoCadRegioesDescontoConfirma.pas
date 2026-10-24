unit untImportacaoCadRegioesDescontoConfirma;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, uni, untFuncoesSimples, untSalvaConfiguracaoGrid,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
 frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
 BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
 cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
 cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
 cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
 untZClient, MyClassesUni, frxDBSet, Vcl.ComCtrls, cxContainer, cxProgressBar, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox, cxGridDBDataDefinitions,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  System.StrUtils, dxLayoutContainer, cxGridViewLayoutContainer,
  cxGridLayoutView, cxGridCustomLayoutView, cxGridCitel;

 type
  TfrmImportacaoCadRegioesDescontoConfirma = class(TfrmPaiConfirma)
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    cxStyleRepository: TcxStyleRepository;
    styDentro: TcxStyle;
    styFora: TcxStyle;
    styEditavel: TcxStyle;
    grpLegenda: TGroupBox;
    shpNaoImportados: TShape;
    lblValoresAlterados: TLabel;
    cxDados: TcxGridCitel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensViewREG_DESREG: TcxGridDBColumn;
    cxlDados: TcxGridLevel;
    cxgItensViewRDS_CODREG: TcxGridDBColumn;
    RDS_PERCOM: TcxGridDBColumn;
    RDS_PERDES: TcxGridDBColumn;
    cxgItensViewPossuiDiferenca: TcxGridDBColumn;
    DIF_PERCOM: TcxGridDBColumn;
    DIF_PERDES: TcxGridDBColumn;
    frxReportJ_Criticas: TfrxReport;
    frxDbCriticas: TfrxDBDataset;
    NOVO_PERCOM: TcxGridDBColumn;
    NOVO_PREULT: TcxGridDBColumn;
    cxgItensViewRDS_CODFOR: TcxGridDBColumn;
    cxgItensViewFOR_NOMFOR: TcxGridDBColumn;
    Label1: TLabel;
    Shape1: TShape;
    cxgItensViewAUTOINCREM: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cdsItens, cdsItensNaoEncontrados: TZClient;
    dtsItens: TDataSource;

    { Private declarations }
    function fAtualizarItem: Boolean;
    function fCriaItem: Boolean;
    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
    function fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: Integer):Boolean;
    function fFieldItemNovo(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: Integer):Boolean;
    procedure pAbrirRelatorioCriticas;
    function fGetInsertREGDES: String;
    function fGetUpdateREGDES: String;
  public
    function ShowModal(cdsDadosItens, cdsDadosItensNaoImportados: TZClient): Integer; reintroduce;
    { Public declarations }
  end;

var
  frmImportacaoCadRegioesDescontoConfirma: TfrmImportacaoCadRegioesDescontoConfirma;

implementation

{$R *.dfm}

uses untGravando, untCalculoPrecoMedio, untTConfiguracao;

{ TfrmImportacaoCadRegioesDescontoConfirma }
procedure TfrmImportacaoCadRegioesDescontoConfirma.btnConfirmaClick(Sender: TObject);
var
  lfrmGravando: TfrmGravando;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, lfrmGravando);
      lfrmGravando.fExecutarAcao := fGravar;
      lfrmGravando.lblGravando.Caption := 'Aguarde... Gravando informações.';
      lfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportacaoCadRegioesDescontoConfirma.btnConfirmaClick]');
      End;
    End;
  Finally
    FreeAndNil(lfrmGravando);
  End;

  inherited;
end;

procedure TfrmImportacaoCadRegioesDescontoConfirma.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If pos('NOVO', AViewInfo.Item.Name) > 0 Then
    ACanvas.Brush.Color := clSilver;

  If fFieldTemDivergencia(AViewInfo, AViewInfo.GridRecord.RecordIndex) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;

  If fFieldItemNovo(AViewInfo, AViewInfo.GridRecord.RecordIndex) Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color := clBlack;
  End;
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fAtualizarItem: Boolean;
var
  qryUpdate: TUniQuery;
begin
  Result := True;

  qryUpdate := fCriaQuery;

  Try
    Try
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(fGetUpdateREGDES);

      qryUpdate.ParamByName('AUTOINCREM').AsString := cdsItens.FieldByName('AUTOINCREM').AsString;
      qryUpdate.ParamByName('PERCOM').AsFloat  := cdsItens.FieldByName('NOVO_PERCOM').AsFloat;
      qryUpdate.ParamByName('PERDES').AsFloat  := cdsItens.FieldByName('NOVO_PERDES').AsFloat;

      qryUpdate.ExecSQL;
    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(e.Message, 'TfrmImportacaoCadRegioesDescontoConfirma.fGravaDados_ITEGER');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fCriaItem: Boolean;
var
  qryInsert: TUniQuery;
begin
  Result := True;

  qryInsert := fCriaQuery;

  Try
    Try
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(fGetInsertREGDES);

      qryInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('REGDES', VS_strCodEmp);
      qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryInsert.ParamByName('CODFOR').AsString  := cdsItens.FieldByName('RDS_CODFOR').AsString;
      qryInsert.ParamByName('CODREG').AsString  := cdsItens.FieldByName('RDS_CODREG').AsString;
      qryInsert.ParamByName('PERCOM').AsFloat  := cdsItens.FieldByName('NOVO_PERCOM').AsFloat;
      qryInsert.ParamByName('PERDES').AsFloat  := cdsItens.FieldByName('NOVO_PERDES').AsFloat;

      qryInsert.ExecSQL;
    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(e.Message, 'TfrmImportacaoCadRegioesDescontoConfirma.fGravaDados_ITEGER');
      End;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fGravar(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  try
    cdsItens.DisableControls;

    cdsItens.Filter := 'POSSUI_DIFERENCA = ' + QuotedStr('S');
    cdsItens.Filtered := True;

    if not (cdsItens.RecordCount > 0) then
    begin
      fMensagem('Aviso', 'Não foram encontradas alterações!', ['&O k']);
      Exit(False);
    end;

    pgbProgresso.Properties.Max := cdsItens.RecordCount;

    fStartTransaction;

    cdsItens.First;
    while not cdsItens.Eof do
    begin
      if fEmptyStr(cdsItens.FieldByName('AUTOINCREM').AsString) then
      begin
        if not fCriaItem then
        begin
          Result := False;
          Break;
        end;
      end
      else
      begin
        if not fAtualizarItem then
        begin
          Result := False;
          Break;
        end;
      end;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;

      cdsItens.Next;
    end;

    if Result then
    begin
      fCommit;

      fMensagem('Aviso', 'Processo concluido com sucesso!', ['&O k']);
    end
    else
    begin
      fRollBack;

      fMensagem('Aviso', 'Erro ao gravar informações!', ['&O k']);
    end;
  Finally
    cdsItens.EnableControls;
    cdsItens.Filter := EmptyStr;
    cdsItens.Filtered := False;
  End;
end;

procedure TfrmImportacaoCadRegioesDescontoConfirma.FormCreate(
  Sender: TObject);
begin
  inherited;
  dtsItens := TDataSource.Create(nil);
end;

procedure TfrmImportacaoCadRegioesDescontoConfirma.FormDestroy(
  Sender: TObject);
begin
  FreeAndNil(dtsItens);
  inherited;
end;

procedure TfrmImportacaoCadRegioesDescontoConfirma.FormShow(
  Sender: TObject);
begin
  inherited;
  cxgItensView.ApplyBestFit;
  pAbrirRelatorioCriticas;
end;

function TfrmImportacaoCadRegioesDescontoConfirma.ShowModal(cdsDadosItens, cdsDadosItensNaoImportados: TZClient): Integer;
begin
  cdsItens := cdsDadosItens;
  cdsItensNaoEncontrados := cdsDadosItensNaoImportados;

  cdsItens.Open;
  cdsItensNaoEncontrados.Open;

  frxDbCriticas.DataSet := cdsItensNaoEncontrados;

  dtsItens.DataSet := cdsItens;

  cxgItensView.DataController.DataSource := dtsItens;

  Result := inherited ShowModal;
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: Integer):Boolean;
var
  cxColumnDiff: TcxGridDBColumn;
  strFiledDiff: String;
  Grid: TcxGridDBTableView;
Begin
  Result := False;

  strFiledDiff := TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName;

  if Pos('NOVO_' ,strFiledDiff) <= 0 then
    Exit;

  Grid := cxgItensView;

  strFiledDiff := AnsiReplaceStr(strFiledDiff, 'NOVO_', 'DIF_');

  cxColumnDiff := Grid.GetColumnByFieldName(strFiledDiff);

  If Assigned(cxColumnDiff) Then
    Result := VarToStr(Grid.DataController.Values[RecordIndex, cxColumnDiff.Index]) = 'S';
End;

function TfrmImportacaoCadRegioesDescontoConfirma.fFieldItemNovo(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: Integer):Boolean;
var
  cxColumnDiff: TcxGridDBColumn;
  Grid: TcxGridDBTableView;
  t: string;
Begin
  Result := False;

  Grid := cxgItensView;

  cxColumnDiff := Grid.GetColumnByFieldName('AUTOINCREM');

  t:= VarToStr(Grid.DataController.Values[RecordIndex, cxColumnDiff.Index]);
  If Assigned(cxColumnDiff) Then
    Result := fEmptyStr(VarToStr(Grid.DataController.Values[RecordIndex, cxColumnDiff.Index]));
End;

procedure TfrmImportacaoCadRegioesDescontoConfirma.pAbrirRelatorioCriticas;
begin
  If Not (cdsItensNaoEncontrados.RecordCount > 0) Then
     Exit;

  frxReportJ_Criticas.DotMatrixReport           := False;
  frxReportJ_Criticas.PrintOptions.PrintMode    := pmScale;
  frxReportJ_Criticas.PrintOptions.PrintOnSheet := 9;

  frxReportJ_Criticas.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

  If frxReportJ_Criticas.PrepareReport Then
    pPreviewReport(Self.Name, Self.Caption, frxReportJ_Criticas);
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fGetUpdateREGDES: String;
begin
  Result := '';
  Result := Result + ' UPDATE REGDES SET              ';
  Result := Result + ' RDS_PERCOM = :PERCOM,          ';
  Result := Result + ' RDS_PERDES = :PERDES           ';
  Result := Result + ' WHERE AUTOINCREM = :AUTOINCREM ';
end;

function TfrmImportacaoCadRegioesDescontoConfirma.fGetInsertREGDES: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO REGDES (AUTOINCREM,      ';
  Result := Result + ' RDS_CODEMP, RDS_CODFOR, RDS_CODREG,  ';
  Result := Result + ' RDS_PERCOM, RDS_PERDES               ';
  Result := Result + ' ) VALUES (                           ';
  Result := Result + ' :AUTOINCREM, :CODEMP, :CODFOR,       ';
  Result := Result + ' :CODREG, :PERCOM, :PERDES)           ';
end;

end.
