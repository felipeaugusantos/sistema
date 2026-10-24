unit untConfirmaImportacaoProdutosAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils, UniClientDataSet, System.UITypes,
  cxTextEdit, Vcl.Grids, Vcl.DBGrids, EditFocus, Math;

type
  TfrmConfirmaImportacaoProdutosAjuste = class(TfrmPaiConfirma)
    dtsItens: TDataSource;
    grpLegenda: TGroupBox;
    shpProdutoComInconsistencia: TShape;
    lblProdutoComInconsistencia: TLabel;
    cxgProdutosImportadosDBTableView1: TcxGridDBTableView;
    cxgProdutosImportadosLevel1: TcxGridLevel;
    cxgProdutosImportados: TcxGrid;
    cxgProAjuDBCODITE: TcxGridDBColumn;
    cxgProAjuDBDESITE: TcxGridDBColumn;
    cxgProAjuDBUNIITE: TcxGridDBColumn;
    cxgProAjuDBCODREF: TcxGridDBColumn;
    shpProdutoOk: TShape;
    lblProdutoOk: TLabel;
    cxgProAjuDBSALDIS: TcxGridDBColumn;
    cxgProAjuDBQTDITE: TcxGridDBColumn;
    cxgProAjuDBVALIDACAO: TcxGridDBColumn;
    pnlTopo: TPanel;
    rdgOpcoesPesquisa: TRadioGroup;
    cxgProAjuDBSALEXT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgProdutosImportadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure rdgOpcoesPesquisaClick(Sender: TObject);
    procedure cxgProdutosImportadosDBTableView1EditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    arrNFPendentes: Array Of String;

    function fTemInconsistencia: Boolean;
    procedure pFiltrarItens(blnApenasInconsistentes: Boolean);
    function fTemNotasPendentes: Boolean;
    function fConfirma(pgbStatus: TcxProgressBar): Boolean;
    procedure ValidarColunas;
  public
    { Public declarations }
    cdsItens : TUniClientDataSet;
    blnOk : Boolean;
    strHUBMKP: string;
    dtaDataPlan: TDateTime;
    hraHoraPlan: TTime;
  end;

implementation

uses
  untGravando,
  untConsultas,
  untTypesSistema,
  untLiberacao,
  untFuncoesSimples;

{$R *.dfm}

function TfrmConfirmaImportacaoProdutosAjuste.fTemNotasPendentes:Boolean;
var
  LNFeImp : TUniQuery;
begin
  LNFeImp := fCriaQuery;

  try
    SetLength(arrNFPendentes, 0);

    LNFeImp.SQL.Add('SELECT CONCAT(NFE_NUMDOC, "-", NFE_ESPDOC, "-", NFE_CODEMP) AS NUMDOC ');
    LNFeImp.SQL.Add('FROM NFEIMP ');
    LNFeImp.SQL.Add('WHERE NFE_IMPORT IN ("N", "E", "P") ');
    LNFeImp.SQL.Add('  AND NFE_HUBMKP = :HUBMKP ');
    LNFeImp.SQL.Add('  AND NFE_CODEMP = :CODEMP ');
    LNFeImp.SQL.Add('  AND CAST(CONCAT(NFE_DTAEMI, " ", NFE_HRAEMI) AS DATETIME) <= ' +
      QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', dtaDataPlan + hraHoraPlan)));

    LNFeImp.ParamByName('HUBMKP').AsString := strHUBMKP;
    LNFeImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LNFeImp.Open;

    LNFeImp.First;
    while not LNFeImp.Eof do
    begin
      SetLength(arrNFPendentes, Length(arrNFPendentes) +1);
      arrNFPendentes[Pred(Length(arrNFPendentes))] := LNFeImp.FieldByName('NUMDOC').AsString;

      LNFeImp.Next;
    end;

    Result := Length(arrNFPendentes) > 0;

  finally
    FreeAndNil(LNFeImp);
  end;
End;

function TfrmConfirmaImportacaoProdutosAjuste.fTemInconsistencia:Boolean;
begin
  cdsItens.DisableControls;
  Try
    pFiltrarItens(True);
    Result := Not cdsItens.IsEmpty;
  Finally
    pFiltrarItens(rdgOpcoesPesquisa.ItemIndex = 1);
    cdsItens.EnableControls;
  End;
end;

function TfrmConfirmaImportacaoProdutosAjuste.fConfirma(pgbStatus: TcxProgressBar): Boolean;
  Var
    objLiberacao: TLiberacao;
    strNFPendente: String;
Begin
  Result := False;

  If (fTemInconsistencia) And
     (fMensagem('ATENÇÃO!', 'Ainda há inconsistências na grade. Ao confirmar, apenas os produtos sem inconsistências serão importados para o Ajuste.' + #13#10 +
                'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  If fTemNotasPendentes Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Permitir importar planilha e realizar ajuste de estoque externo mesmo com notas pendentes de importação de dias anteriores.');
      objLiberacao.objMsgLibera.pAddSeparador(100);
      objLiberacao.objMsgLibera.pAddTexto('Notas que ainda não foram importadas:');

      For strNFPendente In arrNFPendentes Do
        objLiberacao.objMsgLibera.pAddTexto(strNFPendente);

      objLiberacao.strDirAce := 'PERIMPPLANP';
      objLiberacao.strMsgSen := 'Permitir importar planilha e realizar ajuste de estoque externo mesmo com notas pendentes de importação de dias anteriores';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      blnOk := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End
  Else
    blnOk := True;
End;

procedure TfrmConfirmaImportacaoProdutosAjuste.btnConfirmaClick(Sender: TObject);
  Var
    frmGravando : TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fConfirma;
    frmGravando.lblGravando.Caption := 'Aguarde... Processando Itens...';
    frmGravando.Showmodal;

    If blnOk Then
      pMensagemOk('Importação concluída com sucesso!');

    inherited;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.cxgProdutosImportadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strValidacao : String;
begin
  inherited;

  If cdsItens.RecordCount = 0 Then
    Exit;

  strValidacao := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgProAjuDBVALIDACAO.Index]);

  ACanvas.Font.Color := clBlack;
  If Not fEmptyStr(strValidacao) Then
    ACanvas.Brush.Color := shpProdutoComInconsistencia.Brush.Color
  Else
    ACanvas.Brush.Color := shpProdutoOk.Brush.Color;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.ValidarColunas;
var
  strValidacao : String;
  fltSalDis : Double;
begin
  strValidacao := '';

  If cdsItens.State = dsEdit Then
    cdsItens.Post;

  If (StrToFloatDef(cdsItens.FieldByName('QTDITE').AsString, 0) <= 0) Then
    strValidacao := 'Quantidade não informada ou valor inválido!';

  fltSalDis := fRetornaSaldoDisponivel(cdsItens.FieldByName('CODITE').AsString, False, True);

  If fEmptyStr(cdsItens.FieldByName('DESITE').AsString) Then
    strValidacao := 'Código de produto não encontrado no autcom!';

  If (strValidacao <> cdsItens.FieldByName('VALIDACAO').AsString) Then
  Begin
    If Not (dtsItens.State in dsEditModes) Then
      cdsItens.Edit;

    cdsItens.FieldByName('VALIDACAO').AsString := strValidacao;
    cdsItens.Post;
  End;

  If fltSalDis <> cdsItens.FieldByName('SALDIS').AsFloat Then
  Begin
    If Not (dtsItens.State in dsEditModes) Then
      cdsItens.Edit;

    cdsItens.FieldByName('SALDIS').AsFloat := fltSalDis;
    cdsItens.Post;
  End;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.cxgProdutosImportadosDBTableView1EditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  ValidarColunas;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.FormCreate(Sender: TObject);
begin
  inherited;
  blnOk := False;
  SetLength(arrNFPendentes, 0);

  dtaDataPlan := 0;
  hraHoraPlan := 0;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirma.Click;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet := cdsItens;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.rdgOpcoesPesquisaClick(
  Sender: TObject);
begin
  inherited;
  Case rdgOpcoesPesquisa.ItemIndex Of
    0: pFiltrarItens(False);
    1: pFiltrarItens(True);
  End;
end;

procedure TfrmConfirmaImportacaoProdutosAjuste.pFiltrarItens(blnApenasInconsistentes: Boolean);
begin
  cdsItens.Filter := 'VALIDACAO <> '+QuotedStr('');
  cdsItens.Filtered := blnApenasInconsistentes;
end;

end.
