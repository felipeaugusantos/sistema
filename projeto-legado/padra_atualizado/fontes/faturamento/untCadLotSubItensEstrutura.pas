unit untCadLotSubItensEstrutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxDBLookupComboBox, MemDS, DBAccess, Uni, untFuncoesSimples;

type
  TfrmCadLotSubItensEstrutura = class(TfrmPaiConfirma)
    cxgLotes: TcxGridCitel;
    cxgLotesTV: TcxGridDBTableViewCitel;
    cxgLotesLevel1: TcxGridLevel;
    TLotes: TUniClientDataSet;
    DSLotes: TDataSource;
    TLotesLOT_CODITE: TStringField;
    TLotesLOT_DESITE: TStringField;
    TLotesLOT_NUMLOT: TStringField;
    cxgLotesTVLOT_CODITE: TcxGridDBColumn;
    cxgLotesTVLOT_DESITE: TcxGridDBColumn;
    cxgLotesTVLOT_NUMLOT: TcxGridDBColumn;
    TLotesLOT_SALDIS: TFloatField;
    TLotesLOT_CODEMP: TStringField;
    TLotesLOT_CARREG: TStringField;
    TLotesLOT_QTD: TFloatField;
    TLotesLOT_QTDPED: TFloatField;
    cxgLotesTVLOT_QTDPED: TcxGridDBColumn;
    cxgLotesTVLOT_QTD: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure TLotesBeforePost(DataSet: TDataSet);
    procedure cxgLotesTVLOT_NUMLOTPropertiesChange(Sender: TObject);
    procedure cxgLotesTVKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cxgLotesTVEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnRetornandoLote: Boolean;
    function fEhEntregaFutura: Boolean;
    function fLotePermitido: Boolean;
  public
    intIdxEntRet,
    intIdxTipEnt: Integer;
    strOpcDoc: string;

    procedure fInserirItem(strCodItem, strCodEmp : String; blnLoteADefinir : Boolean = False; strLotePrincipal : String = ''; fltQtd: double = 0; fltQtdPed: double = 0);
    function fExisteLoteParaInformar : Boolean;
    function fRetLotInformado(strCodItem : String) : String;
  end;

implementation

uses
  untCadLote, untTypesSistema, untConsultas, untConstantes;

{$R *.dfm}

{ TfrmCadLotSubItensEstrutura }

procedure TfrmCadLotSubItensEstrutura.btnConfirmaClick(Sender: TObject);
begin
  TLotes.DisableControls;
  Try

    TLotes.First;
    While Not TLotes.Eof Do
    Begin

      If fEmptyStr(TLotesLOT_NUMLOT.AsString) Then
      Begin
        fMensagem('Aviso', 'É necessário informar o lote de todos os produtos!', ['&OK']);
        ModalResult := mrRetry;
        Break;
      End;

      TLotes.Next;

    End;

  Finally
    TLotes.EnableControls;
  End;
end;

procedure TfrmCadLotSubItensEstrutura.cxgLotesTVEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  cxgLotesTVKeyPress(Sender, Key);
end;

procedure TfrmCadLotSubItensEstrutura.cxgLotesTVKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
  qryLote: TUniQuery;
begin
  inherited;
  Key := UpCase(key);

  If Not cxgLotesTVLOT_NUMLOT.Focused Then
    Exit;

  If Not fEntraCons(Key) Then
    Exit;

  qryLote := fCriaQuery();
  Try
    utcRegistros.fRetRegistro(Self.Name + 'CADLOT');
    utcRegistros.pLimparCampos;

    If fPesqLoteFat(Self,
                    nil,
                    fCfgSis('DECUNI'),
                    TLotesLOT_CODITE.AsString,
                    False,
                    False,
                    qryLote,
                    Key,
                    arrSel,
                    TLotesLOT_CODEMP.AsString) Then
    Begin
      If TLotes.State <> dsEdit Then
        TLotes.Edit;

      TLotesLOT_NUMLOT.AsString := qryLote.FieldByName('LOT_NUMLOT').AsString;
      TLotes.Post;
    End;
  Finally
    FreeAndNil(qryLote);
  End;
end;

procedure TfrmCadLotSubItensEstrutura.cxgLotesTVLOT_NUMLOTPropertiesChange(
  Sender: TObject);
begin
  inherited;
  If TLotes.State = dsEdit Then
    TLotes.Post;
end;

function TfrmCadLotSubItensEstrutura.fExisteLoteParaInformar: Boolean;
begin
  Result := Not TLotes.IsEmpty;
end;

procedure TfrmCadLotSubItensEstrutura.fInserirItem(strCodItem, strCodEmp: String; blnLoteADefinir : Boolean = False; strLotePrincipal : String = ''; fltQtd: double = 0; fltQtdPed: double = 0);
begin
  If Not fEmptyStr(strCodItem) Then
  Begin
    TLotes.Append;
    TLotesLOT_CODITE.AsString := strCodItem;
    TLotesLOT_CODEMP.AsString := strCodEmp;
    TLotesLOT_DESITE.AsString := fRetNomProduto(strCodItem);

    if Not fEmptyStr(strLotePrincipal) then
      TLotesLOT_NUMLOT.AsString := strLotePrincipal
    else
      TLotesLOT_NUMLOT.AsString := IIF(blnLoteADefinir, 'A DEFINIR', '');

      TLotesLOT_QTD.AsFloat:= fltQtd;
      TLotesLOT_QTDPED.AsFloat:= fltQtdPed;

    TLotes.Post;
  End;
end;

procedure TfrmCadLotSubItensEstrutura.FormActivate(Sender: TObject);
begin
  inherited;
  TLotes.First;
  pSetFocus(cxgLotes);
  TLotesLOT_NUMLOT.FocusControl;
end;

procedure TfrmCadLotSubItensEstrutura.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(TLotesLOT_CODITE);
  TLotes.CreateDataSet;
  TLotes.EmptyDataSet;
  TLotesLOT_SALDIS.DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  intIdxEntRet := -1;
  intIdxTipEnt := -1;
  blnRetornandoLote := False;
  strOpcDoc:= '';
end;

procedure TfrmCadLotSubItensEstrutura.FormShow(Sender: TObject);
begin
  inherited;
  if strOpcDoc = 'PD' then
    cxgLotesTVLOT_QTDPED.Caption:= 'Quantidade Pedido'
  else if strOpcDoc = 'OR' then
    cxgLotesTVLOT_QTDPED.Caption:= 'Quantidade Orçamento';
end;

function TfrmCadLotSubItensEstrutura.fRetLotInformado(strCodItem: String): String;
begin
  If Not fEmptyStr(strCodItem) Then
  Begin
    blnRetornandoLote := True;
    Try
      TLotes.Filtered := False;
      TLotes.Filter   := '(LOT_CODITE = ' + QuotedStr(strCodItem)+')  AND (LOT_CARREG <> ''S'')';
      TLotes.Filtered := True;

      If Not TLotes.IsEmpty Then
      Begin
        Result := TLotesLOT_NUMLOT.AsString;
        TLotes.Edit;
        TLotesLOT_CARREG.AsString := 'S';
        TLotes.Post;
      End;
    Finally
      TLotes.Filtered := False;
      blnRetornandoLote := False;
    End;
  End;
end;

function TfrmCadLotSubItensEstrutura.fEhEntregaFutura: Boolean;
begin
  Result := False;

  If (intIdxEntRet = IDX_ENTREGA)  Then
  Begin
    If (intIdxTipEnt = IDX_ENTREGA_FUTURA) Then
    Begin
      Result := True;
    End;
  End;
end;

function TfrmCadLotSubItensEstrutura.fLotePermitido: Boolean;
begin
  Result := True;

  If (fCfgSis('ENTDEF', varBoolean)) Then
  Begin
    If (fEhEntregaFutura) Then
    Begin
      Result := (TLotesLOT_NUMLOT.AsString = 'A DEFINIR');
    End;
  End;
end;

procedure TfrmCadLotSubItensEstrutura.TLotesBeforePost(DataSet: TDataSet);
begin
  inherited;

  If (blnRetornandoLote) Then
    Exit;
    
  If (Not fEmptyStr(TLotesLOT_NUMLOT.AsString)) Then
  Begin
    If (Not fExisteLote(TLotesLOT_NUMLOT.AsString, TLotesLOT_CODITE.AsString, TLotesLOT_CODEMP.AsString, True)) Then
    Begin
      pMensagemOk('Lote informado não existe ou não está ativo!');
      TLotesLOT_NUMLOT.Clear;
    End

    Else If (Not fLotePermitido) Then
    Begin
      pMensagemOK('Lote informado é inválido quando se trata de Entrega Futura, utilizar "A DEFINIR"!');
      TLotesLOT_NUMLOT.Clear;
    End;
  End;

  TLotesLOT_SALDIS.AsFloat :=
    fRetornaSaldoDisponivel(TLotesLOT_CODITE.AsString,
                            False,
                            True,
                            TLotesLOT_NUMLOT.AsString,
                            True,
                            TLotesLOT_CODEMP.AsString);
end;

end.
