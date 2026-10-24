unit untOpcoesExcelPedCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  cxCheckBox, untFuncoesSimples, untGravando, cxProgressBar, Uni,
  System.IOUtils;

type
  TTipoSelecao = (tsMarcarTodos, tsDesmarcarTodos, tsInverterSelecao);

  TfrmOpcoesExcelPedCompra = class(TfrmPaiConfirma)
    cdsCampos: TUniClientDataSet;
    cdsCamposCAMPO: TStringField;
    cdsCamposDESCR: TStringField;
    cdsCamposHABILI: TStringField;
    dtsCampos: TDataSource;
    cxGridCamposDBTableView: TcxGridDBTableView;
    cxGridCamposLevel1: TcxGridLevel;
    cxGridCampos: TcxGrid;
    cxGridCamposDBCAMPO: TcxGridDBColumn;
    cdsCamposORDEN: TIntegerField;
    cxGridCamposDBHABILI: TcxGridDBColumn;
    cxGridCamposDBORDEN: TcxGridDBColumn;
    btnMovCima: TBitBtnLocked;
    btnMoverBaixo: TBitBtnLocked;
    btnOpcoesSelecao: TBitBtnLocked;
    popOpcoesSel: TPopupMenu;
    miSelecionarTodos: TMenuItem;
    miDesmarcarTodos: TMenuItem;
    miInverterSelecao: TMenuItem;
    N1: TMenuItem;
    cdsCamposCAMPO_CHAVE: TStringField;
    pnlLegendas: TPanel;
    Label1: TLabel;
    lblLegCamposTravados: TLabel;
    shpCamposTravados: TShape;
    cdsCamposCAMPO_FIXO: TStringField;
    cxGridCamposDBCAMPO_FIXO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMovCimaClick(Sender: TObject);
    procedure btnMoverBaixoClick(Sender: TObject);
    procedure btnOpcoesSelecaoClick(Sender: TObject);
    procedure miSelecionarTodosClick(Sender: TObject);
    procedure miDesmarcarTodosClick(Sender: TObject);
    procedure miInverterSelecaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridCamposDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cdsCamposAfterScroll(DataSet: TDataSet);
  private
    procedure pAlimentarCds;
    procedure pAdicionarCampo(AStrCampo, AStrDescricao, AStrDescricaoAux: String; ABlnCampoFixo: Boolean = False);
    procedure pMontarListaCampos;
    procedure pMoverBaixo;
    procedure pMoverCima;
    procedure pSelecionarVarios(ATipoSelecao: TTipoSelecao);
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
    procedure pInverterSelecao;
    procedure pSalvarClientDataSet;
  private
    stlCampos: TStringList;
    function fCarregarClientDataSetAux(pgbProgresso: TCxProgressBar): Boolean;
  public
    class function fRetCampos(blAbreCadatro: Boolean = False): TStringList;
  end;

var
  frmOpcoesExcelPedCompra: TfrmOpcoesExcelPedCompra;

implementation

{$R *.dfm}

procedure TfrmOpcoesExcelPedCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pMontarListaCampos;
  pSalvarClientDataSet;
end;

procedure TfrmOpcoesExcelPedCompra.pSalvarClientDataSet;
var
  qryIns: TUniQuery;
begin
  qryIns := fCriaQuery;
  Try
    qryIns.SQL.Add('DELETE FROM PDCOEX WHERE PDC_CODEMP = :CODEMP AND PDC_CODOPE = :CODOPE;');
    qryIns.SQL.Add('INSERT INTO PDCOEX (AUTOINCREM, PDC_CODOPE, PDC_CODEMP, PDC_DTASET) VALUES (:AUTINC, :CODOPE, :CODEMP, :DTASET)');

    qryIns.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('PDCOEX', VS_strCodEmp);

    cdsCampos.SaveToFile(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml');
    qryIns.ParamByName('DTASET').LoadFromFile(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml', ftBlob);
    TFile.Delete(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml');
    Try
      fStartTransaction;
      qryIns.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmOpcoesExcelPedCompra.pSalvarClientDataSet]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmOpcoesExcelPedCompra.pMontarListaCampos;
begin
  cdsCampos.Filter := 'HABILI = ''S''';
  cdsCampos.Filtered := True;
  cdsCampos.First;
  cdsCampos.IndexFieldNames := 'ORDEN';
  stlCampos := TStringList.Create;
  While Not cdsCampos.Eof Do
  Begin
    stlCampos.Add(cdsCampos.FieldByname('CAMPO').AsString + '|' + cdsCampos.FieldByname('CAMPO_CHAVE').AsString);
    cdsCampos.Next;
  End;
end;

procedure TfrmOpcoesExcelPedCompra.pMoverCima;
var
  intOrdenAtualizar,
  intordenAtual: Integer;
begin
  If (cdsCampos.RecNo = 3) Or (cdsCampos.FieldByName('CAMPO').AsString = 'PCD_DESITE') Then
    Exit;

  intOrdenAtual := cdsCampos.FieldByName('ORDEN').AsInteger;
  cdsCampos.Prior;
  intOrdenAtualizar := cdsCampos.FieldByName('ORDEN').AsInteger;

  cdsCampos.Next;
  cdsCampos.Edit;
  cdsCampos.FieldByName('ORDEN').AsInteger := intOrdenAtualizar;
  cdsCampos.Post;

  cdsCampos.Prior;
  cdsCampos.Edit;
  cdsCampos.FieldByName('ORDEN').AsInteger := intOrdenAtual;
  cdsCampos.Post;
  cdsCampos.Prior;
end;

procedure TfrmOpcoesExcelPedCompra.pSelecionarVarios(
  ATipoSelecao: TTipoSelecao);
begin
  Case ATipoSelecao Of
    tsMarcarTodos: pMarcarTodos;
    tsDesmarcarTodos: pDesmarcarTodos;
    tsInverterSelecao: pInverterSelecao;
  End;
end;

procedure TfrmOpcoesExcelPedCompra.pMarcarTodos;
var
  intRecNo: Integer;
begin
  cdsCampos.First;
  intRecNo := cdsCampos.RecNo;
  cdsCampos.DisableControls;
  While Not cdsCampos.Eof Do
  Begin
    cdsCampos.Edit;
    cdsCampos.FieldByName('HABILI').AsString := 'S';
    cdsCampos.Post;
    cdsCampos.Next;
  End;
  cdsCampos.EnableControls;
  cdsCampos.RecNo := intRecNo;
end;

procedure TfrmOpcoesExcelPedCompra.pDesmarcarTodos;
var
  intRecNo: Integer;
begin
  cdsCampos.First;
  intRecNo := cdsCampos.RecNo;
  cdsCampos.DisableControls;
  While Not cdsCampos.Eof Do
  Begin
    If cdsCampos.FieldByName('CAMPO_FIXO').AsString <> 'S' Then
    Begin
      cdsCampos.Edit;
      cdsCampos.FieldByName('HABILI').AsString := 'N';
      cdsCampos.Post;
    End;

    cdsCampos.Next;
  End;
  cdsCampos.EnableControls;
  cdsCampos.RecNo := intRecNo;
end;

procedure TfrmOpcoesExcelPedCompra.pInverterSelecao;
var
  intRecNo: Integer;
begin
  cdsCampos.First;
  intRecNo := cdsCampos.RecNo;
  cdsCampos.DisableControls;
  While Not cdsCampos.Eof Do
  Begin
    cdsCampos.Edit;
    cdsCampos.FieldByName('HABILI').AsString := IIF(cdsCampos.FieldByName('HABILI').AsString = 'S', 'N', 'S');
    cdsCampos.Post;
    cdsCampos.Next;
  End;
  cdsCampos.EnableControls;
  cdsCampos.RecNo := intRecNo;
end;

procedure TfrmOpcoesExcelPedCompra.pMoverBaixo;
var
  intOrdenAtualizar,
  intordenAtual: Integer;
begin
  If (cdsCampos.RecNo = cdsCampos.RecordCount) Or (Pos(cdsCampos.FieldByName('CAMPO').AsString, 'PCD_CODITE_PCD_DESITE') > 0) Then
    Exit;

  intOrdenAtual := cdsCampos.FieldByName('ORDEN').AsInteger;
  cdsCampos.Next;
  intOrdenAtualizar := cdsCampos.FieldByName('ORDEN').AsInteger;

  cdsCampos.Edit;
  cdsCampos.FieldByName('ORDEN').AsInteger := intOrdenAtual;
  cdsCampos.Post;

  cdsCampos.Prior;
  cdsCampos.Edit;
  cdsCampos.FieldByName('ORDEN').AsInteger := intOrdenAtualizar;
  cdsCampos.Post;
end;

procedure TfrmOpcoesExcelPedCompra.btnMovCimaClick(Sender: TObject);
begin
  inherited;
  pMoverCima;
end;

procedure TfrmOpcoesExcelPedCompra.btnMoverBaixoClick(Sender: TObject);
begin
  inherited;
  pMoverBaixo;
end;

procedure TfrmOpcoesExcelPedCompra.btnOpcoesSelecaoClick(Sender: TObject);
begin
  inherited;
  popOpcoesSel.PopUp(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfrmOpcoesExcelPedCompra.cdsCamposAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cxGridCamposDBTableView.OptionsData.Editing := cdsCampos.FieldByname('CAMPO_FIXO').AsString = 'N';
end;

procedure TfrmOpcoesExcelPedCompra.cxGridCamposDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridCamposDBCAMPO_FIXO.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := $0075A2FF;
  End;
end;

procedure TfrmOpcoesExcelPedCompra.miDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionarVarios(tsDesmarcarTodos);
end;

procedure TfrmOpcoesExcelPedCompra.FormCreate(Sender: TObject);
begin
  inherited;
  pAlimentarCds;
  cdsCampos.IndexFieldNames := 'ORDEN';
  cdsCampos.First;
end;

procedure TfrmOpcoesExcelPedCompra.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecuta(fCarregarClientDataSetAux, frmGravando, 'Carregando alterações salvas...', False);
end;

class function TfrmOpcoesExcelPedCompra.fRetCampos(blAbreCadatro: Boolean = False): TStringList;
begin
  frmOpcoesExcelPedCompra := TfrmOpcoesExcelPedCompra.Create(nil);
  Result := TStringList.Create;
  Try
    If blAbreCadatro And (frmOpcoesExcelPedCompra.ShowModal = mrOK) Then
      Result.Text := frmOpcoesExcelPedCompra.stlCampos.Text
    Else
    Begin
      frmOpcoesExcelPedCompra.fCarregarClientDataSetAux(nil);
      frmOpcoesExcelPedCompra.pMontarListaCampos;
    End;


    Result.Text := frmOpcoesExcelPedCompra.stlCampos.Text;
  Finally
    FreeAndNil(frmOpcoesExcelPedCompra);
  End
end;

function TfrmOpcoesExcelPedCompra.fCarregarClientDataSetAux(
  pgbProgresso: TCxProgressBar): Boolean;
var
  qryAux: TUniQuery;
  cdsAux: TUniClientDataSet;
begin
  qryAux := fCriarQuery('SELECT PDC_DTASET FROM PDCOEX WHERE PDC_CODOPE = :CODOPE AND PDC_CODEMP = :CODEMP');
  Try
    Result := True;
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit(True);

    cdsAux := TUniClientDataSet.Create(Nil);

    TBlobField(qryAux.FieldByName('PDC_DTASET')).SaveToFile(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml');
    cdsAux.LoadFromFile(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml');
    TFile.Delete(ExtractFilePath(ParamStr(0))+'cdsCamposExcel.xml');

    cdsAux.First;
    cdsCampos.EmptyDataSet;
    While Not cdsAux.Eof Do
    Begin
      cdsCampos.Insert;
      cdsCampos.FieldByName('HABILI').AsString := cdsAux.FieldByName('HABILI').AsString;
      cdsCampos.FieldByName('ORDEN').AsInteger := cdsAux.FieldByName('ORDEN').AsInteger;
      cdsCampos.FieldByName('CAMPO').AsString := cdsAux.FieldByName('CAMPO').AsString;
      cdsCampos.FieldByName('DESCR').AsString := cdsAux.FieldByName('DESCR').AsString;
      cdsCampos.FieldByName('CAMPO_CHAVE').AsString := cdsAux.FieldByName('CAMPO_CHAVE').AsString;
      cdsCampos.FieldByName('CAMPO_FIXO').AsString := cdsAux.FieldByName('CAMPO_FIXO').AsString;
      cdsCampos.Post;

      cdsAux.Next;
    End;

    pAlimentarCds;

  Finally
    FreeAndNil(qryAux);
    FreeAndNil(cdsAux);
  End;
end;

procedure TfrmOpcoesExcelPedCompra.miInverterSelecaoClick(Sender: TObject);
begin
  inherited;
  pSelecionarVarios(tsInverterSelecao);
end;

procedure TfrmOpcoesExcelPedCompra.miSelecionarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionarVarios(tsMarcarTodos);
end;

procedure TfrmOpcoesExcelPedCompra.pAdicionarCampo(AStrCampo, AStrDescricao, AStrDescricaoAux: String; ABlnCampoFixo: Boolean = False);
begin
  If (Not (cdsCampos.Locate('CAMPO', AStrCampo, [loCaseInsensitive]))) Then
  Begin
    cdsCampos.Insert;
    cdsCampos.FieldByName('HABILI').AsString := 'S';
    cdsCampos.FieldByName('ORDEN').AsInteger := cdsCampos.RecordCount + 1;
    cdsCampos.FieldByName('CAMPO').AsString := AStrCampo;
    cdsCampos.FieldByName('DESCR').AsString := AStrDescricao;
    cdsCampos.FieldByName('CAMPO_CHAVE').AsString := AStrDescricaoAux;
    cdsCampos.FieldByName('CAMPO_FIXO').AsString := IIF(ABlnCampoFixo, 'S', 'N');
    cdsCampos.Post;
  End;
end;

procedure TfrmOpcoesExcelPedCompra.pAlimentarCds;
begin
  pAdicionarCampo('PCD_CODITE', 'Cód. Item', 'CÓDIGO', True);
  pAdicionarCampo('PCD_DESITE', 'Descricao', 'DESCRIÇÃO', True);
  pAdicionarCampo('MAR_DESMAR', 'Marca', 'MARCA', True);
  pAdicionarCampo('ITE_CODFAB', 'Cód. Fábrica', 'CÓD. FÁBRICA');
  pAdicionarCampo('ITE_LOCFIS', 'Loc. Física', 'LOC. FISICA');
  pAdicionarCampo('ITE_CODBAR', 'Cód. Barras', 'CÓD. BARRAS');
  pAdicionarCampo('ITE_REFERE', 'Referência', 'REFERÊNCIA');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'UNID.', True);
  pAdicionarCampo('QTDITE', 'Quantidade', 'QTDE.', True);
  pAdicionarCampo('UNITAR', 'Preço Un.', 'PREÇO UNIT.', False);
  pAdicionarCampo('PCD_DESUNI', '% Desconto 1', '% DESCONTO 1');
  pAdicionarCampo('PCD_DESUN2', '% Desconto 2', '% DESCONTO 2');
  pAdicionarCampo('PCD_DESUN3', '% Desconto 3', '% DESCONTO 3');
  pAdicionarCampo('PCD_DESUN4', '% Desconto 4', '% DESCONTO 4');
  pAdicionarCampo('PCD_DESUN5', '% Desconto 5', '% DESCONTO 5');
  pAdicionarCampo('PCD_DESUN6', '% Desconto 6', '% DESCONTO 6');
  pAdicionarCampo('UNILIQ', 'Preço Un. Liq','UNIT. LÍQUIDO');
  pAdicionarCampo('TOTITE', 'Total Item', 'PREÇO TOTAL');
  pAdicionarCampo('PCD_PERIPI', '% IPI', '% IPI');
  pAdicionarCampo('TOTIPI', 'Vlr IPI', 'VR. IPI');

  If fSomarNovosImpostosDaReformaAoValorContabil Then
  Begin
    pAdicionarCampo('PCD_ALQCBS', '% CBS', '% CBS');
    pAdicionarCampo('PCD_VALCBS', 'Vlr CBS', 'VR. CBS');
    pAdicionarCampo('PCD_ALQIBS', '% IBS', '% IBS');
    pAdicionarCampo('PCD_VALIBS', 'Vlr IBS', 'VR. IBS');
    pAdicionarCampo('PCD_ALQ_IS', '% IS', '% IS');
    pAdicionarCampo('PCD_VAL_IS', 'Vlr IS', 'VR. IS');
  End;
  pAdicionarCampo('ITE_DTAULT', 'Última compra', 'ULT. COMPRA');
  pAdicionarCampo('ITE_CONMED', 'Consumo médio', 'CONS. MÉDIO');
  pAdicionarCampo('ITE_SALDOS', 'Saldo disp.', 'SALDO DISP.');
  pAdicionarCampo('PCG_TIPFRE', 'Frete', 'FRETE');
  pAdicionarCampo('TOTSUB', 'ICMS ST', 'ICMS ST');
  pAdicionarCampo('SUBFCP', 'ICMS ST FCP', 'ICMS ST FCP');

  If fCfgSis('DARROR', varBoolean) Then
    pAdicionarCampo('TOTDAR', 'Total DARE', 'VALOR DARE');

  If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
  Begin
    pAdicionarCampo('DESPIS', 'Desconto PIS/COFINS', 'DESCONTO PIS/COFINS');
    pAdicionarCampo('ICMDES', 'ICMS Desonerado', 'ICMS DESONERADO');
  End;

  pAdicionarCampo('ABF_IVA_ST', 'IVA', 'IVA');

  If fCfgSis('ENTITE', VarBoolean) Then
    pAdicionarCampo('PCD_DTAENT', 'Data de entrada', 'DATA ENTREGA');

  pAdicionarCampo('OBSERV', 'Observações', 'OBSERVAÇÃO');

  pAdicionarCampo('VLTOPC', 'Valores Totais Pedido Compra', 'VALORES TOTAIS PEDIDO COMPRA');

end;

end.
