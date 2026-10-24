unit untMovimentacaoProgramadaVencimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untConsultas, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, EditFocus,
  Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni,
  untTypesSistema, StrUtils, cxCurrencyEdit, cxTextEdit;


type
  TpConsultarLoteVencimento = procedure (const intDia: Integer; objDataSet: TDataSet) of object;
  TfValidarLocalizacaoDestino = function (const strCodIte, strLocDes: String): boolean of object;
  TfTemMovimentoProgramadoEmAberto = function ( strCodIte: String): boolean of object;

  TfrmMovimentacaoProgramadaVencimento = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    lblDigita: TLabel;
    edtDia: TEditFocus;
    cxgItens: TcxGridCitel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensNUMLOT: TStringField;
    cdsItensLOCDES: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensDESITE: TStringField;
    cdsItensSALDOS: TFloatField;
    cdsItensLOCFIS: TStringField;
    cdsItensDIAVAL: TStringField;
    cdsItensDESMAR: TStringField;
    cdsItensSIGUNI: TStringField;
    dtsGrid: TDataSource;
    cxgItensViewCODITE: TcxGridDBColumn;
    cxgItensViewDESITE: TcxGridDBColumn;
    cxgItensViewDESMAR: TcxGridDBColumn;
    cxgItensViewSIGUNI: TcxGridDBColumn;
    cxgItensViewLOCORI: TcxGridDBColumn;
    cxgItensViewLOCFIS: TcxGridDBColumn;
    cxgItensViewDTAVAL: TcxGridDBColumn;
    cxgItensViewDIAVAL: TcxGridDBColumn;
    cxgItensViewSALDOS: TcxGridDBColumn;
    cxgItensViewLOCDES: TcxGridDBColumn;
    cxgItensViewQTDITE: TcxGridDBColumn;
    btnConsultar: TBitBtnLocked;
    cdsItensDTAVAL: TDateField;
    cdsItensAUTINC: TStringField;
    cdsItensCRITIC: TStringField;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgItensViewQTDITEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensViewLOCDESPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    FpConsultarLoteVencimento: TpConsultarLoteVencimento;
    FfValidarLocalizacaoDestino: TfValidarLocalizacaoDestino;
    FfTemMovimentoProgramadoEmAberto : TfTemMovimentoProgramadoEmAberto;
    function fValidarItens: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objDataSet: TDataSet;
    function fTemMovimentoProgramadoEmAberto(fFuncao: TfTemMovimentoProgramadoEmAberto): TfrmMovimentacaoProgramadaVencimento;
    function fValidarLocalizacaoDestino(fFuncao : TfValidarLocalizacaoDestino): TfrmMovimentacaoProgramadaVencimento;
    function pConsultarLoteVencimento(fFuncao : TpConsultarLoteVencimento): TfrmMovimentacaoProgramadaVencimento;
  end;

var
  frmMovimentacaoProgramadaVencimento: TfrmMovimentacaoProgramadaVencimento;

implementation

{$R *.dfm}

procedure TfrmMovimentacaoProgramadaVencimento.btnConsultarClick(Sender: TObject);
begin
  inherited;
  cdsItens.EmptyDataSet;
  if Assigned(fpConsultarLoteVencimento) then
    FpConsultarLoteVencimento(StrToIntDef(edtDia.Text,-1), cdsItens);
  if cdsItens.IsEmpty then
    pMensagemOK('Atenção!' + #13 +
             'Não existem produtos que irão vencer dentro dos dias informados.');
end;

procedure TfrmMovimentacaoProgramadaVencimento.cxgItensViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  arrSel: TConsultasArray;
  strFieldName: String;
  strCodIte: String;
begin
  inherited;
  If(Not cdsItens.IsEmpty) And
    (Assigned(AItem)) And
    (AItem is TcxGridDBColumn)
  Then
  Begin
    strFieldName := (AItem as TcxGridDBColumn).DataBinding.FieldName;
    strCodIte :=  VarToStrDef(AItem.GridView.Items[0].EditValue,'');
    case AnsiIndexStr(strFieldName,['LOCDES']) Of
      0:
      Begin
        If (fPesqLocFisica(Self, nil, Nil, Nil, Key, arrSel)) Then
          AItem.EditValue := arrSel[0].strCodigo;
      End;
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaVencimento.cxgItensViewLOCDESPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  strCodIte: String;
begin
  inherited;
  strCodIte := cdsItensCODITE.AsString;
  If (Not fEmptyStr(DisplayValue)) Then
  Begin
    If (fEmptyStr(fRetNomLocFisica(DisplayValue))) Then
    Begin
      pMensagemOk('Localização fisica não encontrada!');
      ErrorText := '';
      Error := true;
    End

    Else If FfValidarLocalizacaoDestino(strCodIte,DisplayValue) Then
    Begin
      If (FfTemMovimentoProgramadoEmAberto(strCodIte))Then
      Begin
        pMensagemOk('Atenção! Este item possui uma movimentação programada em aberto' +
          ' e sendo assim, não é possível gerar uma nova até que a movimentação anterior seja realizada!');
        ErrorText := '';
        Error := true;
      End;
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaVencimento.cxgItensViewQTDITEPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If 0 = cdsItensSALDOS.AsCurrency Then
  Begin
    pMensagemOK('Atenção!' + #13 + 'No lote de origem é permitido informar somente lotes que tenham saldo.');
    ErrorText := '';
    Error := true;
  End
  Else
  If fStrToFloat(DisplayValue)  > cdsItensSALDOS.AsCurrency Then
  Begin
    pMensagemOK('Atenção!' + #13 + 'A quantidade transferida deve ser menor ou igual ao saldo disponível!');
    ErrorText := '';
    Error := true;
  End;
end;

procedure TfrmMovimentacaoProgramadaVencimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Not fValidarItens) And (modalresult <> mrcancel) then
    Action := TCloseAction.caNone;
end;

procedure TfrmMovimentacaoProgramadaVencimento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  WindowState := wsMaximized;
end;

function TfrmMovimentacaoProgramadaVencimento.fTemMovimentoProgramadoEmAberto(
  fFuncao: TfTemMovimentoProgramadoEmAberto): TfrmMovimentacaoProgramadaVencimento;
begin
  Result := Self;
  FfTemMovimentoProgramadoEmAberto := fFuncao;
end;

function TfrmMovimentacaoProgramadaVencimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = cxgItens) Then
      result := fValidarItens;
  End;
end;

function TfrmMovimentacaoProgramadaVencimento.fValidarItens: Boolean;
Var
  intColuna: Integer;
begin
  intColuna := 0;
  Result := true;
  cdsItens.First;
  while Not cdsItens.Eof do
  Begin
    cxgItensView.DataController.FocusedRecordIndex := cdsItens.RecNo -1;
    if ((cdsItensLOCDES.AsString <> '') And (cdsItensQTDITE.AsCurrency = 0)) Then
    Begin
      pMensagemOK('Atenção!' + #13 +
         'Não foi informado a quantidade.');
      intColuna := 10;
      Result := false;
    End
    Else
    if ((cdsItensLOCDES.AsString = '') And (cdsItensQTDITE.AsCurrency > 0)) Then
    Begin
      pMensagemOK('Atenção!' + #13 +
         'Não foi informado a localização de destino.');
      intColuna := 9;
      Result := false;
    End;
    if Not result then
    Begin
      pSetFocus(cxgItens);
      cxgItensView.Columns[intColuna].FocusWithSelection;
      Break;
    End;
    cdsItens.Next
  End;
end;

function TfrmMovimentacaoProgramadaVencimento.fValidarLocalizacaoDestino(
  fFuncao: TfValidarLocalizacaoDestino): TfrmMovimentacaoProgramadaVencimento;
begin
  Result := Self;
  FfValidarLocalizacaoDestino := fFuncao;
end;

function TfrmMovimentacaoProgramadaVencimento.pConsultarLoteVencimento(
  fFuncao: TpConsultarLoteVencimento): TfrmMovimentacaoProgramadaVencimento;
begin
  Result := Self;
  FpConsultarLoteVencimento := fFuncao;
end;

end.
