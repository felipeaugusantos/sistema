unit untImportacaoCustosRegimeTributarioFranquiasConfirma;

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
  TfrmImportacaoCustosRegimeTributarioFranquiasConfirma = class(TfrmPaiConfirma)
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
    cxgItensViewDesIte: TcxGridDBColumn;
    cxlDados: TcxGridLevel;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewCodEmp: TcxGridDBColumn;
    cxgItensViewRegTri: TcxGridDBColumn;
    ITE_MARBR1: TcxGridDBColumn;
    ITE_PREVE1: TcxGridDBColumn;
    ITE_MARBR2: TcxGridDBColumn;
    ITE_PREVE2: TcxGridDBColumn;
    ITE_MARBR3: TcxGridDBColumn;
    ITE_PREVE3: TcxGridDBColumn;
    ITE_MARBR4: TcxGridDBColumn;
    ITE_PREVE4: TcxGridDBColumn;
    ITE_MARBR5: TcxGridDBColumn;
    ITE_PREVE5: TcxGridDBColumn;
    ITE_MARBR6: TcxGridDBColumn;
    ITE_PREVE6: TcxGridDBColumn;
    ITE_MARBR7: TcxGridDBColumn;
    ITE_PREVE7: TcxGridDBColumn;
    cxgItensViewPossuiDiferenca: TcxGridDBColumn;
    DIF_MARBR1: TcxGridDBColumn;
    DIF_PREVE1: TcxGridDBColumn;
    DIF_MARBR2: TcxGridDBColumn;
    DIF_PREVE2: TcxGridDBColumn;
    DIF_MARBR3: TcxGridDBColumn;
    DIF_PREVE3: TcxGridDBColumn;
    DIF_MARBR4: TcxGridDBColumn;
    DIF_PREVE4: TcxGridDBColumn;
    DIF_MARBR5: TcxGridDBColumn;
    DIF_PREVE5: TcxGridDBColumn;
    DIF_MARBR6: TcxGridDBColumn;
    DIF_PREVE6: TcxGridDBColumn;
    DIF_MARBR7: TcxGridDBColumn;
    DIF_PREVE7: TcxGridDBColumn;
    frxReportJ_Criticas: TfrxReport;
    frxDbCriticas: TfrxDBDataset;
    NOVO_MARBR1: TcxGridDBColumn;
    NOVO_PREVE1: TcxGridDBColumn;
    NOVO_PREVE2: TcxGridDBColumn;
    NOVO_MARBR2: TcxGridDBColumn;
    NOVO_MARBR3: TcxGridDBColumn;
    NOVO_PREVE3: TcxGridDBColumn;
    NOVO_MARBR4: TcxGridDBColumn;
    NOVO_PREVE4: TcxGridDBColumn;
    NOVO_MARBR5: TcxGridDBColumn;
    NOVO_PREVE5: TcxGridDBColumn;
    NOVO_MARBR6: TcxGridDBColumn;
    NOVO_PREVE6: TcxGridDBColumn;
    NOVO_MARBR7: TcxGridDBColumn;
    NOVO_PREVE7: TcxGridDBColumn;
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
    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
    function fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
    procedure pAbrirRelatorioCriticas;
    procedure pSetaVisibilidadeCampo(blnVisible: Boolean; cxCampoMargem: TcxGridDBColumn = NIL; cxCampoVenda: TcxGridDBColumn = NIL; cxNovoCampoMargem: TcxGridDBColumn = NIL; cxNovoCampoVenda: TcxGridDBColumn = NIL);
  public
    function ShowModal(cdsDadosItens, cdsDadosItensNaoImportados: TZClient): Integer; reintroduce;
    { Public declarations }
  end;

var
  frmImportacaoCustosRegimeTributarioFranquiasConfirma: TfrmImportacaoCustosRegimeTributarioFranquiasConfirma;

implementation

{$R *.dfm}

uses untGravando;

{ TfrmImportacaoCustosRegimeTributarioFranquiasConfirma }
procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.btnConfirmaClick(Sender: TObject);
var
  lfrmGravando: TfrmGravando;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, lfrmGravando);
      lfrmGravando.fExecutarAcao := fGravar;
      lfrmGravando.lblGravando.Caption := 'Aguarde... Gravando Custos.';
      lfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.btnConfirmaClick]');
      End;
    End;
  Finally
    FreeAndNil(lfrmGravando);
  End;

  inherited;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If pos('NOVO', AViewInfo.Item.Name) > 0 Then
    ACanvas.Brush.Color := clMoneyGreen;

  If fFieldTemDivergencia(AViewInfo, AViewInfo.GridRecord.RecordIndex) Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color := clwhite;
  End;
end;

function TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.fAtualizarItem: Boolean;
var
  qryUpdate: TUniQuery;
begin
  Result := True;

  qryUpdate := fCriaQuery;

  Try
    Try
      qryUpdate.SQL.Add('UPDATE ITERFI SET');
      qryUpdate.SQL.Add('ITE_MARBR1 = :MARBR1,');
      qryUpdate.SQL.Add('ITE_MARBR2 = :MARBR2,');
      qryUpdate.SQL.Add('ITE_MARBR3 = :MARBR3,');
      qryUpdate.SQL.Add('ITE_MARBR4 = :MARBR4,');
      qryUpdate.SQL.Add('ITE_MARBR5 = :MARBR5,');
      qryUpdate.SQL.Add('ITE_MARBR6 = :MARBR6,');
      qryUpdate.SQL.Add('ITE_MARBR7 = :MARBR7,');
      qryUpdate.SQL.Add('ITE_PREVE1 = :PREVE1,');
      qryUpdate.SQL.Add('ITE_PREVE2 = :PREVE2,');
      qryUpdate.SQL.Add('ITE_PREVE3 = :PREVE3,');
      qryUpdate.SQL.Add('ITE_PREVE4 = :PREVE4,');
      qryUpdate.SQL.Add('ITE_PREVE5 = :PREVE5,');
      qryUpdate.SQL.Add('ITE_PREVE6 = :PREVE6,');
      qryUpdate.SQL.Add('ITE_PREVE7 = :PREVE7,');
      qryUpdate.SQL.Add('ITE_ULTALT = :ULTALT,');
      qryUpdate.SQL.Add('ITE_OPEALT = :OPEALT');
      qryUpdate.SQL.Add('WHERE ITE_CODITE = :CODITE');
      qryUpdate.SQL.Add('AND ITE_CODEMP =   :CODEMP');
      qryUpdate.SQL.Add('AND ITE_REGTRI =   :REGTRI');

      qryUpdate.ParamByName('MARBR1').AsFloat := cdsItens.FieldByName('NOVO_MARBR1').AsFloat;
      qryUpdate.ParamByName('MARBR2').AsFloat := cdsItens.FieldByName('NOVO_MARBR2').AsFloat;
      qryUpdate.ParamByName('MARBR3').AsFloat := cdsItens.FieldByName('NOVO_MARBR3').AsFloat;
      qryUpdate.ParamByName('MARBR4').AsFloat := cdsItens.FieldByName('NOVO_MARBR4').AsFloat;
      qryUpdate.ParamByName('MARBR5').AsFloat := cdsItens.FieldByName('NOVO_MARBR5').AsFloat;
      qryUpdate.ParamByName('MARBR6').AsFloat := cdsItens.FieldByName('NOVO_MARBR6').AsFloat;
      qryUpdate.ParamByName('MARBR7').AsFloat := cdsItens.FieldByName('NOVO_MARBR7').AsFloat;
      qryUpdate.ParamByName('PREVE1').AsFloat := cdsItens.FieldByName('NOVO_PREVE1').AsFloat;
      qryUpdate.ParamByName('PREVE2').AsFloat := cdsItens.FieldByName('NOVO_PREVE2').AsFloat;
      qryUpdate.ParamByName('PREVE3').AsFloat := cdsItens.FieldByName('NOVO_PREVE3').AsFloat;
      qryUpdate.ParamByName('PREVE4').AsFloat := cdsItens.FieldByName('NOVO_PREVE4').AsFloat;
      qryUpdate.ParamByName('PREVE5').AsFloat := cdsItens.FieldByName('NOVO_PREVE5').AsFloat;
      qryUpdate.ParamByName('PREVE6').AsFloat := cdsItens.FieldByName('NOVO_PREVE6').AsFloat;
      qryUpdate.ParamByName('PREVE7').AsFloat := cdsItens.FieldByName('NOVO_PREVE7').AsFloat;
      qryUpdate.ParamByName('CODITE').AsString := cdsItens.FieldByName('ITE_CODITE').AsString;
      qryUpdate.ParamByName('CODEMP').AsString := cdsItens.FieldByName('ITE_CODEMP').AsString;
      qryUpdate.ParamByName('REGTRI').AsString := cdsItens.FieldByName('ITE_REGTRI').AsString;
      qryUpdate.ParamByName('ULTALT').AsDateTime := fNow;
      qryUpdate.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      qryUpdate.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.fAtualizarCadIte]');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.fGravar(
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
      if not fAtualizarItem then
      begin
        Result := False;
        Break;
      end;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;

      cdsItens.Next;
    end;

    if Result then
    begin
      fCommit;

      fMensagem('Aviso', 'Processo concluído com sucesso!', ['&O k']);
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

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.FormCreate(
  Sender: TObject);
begin
  inherited;
  dtsItens := TDataSource.Create(nil);
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.FormDestroy(
  Sender: TObject);
begin
  FreeAndNil(dtsItens);
  inherited;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.FormShow(
  Sender: TObject);
var
  intContador: Integer;
begin
  inherited;

  For intContador := 1 To Length(VS_strTabPrc) Do
  Begin
    case intContador of
      1: pSetaVisibilidadeCampo(VS_strTabPrc[1] = 'S', ITE_MARBR1, ITE_PREVE1, NOVO_MARBR1, NOVO_PREVE1);
      2: pSetaVisibilidadeCampo(VS_strTabPrc[2] = 'S', ITE_MARBR2, ITE_PREVE2, NOVO_MARBR2, NOVO_PREVE2);
      3: pSetaVisibilidadeCampo(VS_strTabPrc[3] = 'S', ITE_MARBR3, ITE_PREVE3, NOVO_MARBR3, NOVO_PREVE3);
      4: pSetaVisibilidadeCampo(VS_strTabPrc[4] = 'S', ITE_MARBR4, ITE_PREVE4, NOVO_MARBR4, NOVO_PREVE4);
      5: pSetaVisibilidadeCampo(VS_strTabPrc[5] = 'S', ITE_MARBR5, ITE_PREVE5, NOVO_MARBR5, NOVO_PREVE5);
      6: pSetaVisibilidadeCampo(VS_strTabPrc[6] = 'S', ITE_MARBR6, ITE_PREVE6, NOVO_MARBR6, NOVO_PREVE6);
      7: pSetaVisibilidadeCampo(VS_strTabPrc[7] = 'S', ITE_MARBR7, ITE_PREVE7, NOVO_MARBR7, NOVO_PREVE7);
    End;
  End;

  pAbrirRelatorioCriticas;
end;

function TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.ShowModal(cdsDadosItens, cdsDadosItensNaoImportados: TZClient): Integer;
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

function TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
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

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.pAbrirRelatorioCriticas;
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

procedure TfrmImportacaoCustosRegimeTributarioFranquiasConfirma.pSetaVisibilidadeCampo(
  blnVisible: Boolean; cxCampoMargem: TcxGridDBColumn = NIL; cxCampoVenda: TcxGridDBColumn = NIL; cxNovoCampoMargem: TcxGridDBColumn = NIL; cxNovoCampoVenda: TcxGridDBColumn = NIL);
begin
  If assigned(cxCampoMargem) Then
    cxCampoMargem.Visible := blnVisible;

  if Assigned(cxCampoVenda) Then
    cxCampoVenda.Visible  := blnVisible;

  If assigned(cxNovoCampoMargem) Then
    cxNovoCampoMargem.Visible := blnVisible;

  if Assigned(cxNovoCampoVenda) Then
    cxNovoCampoVenda.Visible  := blnVisible;
end;

end.
