unit untFatDigSepConferentePorLocal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxMaskEdit, EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, UniClientDataSet,
  Datasnap.DBClient, cxTextEdit;

type
  TfrmFatDigSepConferentePorLocal = class(TfrmPaiSimples)
    cdsSepara: TUniClientDataSet;
    cdsSeparaSEQSEP: TIntegerField;
    cdsSeparaSETOR_: TStringField;
    cdsSeparaCODSEP: TStringField;
    cdsSeparaDESSEP: TStringField;
    cdsSeparaCODCON: TStringField;
    cdsSeparaDESCON: TStringField;
    cdsSeparaCODEMB: TStringField;
    cdsSeparaDESEMB: TStringField;
    cdsSeparaOBSEXP: TStringField;
    dspSepara: TDataSource;
    lblLimparExpedido: TLabel;
    cxGrid: TcxGrid;
    cxGridDBGrid: TcxGridDBTableView;
    cxGridDBGridSETOR_: TcxGridDBColumn;
    cxGridDBGridCODSEP: TcxGridDBColumn;
    cxGridDBGridDESSEP: TcxGridDBColumn;
    cxGridDBGridCODCON: TcxGridDBColumn;
    cxGridDBGridDESCON: TcxGridDBColumn;
    cxGridDBGridCODEMB: TcxGridDBColumn;
    cxGridDBGridDESEMB: TcxGridDBColumn;
    cxGridDBGridOBSEXP: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    edtCod: TEditFocus;
    edtNom: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure cdsSeparaAfterCancel(DataSet: TDataSet);
    procedure cdsSeparaAfterPost(DataSet: TDataSet);
    procedure cdsSeparaAfterScroll(DataSet: TDataSet);
    procedure cdsSeparaBeforeEdit(DataSet: TDataSet);
    procedure cdsSeparaBeforePost(DataSet: TDataSet);
    procedure cxGridDBGridEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBGridEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxGridDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridEnter(Sender: TObject);
  private
    function fRetTituloColuna(strCampo: String; blnManterVisivel: Boolean=True): String;
    function fRetColunaAtiva: String;
    procedure pFocaColuna(strColuna:String);
    procedure pMudaColuna(Key: Word);
    function fValidaEditaColuna(strCampo: String): Boolean;
    procedure pProximaLinha;
    function fEhCampoPorCodigo(const strAux: String): Boolean;
    function fCampoPesquisa: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, System.StrUtils;

{$R *.dfm}

{ TfrmPaiSimples1 }

procedure TfrmFatDigSepConferentePorLocal.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigSepConferentePorLocal.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatDigSepConferentePorLocal.cdsSeparaAfterCancel(DataSet: TDataSet);
begin
  inherited;
  cxGridDBGrid.OptionsData.Editing := False;
end;

procedure TfrmFatDigSepConferentePorLocal.cdsSeparaAfterPost(DataSet: TDataSet);
begin
  inherited;

  edtCod.Text := '';
  edtNom.Text := '';

  cxGridDBGrid.OptionsData.Editing := False;
end;

procedure TfrmFatDigSepConferentePorLocal.cdsSeparaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  cxGridDBGrid.OptionsData.Editing := False;
end;

procedure TfrmFatDigSepConferentePorLocal.cdsSeparaBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  cxGridDBGrid.OptionsData.Editing := True;
end;

function TfrmFatDigSepConferentePorLocal.fEhCampoPorCodigo(const strAux: String): Boolean;
begin
  Result := False;

  If (Not fEmptyStr(strAux)) Then
    If (Pos(fRetColunaAtiva, 'CODSEP_CODEMB_') > 0) Then
       Exit(True);
end;

procedure TfrmFatDigSepConferentePorLocal.cdsSeparaBeforePost(DataSet: TDataSet);
Var
  strAux: String;
begin
  inherited;

  edtCod.Text := '';
  edtNom.Text := '';

  If Pos(fRetColunaAtiva, 'CODSEP_CODCON_CODEMB_') > 0 Then
  Begin
    strAux := cdsSepara.FieldByName(fRetColunaAtiva).AsString;

    If fEhCampoPorCodigo(strAux) Then
    Begin
      strAux := fPadL(strAux, 3, '0');
      cdsSepara.FieldByName(fRetColunaAtiva).AsString := strAux;
    End;

    edtCod.Text := strAux;

    If Not fValidaCampos(edtCod, False) Then
      Abort;
  End;
end;

procedure TfrmFatDigSepConferentePorLocal.cxGridDBGridEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  pMudaColuna(Key);
end;

function TfrmFatDigSepConferentePorLocal.fCampoPesquisa(): Boolean;
begin
  Result := True;

  if (cdsSepara.State <> dsEdit) then
    Exit(False);

  if (not Pos(fRetColunaAtiva, 'CODSEP_CODEMB_') > 0) then
    Exit(False);
end;

procedure TfrmFatDigSepConferentePorLocal.cxGridDBGridEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If fCampoPesquisa Then
  Begin
    If fPesqOperador(Self, edtCod, edtNom, qryTabela, Key, arrSel) Then
    Begin
      cdsSepara.FieldByName(fRetColunaAtiva).AsString := edtCod.Text;

      If fValidaCampos(edtCod, False) Then
        Key := #13;
    End;
  End;
end;

procedure TfrmFatDigSepConferentePorLocal.cxGridDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pMudaColuna(Key);
end;

procedure TfrmFatDigSepConferentePorLocal.cxGridEnter(Sender: TObject);
begin
  inherited;
  If (cdsSepara.State = dsEdit) Then
    cdsSepara.Post;
end;

procedure TfrmFatDigSepConferentePorLocal.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  fRetTituloColuna('OBSEXP', (VS_strTipExp = '4'));
end;

function TfrmFatDigSepConferentePorLocal.fRetColunaAtiva: String;
begin
  Result := cxGridDBGrid.Columns[cxGridDBGrid.Controller.FocusedColumnIndex].DataBinding.FieldName;
end;

function TfrmFatDigSepConferentePorLocal.fRetTituloColuna(strCampo: String;
 blnManterVisivel: Boolean): String;
begin
  Result := cxGridDBGrid.GetColumnByFieldName(strCampo).Caption;
  cxGridDBGrid.GetColumnByFieldName(strCampo).Visible := blnManterVisivel;
end;

function TfrmFatDigSepConferentePorLocal.fValidaEditaColuna(strCampo: String):Boolean;
begin
  Result := True;

  If fEmptyStr(cdsSepara.FieldByName(strCampo).AsString) Then
  Begin
    Result := False;

    Try
      pSetFocus(cxGrid);

      cdsSepara.Edit;
      pFocaColuna(strCampo);

      edtCod.Text := '';
      If Not fValidaCampos(edtCod, False) Then
      Begin
        Application.ProcessMessages;
        If Not (cdsSepara.State In [dsEdit]) Then
          cdsSepara.Edit;
      End;
    Except

    End;

  End
end;

function TfrmFatDigSepConferentePorLocal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
 strColAtu: String;
 strCodAux: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCod) And (cdsSepara.State In [dsEdit]) Then
    Begin

      strColAtu := fRetColunaAtiva;

      If Not fEmptyStr(edtCod.Text) Then
      Begin
        strCodAux := edtCod.Text;

        If Pos(strColAtu, 'CODCON_') > 0 Then
          strCodAux := fRetCodVendedor(strCodAux);

        edtNom.Text := fRetNomeOperador(strCodAux);
        cdsSepara.FieldByName('DES' + RightStr(strColAtu, 3)).AsString := edtNom.Text;

        If fEmptyStr(edtNom.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este ' + fRetTituloColuna(strColAtu) + ' não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        cdsSepara.FieldByName('DES' + RightStr(strColAtu, 3)).AsString := '';
        If Pos(strColAtu, 'CODSEP_CODCON_') > 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O código do '+fRetTituloColuna(strColAtu) + ' deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = cxGrid) Then
    Begin
      cdsSepara.First;

      While Not cdsSepara.Eof Do
      Begin
        Result := fValidaEditaColuna('CODSEP');

        If Result Then
          Result := fValidaEditaColuna('CODCON');

        If Not Result Then
          Break;

        cdsSepara.Next;
      End;
    End;
  End;


  If (Not Result) Then
    If Not (Sender = cxGrid) Then
      pSetFocus(Sender);
end;

procedure TfrmFatDigSepConferentePorLocal.pFocaColuna(strColuna: String);
begin
  If (cdsSepara.State = dsEdit) Then
    cxGridDBGrid.GetColumnByFieldName(strColuna).FocusWithSelection;
end;

procedure TfrmFatDigSepConferentePorLocal.pProximaLinha;
begin

  If (cdsSepara.RecNo < cdsSepara.RecordCount) then
  Begin
    cdsSepara.Next;

    cdsSepara.Edit;
    pFocaColuna('CODSEP');
  End
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFatDigSepConferentePorLocal.pMudaColuna(Key: Word);
begin

  If (Key = VK_RETURN) Then
  Begin

    If (cdsSepara.State <> dsEdit) Then
    Begin
      cdsSepara.Edit;
      pFocaColuna('CODSEP');
    End
    Else
    Begin
      If fRetColunaAtiva = 'CODSEP' Then
      Begin
        cdsSepara.Post;
        cdsSepara.Edit;

        pFocaColuna('CODCON');
      End

      Else If fRetColunaAtiva = 'CODCON' Then
      Begin
        cdsSepara.Post;
        cdsSepara.Edit;

        pFocaColuna('CODEMB');
      End

      Else If fRetColunaAtiva = 'CODEMB' Then
      Begin
        cdsSepara.Post;

        If (VS_strTipExp = '4') Then
        Begin
          cdsSepara.Edit;
          pFocaColuna('OBSEXP');
        End
        Else
        Begin
          pProximaLinha
        End;
      End

      Else If fRetColunaAtiva = 'OBSEXP' Then
      Begin
        cdsSepara.Post;

        pProximaLinha
      End

      Else pFocaColuna('CODSEP');

    End;

  End
  Else If (Key = VK_ESCAPE) Then
    btnCancelaDados.Click;
end;

end.
