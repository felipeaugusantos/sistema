unit untGarantiaEnvFornecedorSelNE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, DBGridCitel, DBGrids, untZClient, ImgList, Data.DB,
  System.ImageList, frxClass, frxExportCSVTestabilidade, Vcl.Grids, EditFocus, untTControladorEnvioFornecedor,untTypesSistema;

type
  TfrmGarantiaEnvFornecedorSelNE = class(TfrmPaiConfirma)
    dbgDados: TDBGridCitel;
    imgLista: TImageList;
    pnlInfoGarantia: TPanel;
    edtNumGar: TEditFocus;
    edtQtdIte: TEditFocus;
    edtTotDoc: TEditFocus;
    edtSemDoc: TEditFocus;
    lblNumGar: TLabel;
    Label1: TLabel;
    lblTotlDoc: TLabel;
    lblSemDocumento: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    intCorZeb : Integer;
    FOnNewRecordOld: TDataSetNotifyEvent;
//    procedure pMarcar(pblnMarcar: Boolean);
//    procedure pMarcarDesmarcar;
    procedure DefinirTamanhoTela;
    procedure DefinirLarguraCamposGrid;
    function SomatorioLarguraColunas(grid: TDBgridCitel): Integer;
    function IndiceColunas(grid: TDBgridCitel; Const NomeColuna: String): Integer;
    procedure pcdsNewRecord(Sender: TDataSet);
    procedure pcdsBeforePost(Sender: TDataSet);
  public
    objControladorEnvioFornecedor: TControladorEnvioFornecedor;
    enuTipoEnvioFornecedorGarantia: TTipoEnvioFornecedorGarantia;
    cdsDados : TZClient;
    procedure pAtualizarResumos(const pfltQtdDoc, pfltQtdSem: Double);
    procedure pAtualizarDadosGarantia(const pstrNumGar: String; const pfltQtdIte: Double);
  end;

var
  frmGarantiaEnvFornecedorSelNE: TfrmGarantiaEnvFornecedorSelNE;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmGarantiaEnvFornecedorSelNE.btnConfirmaClick(Sender: TObject);
Var
  lblnContinuar: Boolean;
begin
  lblnContinuar := True;
  Try
    if objControladorEnvioFornecedor.GarantiaItemSelecionado.fTotalSemDocumento = 0 then
      Exit;

    if enuTipoEnvioFornecedorGarantia <> tefDevolucao then
      Exit;

    if Not objControladorEnvioFornecedor.blnGFSDoc then
    begin
      pMensagemOk('A quantidade a devolver com documento informado é insuficiente para atender a quantidade a enviar para fornecedor!');
      lblnContinuar := False;
    end;
  Finally
    if lblnContinuar then
      ModalResult := mrOk;
  End;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if cdsDados.FieldByName('QTDITE').AsInteger > 0 then
  begin
    dbgDados.Canvas.Brush.Color := clBlue;
    dbgDados.Canvas.Font.Color := clWhite;
    dbgDados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else
    inherited;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if cdsDados.State = dsEdit then
    begin
      Key := 0;
      Try
        cdsDados.Post;
      Except
        on E: EAbort do
          cdsDados.Cancel;
      End;
    end;
  end
  else If key = VK_ESCAPE then
  begin
    if cdsDados.State = dsEdit then
    begin
      Key := 0;
      cdsDados.Cancel;
    end;
  end;
  inherited;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.DefinirLarguraCamposGrid;
Const
  LARGURA_SCROLLBARVERTICAL: Integer = 35;
Var
  intAcumuladoLarguraColunas: Integer;
  intColuna: Integer;
  intDiferenca: Integer;
begin
  intAcumuladoLarguraColunas := SomatorioLarguraColunas(dbgDados);
  intColuna := IndiceColunas(dbgDados,'ITE_DESITE');
  if intColuna >= 0 then
  begin
    intDiferenca := (dbgDados.Width - (LARGURA_SCROLLBARVERTICAL + intAcumuladoLarguraColunas));
    dbgDados.Columns[intColuna].Width := dbgDados.Columns[intColuna].Width + intDiferenca;
  end;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.DefinirTamanhoTela;
Var
  intLarguraPadraoForm: Integer;
  intLarguraSugerida: Integer;
begin
  //DEFININDO A LARGURA DO FORM PARA 60% DO TAMANHO DA TELA.
  intLarguraPadraoForm := Self.Width;
  intLarguraSugerida := Trunc(Screen.Width * 0.60);
  if intLarguraSugerida > intLarguraPadraoForm then
  begin
    self.Width := intLarguraSugerida;
  end;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.FormCreate(Sender: TObject);
begin
  inherited;
  intCorZeb := fCfgSis('CORZEB', varInteger);
  DefinirTamanhoTela;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.FormDestroy(Sender: TObject);
begin
  cdsDados.OnNewRecord := FOnNewRecordOld;
  objControladorEnvioFornecedor := Nil;
  inherited;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF (Key = VK_ESCAPE) And (ActiveControl = dbgDados) And (cdsDados.State = dsEdit) Then
  begin
    dbgDados.OnKeyDown(Sender, Key, Shift);
    Exit;
  end;

  inherited;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.FormResize(Sender: TObject);
begin
  inherited;
  DefinirLarguraCamposGrid;
end;

procedure TfrmGarantiaEnvFornecedorSelNE.FormShow(Sender: TObject);
begin
  inherited;
  FOnNewRecordOld := cdsDados.OnNewRecord;
  cdsDados.First;
  cdsDados.OnNewRecord := pcdsNewRecord;
  cdsDados.BeforePost := pcdsBeforePost;
  dbgDados.DataSource := cdsDados.dtsSource;
  pAtualizarResumos(objControladorEnvioFornecedor.GarantiaItemSelecionado.fTotalDocumento,
                    objControladorEnvioFornecedor.GarantiaItemSelecionado.fTotalSemDocumento);
  pSetFocus(dbgDados);

end;

procedure TfrmGarantiaEnvFornecedorSelNE.pAtualizarDadosGarantia(
  const pstrNumGar: String; const pfltQtdIte: Double);
begin
  edtNumGar.Text := pstrNumGar;
  edtQtdIte.Text := FloatToStrF(pfltQtdIte, ffFixed, 12, 2);
  pAtualizarResumos(0,0);
end;

procedure TfrmGarantiaEnvFornecedorSelNE.pAtualizarResumos(const pfltQtdDoc,
  pfltQtdSem: Double);
begin
  edtSemDoc.text := FloatToStrF(pfltQtdSem, ffFixed, 12, 2);
  edtTotDoc.Text := FloatToStrF(pfltQtdDoc, ffFixed, 12, 2);
end;

procedure TfrmGarantiaEnvFornecedorSelNE.pcdsBeforePost(Sender: TDataSet);
begin
  if Assigned(objControladorEnvioFornecedor) then
  begin
    pAtualizarResumos(objControladorEnvioFornecedor.GarantiaItemSelecionado.fTotalDocumento,
                      objControladorEnvioFornecedor.GarantiaItemSelecionado.fTotalSemDocumento);
  end
  else
    pAtualizarResumos(0,0);
end;

procedure TfrmGarantiaEnvFornecedorSelNE.pcdsNewRecord(Sender: TDataSet);
begin
  Abort;
end;

function TfrmGarantiaEnvFornecedorSelNE.IndiceColunas(grid: TDBgridCitel; const NomeColuna: String): Integer;
Var
  Ret: integer;
  i: integer;
begin
  Ret := -1;
  for i := 0 to grid.Columns.Count -1 do
  begin
    if (grid.Columns[i].FieldName = NomeColuna) then
    begin
      if (Ret = -1) then
      begin
        Ret := i;
        break;
      end;
    end;
  end;
  Result := Ret;
end;

function TfrmGarantiaEnvFornecedorSelNE.SomatorioLarguraColunas(grid: TDBgridCitel): Integer;
Var
  Ret: integer;
  i: Integer;
begin
  Ret := 0;
  for i := 0 to grid.Columns.Count -1 do
  begin
    Ret :=  Ret +grid.Columns[i].Width;
  end;
  Result := Ret;
end;

end.
