unit untFatItensLoteSeparacaoRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, System.UITypes,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, System.Generics.Collections, untSaldoLojas,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatItensLoteSeparacaoRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    Label2: TLabel;
    edtDescri: TEditFocus;
    Label3: TLabel;
    edtQtdIte: TEditFocus;
    btnAdicionaItem: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnMarcaDesmarca: TBitBtnLocked;
    dbgItens: TcxGrid;
    dbgItensDBView: TcxGridDBTableView;
    dbgItensDET_CODITE: TcxGridDBColumn;
    dbgItensDET_DESITE: TcxGridDBColumn;
    dbgItensDET_NUMLOT: TcxGridDBColumn;
    dbgItensDET_QTDITE: TcxGridDBColumn;
    dbgItensDET_QTDSEP: TcxGridDBColumn;
    dbgItensDET_PESSEL: TcxGridDBColumn;
    dbgItensDET_PESTOT: TcxGridDBColumn;
    dbgItenslevel: TcxGridLevel;
    dbgItensDET_UNIDAD: TcxGridDBColumn;
    dtsItens: TDataSource;
    pnlRodape: TPanel;
    lbl2: TLabel;
    edtTotPes: TEditFocus;
    edtSelPes: TEditFocus;
    Label4: TLabel;
    dbgItensDET_SALDIS: TcxGridDBColumn;
    lblSalDis: TLabel;
    shpSalDis: TShape;
    btnLote: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAdicionaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgItensDBViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnLoteClick(Sender: TObject);
  private
    { Private declarations }
    blnMarca : Boolean;
    dicQtdAnt: TDictionary<String,Double>;

    procedure pAtualizarCamposPeso;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAtualizaSaldoDisponivel;
    function fItemTemLote(strCodIte: string): Boolean;
  public
    { Public declarations }
    strLetMar: String;
  end;

var
  frmFatItensLoteSeparacaoRomaneio: TfrmFatItensLoteSeparacaoRomaneio;

implementation

uses  untfuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmFatItensLoteSeparacaoRomaneio.dbgItensDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  fltSalDis: Double;
  fltQtdSep: Double;
begin
  inherited;
  fltSaldis := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgItensDET_SALDIS.Index];
  fltQtdSep := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgItensDET_QTDSEP.Index];
  if fltSaldis < fltQtdSep then
  begin
    ACanvas.Brush.Color := shpSalDis.Brush.Color;
    ACanvas.Font.Color := clBlue;
  end;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.dbgItensDBViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pnlCabecalho.Enabled := True;
    pSetFocus(edtQtdIte);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

function TfrmFatItensLoteSeparacaoRomaneio.fItemTemLote(
  strCodIte: string): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE'], [strCodIte], False) > 0;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.pAtualizaDados(DataSet: TDataSet);
begin

  edtCodIte.Text := dtsItens.DataSet.FieldByName('CODITE').AsString;
  edtDescri.Text := dtsItens.DataSet.FieldByName('DESCRI').AsString;
  edtQtdIte.Text := FloatToStrF(dtsItens.DataSet.FieldByName('QTDSEP').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger));
  btnLote.Visible := fItemTemLote(dtsItens.DataSet.FieldByName('CODITE').AsString);
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.pAtualizarCamposPeso;
Var
  intRecNo: Integer;
  fltTotPes: Double;
  fltSelPes: Double;
begin
  fltTotPes := 0;
  fltSelPes := 0;

  Try
    dtsItens.DataSet.DisableControls;

    If dtsItens.DataSet.IsEmpty Then
      Exit;

    intRecNo := dtsItens.DataSet.RecNo;

    dtsItens.DataSet.First;
    While (Not dtsItens.DataSet.Eof) Do
    Begin
      fltTotPes := fltTotPes + dtsItens.DataSet.FieldByName('PESTOT').AsFloat;
      fltSelPes := fltSelPes + dtsItens.DataSet.FieldByName('PESSEL').AsFloat;
      dtsItens.DataSet.Next;
    End;

    dtsItens.DataSet.RecNo := intRecNo;

  Finally
    edtTotPes.Text := FormatFloat('#,##0.00', fltTotPes);
    edtSelPes.Text := FormatFloat('#,##0.00', fltSelPes);
    dtsItens.DataSet.EnableControls;
  End;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.pAtualizaSaldoDisponivel;
var
  fltSaldos, fltCnvML, fltSalML: Double;
  recSaldos, recSaldosML: TRecSaldos;
  objSalLoj: TSaldoLojas;
begin
  objSalLoj := TSaldoLojas.Create(Self);
  dtsItens.DataSet.DisableControls;

  try
    dtsItens.DataSet.First;

    while not dtsItens.DataSet.Eof do
    begin
      pBuscaInfSaldos(fltSaldos, fltCnvML, fltSalML, dtsItens.DataSet.FieldByName('CODITE').AsString, dtsItens.DataSet.FieldByName('CODEMP').AsString);

      if fltCnvML > 0 then
      begin
        fltSaldos := fltSaldos + fltSalML;
      end;

      objSalLoj.pCalculaSaldos(Nil,
                               recSaldos, recSaldosML,
                               fltSaldos, VS_strCodEmp, dtsItens.DataSet.FieldByName('CODEMP').AsString,
                               dtsItens.DataSet.FieldByName('CODITE').AsString, fltCnvML,
                               fCfgSis('ENTFUT', varBoolean), False, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));

      dtsItens.DataSet.Edit;
      dtsItens.DataSet.FieldByName('SALDIS').AsFloat := recSaldos.fltSalDis;
      dtsItens.DataSet.Post;

      dtsItens.DataSet.Next;
    end;

    dtsItens.DataSet.First;
  finally
    dtsItens.DataSet.EnableControls;
    FreeAndNil(objSalLoj);
  end;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  dicQtdAnt := TDictionary<String,Double>.Create;

  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;

  While (Not dtsItens.DataSet.Eof) Do
  Begin
    dicQtdAnt.AddOrSetValue(dtsItens.DataSet.FieldByName('AUTINC').AsString,
                            dtsItens.DataSet.FieldByName('QTDSEP').AsFloat);
    dtsItens.DataSet.Next;
  End;

  dtsItens.DataSet.First;

  dtsItens.DataSet.EnableControls;

  dtsItens.DataSet.AfterScroll := pAtualizaDados;
  pAtualizaDados(Nil);
  pAtualizarCamposPeso;
  pAtualizaSaldoDisponivel;

  If fCfgSis('CTLEST') = '2' Then
    btnLote.Caption := StringReplace(btnLote.Caption, 'Lotes', 'Armazéns', []);

  dbgItensDBView.ApplyBestFit();

  strLetMar := '';
  blnMarca  := False;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgItens);
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dtsItens.DataSet.AfterScroll := Nil;
  inherited;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  btnLote.Visible := False;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
  pAtualizaDados(Nil);
  pAtualizarCamposPeso;
  pnlCabecalho.Enabled := False;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.btnAdicionaItemClick(Sender: TObject);
  Var
    fltMultiplo: Double;
    strOpcao   : String;
begin
  inherited;

  If (fStrToFloat(edtQtdIte.Text) < 0.0) Then
  Begin
    fMensagem('', 'A quantidade de entrega deve ser maior ou igual a Zero!', ['&Ok']);
    pSetFocus(edtQtdIte);
    Exit;
  End;

  If (dtsItens.DataSet.FieldByName('QTDRES').AsFloat < fStrToFloat(edtQtdIte.Text)) Then
  Begin
    fMensagem('', 'A quantidade deve ser menor ou igual a quantidade restante para separar!', ['&Ok']);
    pSetFocus(edtQtdIte);
    Exit;
  End;

  strOpcao := fCfgSis('DIVMVR');

  If strOpcao <> 'N' Then
  Begin
    If Not fMultiploValido(dtsItens.DataSet.FieldByName('CODITE').AsString,
                           fStrToFloat(edtQtdIte.Text),
                           fltMultiplo) Then
    Begin
      If strOpcao = 'A' Then
      Begin
        fMensagem('', 'A quantidade de entrega deste produto'+ #13#10 +'diverge de seu múltiplo de venda ( ' +
                      FloatToStrF(fltMultiplo, ffNumber, 12, 2) + ' )!', ['&Ok']);
      End
      Else
      Begin
        fMensagem('', 'A quantidade de entrega deve ser múltiplo de ' + FloatToStrF(fltMultiplo, ffNumber, 12, 2) + '!', ['&Ok']);
        pSetFocus(edtQtdIte);
        Exit;
      End;
    End;
  End;

  dtsItens.DataSet.Edit;
  dtsItens.DataSet.FieldByName('QTDSEP').AsFloat := fStrToFloat(edtQtdIte.Text);
  dtsItens.DataSet.FieldByName('PESSEL').AsFloat := dtsItens.DataSet.FieldByName('PESOIT').AsFloat * dtsItens.DataSet.FieldByName('QTDSEP').AsFloat;
  dtsItens.DataSet.Post;

  btnCancelar.Click;

  pAtualizarCamposPeso;
end;

{*******************************************}
{* CONFIRMA OS ITENS. CASO MARQUE TODOS OS *}
{* ITENS COM ZERO, TEM O MESMO EFEITO DE   *}
{* DESMARCAR O DOCUMENTO.                  *}
{****************************************MV*}
procedure TfrmFatItensLoteSeparacaoRomaneio.btnConfirmaClick(Sender: TObject);
Var
  intQtdSel: Integer;
begin
  inherited;
  If (fMensagem('', 'Confirma itens?', ['&Sim', '&Não']) = 2) Then
    Exit;

  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;

  strLetMar := 'M';
  intQtdSel := 0;

  While (Not dtsItens.DataSet.Eof) Do
  Begin
    If dtsItens.DataSet.FieldByName('QTDSEP').AsFloat > 0 Then
      Inc(intQtdSel);

    If (dtsItens.DataSet.FieldByName('QTDSEP').AsFloat <> dtsItens.DataSet.FieldByName('QTDRES').AsFloat) Then
    Begin
      strLetMar := 'P';
    End;

    If dtsItens.DataSet.FieldByName('QJASEP').AsFloat > 0 Then
    Begin
      strLetMar := 'P';
    End;

    dtsItens.DataSet.Next;
  End;

  If (intQtdSel <= 0.0) Then
    strLetMar := 'D';

  dtsItens.DataSet.EnableControls;
  Close;
  ModalResult := mrOk;

end;

procedure TfrmFatItensLoteSeparacaoRomaneio.btnLoteClick(Sender: TObject);
begin
  inherited;
  If Not btnLote.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('CPLOTI', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(320, 12128, [12129,12130,12131,12132],
                      ['CODITE', 'FILLOJ'],
                      [dtsItens.DataSet.FieldByName('CODITE').AsString, 'S'],
                      Sender,
                      ['CODITE'],
                      True);
  End;
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.btnSairClick(Sender: TObject);
begin
  If (fMensagem('', 'Abandona itens?', ['&Sim', '&Não']) = 2) Then
    Exit;

  inherited;

  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;

  While (Not dtsItens.DataSet.Eof) Do
  Begin
    dtsItens.DataSet.Edit;

    If dicQtdAnt.ContainsKey(dtsItens.DataSet.FieldByName('AUTINC').AsString) Then
    Begin
      dtsItens.DataSet.FieldByName('QTDSEP').AsFloat := dicQtdAnt[dtsItens.DataSet.FieldByName('AUTINC').AsString];
      dtsItens.DataSet.FieldByName('PESSEL').AsFloat := dtsItens.DataSet.FieldByName('PESOIT').AsFloat * dtsItens.DataSet.FieldByName('QTDSEP').AsFloat;
    End;

    dtsItens.DataSet.Post;
    dtsItens.DataSet.Next;
  End;
  dtsItens.DataSet.EnableControls;

  ModalResult := mrCancel;
  strLetMar := '';
end;

procedure TfrmFatItensLoteSeparacaoRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

  If (Key = VK_F8) Then
  Begin
    btnMarcaDesmarca.Click;
  End;

  If (Shift = [ssAlt]) Then
  Begin
    If (Key = VK_F6) Then
    Begin
      btnLote.Click;
    End;
  End;

end;

procedure TfrmFatItensLoteSeparacaoRomaneio.btnMarcaDesmarcaClick(Sender: TObject);
begin
  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;

  While (Not dtsItens.DataSet.Eof) Do
  Begin
    dtsItens.DataSet.Edit;

    If blnMarca Then
      dtsItens.DataSet.FieldByName('QTDSEP').AsFloat := dtsItens.DataSet.FieldByName('QTDRES').AsFloat
    Else
      dtsItens.DataSet.FieldByName('QTDSEP').AsFloat := 0;

    dtsItens.DataSet.FieldByName('PESSEL').AsFloat := dtsItens.DataSet.FieldByName('PESOIT').AsFloat * dtsItens.DataSet.FieldByName('QTDSEP').AsFloat;

    dtsItens.DataSet.Post;
    dtsItens.DataSet.Next;
  End;

  blnMarca := Not blnMarca;
  dtsItens.DataSet.First;

  dtsItens.DataSet.EnableControls;
  pAtualizaDados(Nil);
  pAtualizarCamposPeso;
end;

end.

