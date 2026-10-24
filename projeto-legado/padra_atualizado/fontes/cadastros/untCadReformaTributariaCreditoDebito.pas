unit untCadReformaTributariaCreditoDebito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus, Data.DB, Uni, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, QColorLabel, cxTextEdit;

type
  TfrmCadReformaTributariaCreditoDebito = class(TfrmPai)
    pnlPrincipal: TPanel;
    pnlDebito: TPanel;
    Panel1: TPanel;
    Label17: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dbeClaFisDebitoDescr: TEditFocus;
    dbeCstDebitoDescr: TEditFocus;
    dbeTipoDebitoDescr: TEditFocus;
    btnConfirmaDebito: TBitBtnLocked;
    btnCancelaDebito: TBitBtnLocked;
    cxDebito: TcxGrid;
    cxGridDebito: TcxGridDBTableView;
    cxGridLevelDebito: TcxGridLevel;
    cxCredito: TcxGrid;
    cxGridCredito: TcxGridDBTableView;
    cxGridLevelCredito: TcxGridLevel;
    pnlCredito: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    dbeClaFisCreditoDescr: TEditFocus;
    dbeCstCreditoDescr: TEditFocus;
    dbeTipoCreditoDescr: TEditFocus;
    btnConfirmaCredito: TBitBtnLocked;
    btnCancelaCredito: TBitBtnLocked;
    dtsCredito: TDataSource;
    cdsCredito: TUniClientDataSet;
    dtsDebito: TDataSource;
    cxGridDebitoColumn1: TcxGridDBColumn;
    cxGridDebitoColumn2: TcxGridDBColumn;
    cxGridDebitoColumn3: TcxGridDBColumn;
    cxGridDebitoColumn4: TcxGridDBColumn;
    cxGridDebitoColumn5: TcxGridDBColumn;
    cxGridDebitoColumn6: TcxGridDBColumn;
    cxGridCreditoColumn1: TcxGridDBColumn;
    cxGridCreditoColumn2: TcxGridDBColumn;
    cxGridCreditoColumn3: TcxGridDBColumn;
    cxGridCreditoColumn4: TcxGridDBColumn;
    cxGridCreditoColumn5: TcxGridDBColumn;
    cxGridCreditoColumn6: TcxGridDBColumn;
    dbeTipoCredito: TEditFocus;
    dbeCstCredito: TEditFocus;
    dbeClaFisCredito: TEditFocus;
    dbeTipoDebito: TEditFocus;
    dbeCstDebito: TEditFocus;
    dbeClaFisDebito: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    cdsCreditoCCD_TIPFIN: TStringField;
    cdsCreditoCCD_TIPDES: TStringField;
    cdsCreditoCCD_CODCST: TStringField;
    cdsCreditoCCD_CSTDES: TStringField;
    cdsCreditoCCD_CLATRI: TStringField;
    cdsCreditoCCD_CLADES: TStringField;
    btnCancelar: TBitBtnLocked;
    cdsDebito: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    Label6: TLabel;
    edtDocRefCredito: TEditFocus;
    clbCreditoDebito: TColorLabel;
    Label7: TLabel;
    edtDocRefDebito: TEditFocus;
    ColorLabel1: TColorLabel;
    cdsCreditoCCD_DOCREF: TStringField;
    cdsDebitoCCD_DOCREF: TStringField;
    cxGridCreditoColumn7: TcxGridDBColumn;
    cxGridDebitoColumn7: TcxGridDBColumn;
    Label8: TLabel;
    edtMesAnoCredito: TEditFocus;
    ColorLabel2: TColorLabel;
    edtCbsIbsCredito: TEditFocus;
    Label9: TLabel;
    ColorLabel3: TColorLabel;
    edtMesAnoDebito: TEditFocus;
    Label10: TLabel;
    ColorLabel4: TColorLabel;
    Label11: TLabel;
    edtCbsIbsDebito: TEditFocus;
    ColorLabel5: TColorLabel;
    cdsCreditoCCD_MESANO: TStringField;
    cdsCreditoCCD_CBSIBS: TStringField;
    cdsDebitoCCD_MESANO: TStringField;
    cdsDebitoCCD_CBSIBS: TStringField;
    cxGridCreditoColumn8: TcxGridDBColumn;
    cxGridCreditoColumn9: TcxGridDBColumn;
    cxGridDebitoColumn8: TcxGridDBColumn;
    cxGridDebitoColumn9: TcxGridDBColumn;
    procedure dbeCstCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTipoCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeClaFisCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTipoDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCstDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeClaFisDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGridCreditoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaCreditoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCancelaCreditoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaDebitoClick(Sender: TObject);
    procedure cxGridDebitoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaDebitoClick(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    procedure pCriaClientDataSet;
    procedure pCarregaCredito;
    procedure pCarregaDebito;
    procedure pAdicionaCredito;
    procedure pAdicionaDebito;
    procedure pDeletaCredito;
    procedure pDeletaDebito;
    procedure pGravaCredito;
    procedure pGravaDebito;
    procedure pLimpaInclusao;
    procedure pAcessoTela(blnHabilitado: Boolean);
    procedure pConfirma;
    procedure pMostraCredito;
    procedure pMostraDebito;
    procedure pRemoveCredito;
    procedure pRemoveDebito;
    function fGravaRegistros: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadReformaTributariaCreditoDebito: TfrmCadReformaTributariaCreditoDebito;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{$R *.dfm}

function TfrmCadReformaTributariaCreditoDebito.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeTipoCredito) And (dbeTipoCredito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeTipoCredito.Text) Then
      Begin
        dbeTipoCreditoDescr.Text := fRetDescricaoTipoCreditoReformaTributaria(dbeTipoCredito.Text);
        If fEmptyStr(dbeTipoCreditoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Tipo de Crédito não cadastrado!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeTipoCreditoDescr.Clear;
    End
    Else If (Sender = dbeCstCredito) And (dbeCstCredito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeCstCredito.Text) Then
      Begin
        dbeCstCreditoDescr.Text := fRetDescricaoCSTReformaTributaria(dbeCstCredito.Text);
        If fEmptyStr(dbeCstCreditoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Situação Tributária não cadastrada!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeCstCreditoDescr.Clear;
    End
    Else If (Sender = dbeClaFisCredito) And (dbeClaFisCredito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeClaFisCredito.Text) Then
      Begin
        dbeClaFisCreditoDescr.Text := fRetDescricaoClaFisReformaTributaria(dbeClaFisCredito.Text);
        If fEmptyStr(dbeClaFisCreditoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Classificação Tributária não cadastrada!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeClaFisCreditoDescr.Clear;
    End
    Else If (Sender = dbeTipoDebito) And (dbeTipoDebito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeTipoDebito.Text) Then
      Begin
        dbeTipoDebitoDescr.Text := fRetDescricaoTipoDebitoReformaTributaria(dbeTipoDebito.Text);
        If fEmptyStr(dbeTipoDebitoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Tipo de Débito não cadastrado!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeTipoDebitoDescr.Clear;
    End
    Else If (Sender = dbeCstDebito) And (dbeCstDebito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeCstDebito.Text) Then
      Begin
        dbeCstDebitoDescr.Text := fRetDescricaoCSTReformaTributaria(dbeCstDebito.Text);
        If fEmptyStr(dbeCstDebitoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Situação Tributária não cadastrada!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeCstDebitoDescr.Clear;
    End
    Else If (Sender = dbeClaFisDebito) And (dbeClaFisDebito.Enabled) Then
    Begin
      If Not fEmptyStr(dbeClaFisDebito.Text) Then
      Begin
        dbeClaFisDebitoDescr.Text := fRetDescricaoClaFisReformaTributaria(dbeClaFisDebito.Text);
        If fEmptyStr(dbeClaFisDebitoDescr.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Classificação Tributária não cadastrada!', ['&OK']);
          Result := False;
        End
      End
      Else
        dbeClaFisDebitoDescr.Clear;
    End
    Else If (Sender = edtDocRefCredito) And (edtDocRefCredito.Enabled) Then
    Begin
      Result := (Pos(edtDocRefCredito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa Chave Referenciada" deve ser S ou N!',['&Ok']);
    End
    Else If (Sender = edtDocRefDebito) And (edtDocRefDebito.Enabled) Then
    Begin
      Result := (Pos(edtDocRefDebito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa Chave Referenciada" deve ser S ou N!',['&Ok']);
    End
    Else If (Sender = edtMesAnoDebito) And (edtMesAnoDebito.Enabled) Then
    Begin
      Result := (Pos(edtMesAnoDebito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa Mês/Ano" deve ser S ou N!',['&Ok']);
    End
    Else If (Sender = edtCbsIbsDebito) And (edtCbsIbsDebito.Enabled) Then
    Begin
      Result := (Pos(edtCbsIbsDebito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa CBS e IBS" deve ser S ou N!',['&Ok']);
    End
    Else If (Sender = edtMesAnoCredito) And (edtMesAnoCredito.Enabled) Then
    Begin
      Result := (Pos(edtMesAnoCredito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa Mês/Ano" deve ser S ou N!',['&Ok']);
    End
    Else If (Sender = edtCbsIbsCredito) And (edtCbsIbsCredito.Enabled) Then
    Begin
      Result := (Pos(edtCbsIbsCredito.Text, 'SN') > 0);

      If Not Result Then
        fMensagem('ATENÇÃO', 'O campo "Usa CBS e IBS" deve ser S ou N!',['&Ok']);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadReformaTributariaCreditoDebito.pCriaClientDataSet;
begin
  cdsDebito.CreateDataSet;
  cdsCredito.CreateDataSet;

  dtsDebito.DataSet  := cdsDebito;
  dtsCredito.DataSet := cdsCredito;

  cxGridDebito.DataController.DataSource  := dtsDebito;
  cxGridCredito.DataController.DataSource := dtsCredito;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pConfirma;
begin

  fStartTransaction;

  Try
    If fGravaRegistros Then
    Begin
      fCommit;
      fMensagem('', 'Registros gravados com sucesso!', ['&Ok']);
    End
    Else
    Begin
      fRollBack;
      fMensagem('', 'Não foi possível gravar os registros.', ['&Ok']);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaCreditoDebito.pConfirma]');
    End;
  End;
end;

function TfrmCadReformaTributariaCreditoDebito.fGravaRegistros: Boolean;
begin
  Result := True;

  Try
    pDeletaCredito;
    pGravaCredito;

    pDeletaDebito;
    pGravaDebito;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaCreditoDebito.fGravaRegistros]');
    End;
  End;
end;


procedure TfrmCadReformaTributariaCreditoDebito.pCarregaCredito;
var
  qryCredito: TUniQuery;
begin
  qryCredito := fCriaQuery(Nil);

  Try
    qryCredito.Sql.Text := 'SELECT * FROM CCDREF WHERE CCD_CREDEB = "C" ';
    qryCredito.Open;

    If qryCredito.RecordCount > 0 Then
    Begin
      cdsCredito.EmptyDataSet;
      cdsCredito.DisableControls;

      try

        While not qryCredito.Eof Do
        begin
          cdsCredito.Append;
          cdsCredito.FieldByName('CCD_TIPFIN').AsString := qryCredito.FieldByName('CCD_TIPFIN').AsString ;
          cdsCredito.FieldByName('CCD_TIPDES').AsString := fRetDescricaoTipoCreditoReformaTributaria(qryCredito.FieldByName('CCD_TIPFIN').AsString) ;

          cdsCredito.FieldByName('CCD_CODCST').AsString := qryCredito.FieldByName('CCD_CODCST').AsString ;
          cdsCredito.FieldByName('CCD_CSTDES').AsString := fRetDescricaoCSTReformaTributaria(qryCredito.FieldByName('CCD_CODCST').AsString) ;

          cdsCredito.FieldByName('CCD_CLATRI').AsString := qryCredito.FieldByName('CCD_CLATRI').AsString ;
          cdsCredito.FieldByName('CCD_CLADES').AsString := fRetDescricaoClaFisReformaTributaria(qryCredito.FieldByName('CCD_CLATRI').AsString) ;

          cdsCredito.FieldByName('CCD_DOCREF').AsString := qryCredito.FieldByName('CCD_DOCREF').AsString ;
          cdsCredito.FieldByName('CCD_MESANO').AsString := qryCredito.FieldByName('CCD_MESANO').AsString ;
          cdsCredito.FieldByName('CCD_CBSIBS').AsString := qryCredito.FieldByName('CCD_CBSIBS').AsString ;
          cdsCredito.Post;

          qryCredito.Next;
        end;

      finally
        cdsCredito.First;
        cdsCredito.EnableControls;
      end;

    End;

  Finally
    FreeAndNil(qryCredito);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pCarregaDebito;
var
  qryDebito: TUniQuery;
begin
  qryDebito := fCriaQuery(Nil);

  Try
    qryDebito.Sql.Text := 'SELECT * FROM CCDREF WHERE CCD_CREDEB = "D" ';
    qryDebito.Open;

    If qryDebito.RecordCount > 0 Then
    Begin
      cdsDebito.EmptyDataSet;
      cdsDebito.DisableControls;

      try

        While not qryDebito.Eof Do
        begin
          cdsDebito.Append;
          cdsDebito.FieldByName('CCD_TIPFIN').AsString := qryDebito.FieldByName('CCD_TIPFIN').AsString ;
          cdsDebito.FieldByName('CCD_TIPDES').AsString := fRetDescricaoTipoDebitoReformaTributaria(qryDebito.FieldByName('CCD_TIPFIN').AsString) ;

          cdsDebito.FieldByName('CCD_CODCST').AsString := qryDebito.FieldByName('CCD_CODCST').AsString ;
          cdsDebito.FieldByName('CCD_CSTDES').AsString := fRetDescricaoCSTReformaTributaria(qryDebito.FieldByName('CCD_CODCST').AsString) ;

          cdsDebito.FieldByName('CCD_CLATRI').AsString := qryDebito.FieldByName('CCD_CLATRI').AsString ;
          cdsDebito.FieldByName('CCD_CLADES').AsString := fRetDescricaoClaFisReformaTributaria(qryDebito.FieldByName('CCD_CLATRI').AsString) ;

          cdsDebito.FieldByName('CCD_DOCREF').AsString := qryDebito.FieldByName('CCD_DOCREF').AsString ;
          cdsDebito.FieldByName('CCD_MESANO').AsString := qryDebito.FieldByName('CCD_MESANO').AsString ;
          cdsDebito.FieldByName('CCD_CBSIBS').AsString := qryDebito.FieldByName('CCD_CBSIBS').AsString ;
          cdsDebito.Post;

          qryDebito.Next;
        end;

      finally
        cdsDebito.First;
        cdsDebito.EnableControls;
      end;

    End;

  Finally
    FreeAndNil(qryDebito);
  End;
end;


procedure TfrmCadReformaTributariaCreditoDebito.pDeletaCredito;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);

  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add(' DELETE FROM CCDREF WHERE CCD_CREDEB = "C" ');
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pDeletaDebito;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);

  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add(' DELETE FROM CCDREF WHERE CCD_CREDEB = "D" ');
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pGravaCredito;
var
  qryCredito: TUniQuery;
begin
  qryCredito := fCriaQuery(Nil);

  Try
    qryCredito.Sql.Text := 'SELECT * FROM CCDREF WHERE FALSE ';
    qryCredito.Open;

    cdsCredito.Filtered := False;
    cdsCredito.DisableControls;
    cdsCredito.First;

    While not cdsCredito.eof Do
    Begin
      qryCredito.Insert;
      qryCredito.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CCDREF','');
      qryCredito.FieldByName('CCD_CREDEB').AsString := 'C';
      qryCredito.FieldByName('CCD_TIPFIN').AsString := cdsCredito.FieldByName('CCD_TIPFIN').AsString;
      qryCredito.FieldByName('CCD_CODCST').AsString := cdsCredito.FieldByName('CCD_CODCST').AsString;
      qryCredito.FieldByName('CCD_CLATRI').AsString := cdsCredito.FieldByName('CCD_CLATRI').AsString;
      qryCredito.FieldByName('CCD_DOCREF').AsString := cdsCredito.FieldByName('CCD_DOCREF').AsString;
      qryCredito.FieldByName('CCD_MESANO').AsString := cdsCredito.FieldByName('CCD_MESANO').AsString;
      qryCredito.FieldByName('CCD_CBSIBS').AsString := cdsCredito.FieldByName('CCD_CBSIBS').AsString;
      qryCredito.Post;

      cdsCredito.Next;
    End;

  Finally
    FreeAndNil(qryCredito);
    cdsCredito.EnableControls;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pGravaDebito;
var
  qryDebito: TUniQuery;
begin
  qryDebito := fCriaQuery(Nil);

  Try
    qryDebito.Sql.Text := 'SELECT * FROM CCDREF WHERE FALSE ';
    qryDebito.Open;

    cdsDebito.Filtered := False;
    cdsDebito.DisableControls;
    cdsDebito.First;

    While not cdsDebito.eof Do
    Begin
      qryDebito.Insert;
      qryDebito.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CCDREF','');
      qryDebito.FieldByName('CCD_CREDEB').AsString := 'D';
      qryDebito.FieldByName('CCD_TIPFIN').AsString := cdsDebito.FieldByName('CCD_TIPFIN').AsString;
      qryDebito.FieldByName('CCD_CODCST').AsString := cdsDebito.FieldByName('CCD_CODCST').AsString;
      qryDebito.FieldByName('CCD_CLATRI').AsString := cdsDebito.FieldByName('CCD_CLATRI').AsString;
      qryDebito.FieldByName('CCD_DOCREF').AsString := cdsDebito.FieldByName('CCD_DOCREF').AsString;
      qryDebito.FieldByName('CCD_MESANO').AsString := cdsDebito.FieldByName('CCD_MESANO').AsString;
      qryDebito.FieldByName('CCD_CBSIBS').AsString := cdsDebito.FieldByName('CCD_CBSIBS').AsString;
      qryDebito.Post;

      cdsDebito.Next;
    End;

  Finally
    FreeAndNil(qryDebito);
    cdsDebito.EnableControls;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pAdicionaCredito;
begin
  If not Assigned(cdsCredito) Then
    Exit;

  If not cdsCredito.Active Then
    Exit;

  If cdsCredito.Locate('CCD_TIPFIN', VarArrayOf([dbeTipoCredito.Text]), []) Then
   cdsCredito.Edit
  Else
   cdsCredito.Append;

  Try
    cdsCredito.FieldByName('CCD_TIPFIN').AsString := dbeTipoCredito.Text;
    cdsCredito.FieldByName('CCD_TIPDES').AsString := fRetDescricaoTipoCreditoReformaTributaria(dbeTipoCredito.Text) ;

    cdsCredito.FieldByName('CCD_CODCST').AsString := dbeCstCredito.Text;
    cdsCredito.FieldByName('CCD_CSTDES').AsString := fRetDescricaoCSTReformaTributaria(dbeCstCredito.Text) ;

    cdsCredito.FieldByName('CCD_CLATRI').AsString := dbeClaFisCredito.Text;
    cdsCredito.FieldByName('CCD_CLADES').AsString := fRetDescricaoClaFisReformaTributaria(dbeClaFisCredito.Text) ;

    cdsCredito.FieldByName('CCD_DOCREF').AsString := edtDocRefCredito.Text;
    cdsCredito.FieldByName('CCD_MESANO').AsString := edtMesAnoCredito.Text;
    cdsCredito.FieldByName('CCD_CBSIBS').AsString := edtCbsIbsCredito.Text;

    cdsCredito.Post;
  Except
    On E: Exception Do
    Begin
      cdsCredito.Cancel;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaCreditoDebito.pAdicionaCredito]');
      fMensagem('ATENÇÃO', 'Não foi possível adicionar o registro de crédito.', ['&OK']);
    End;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pAdicionaDebito;
begin
  If not Assigned(cdsDebito) Then
    Exit;

  If not cdsDebito.Active Then
    Exit;

  If cdsDebito.Locate('CCD_TIPFIN', VarArrayOf([dbeTipoDebito.Text]), []) Then
   cdsDebito.Edit
  Else
   cdsDebito.Append;

  Try
    cdsDebito.FieldByName('CCD_TIPFIN').AsString := dbeTipoDebito.Text;
    cdsDebito.FieldByName('CCD_TIPDES').AsString := fRetDescricaoTipoDebitoReformaTributaria(dbeTipoDebito.Text) ;

    cdsDebito.FieldByName('CCD_CODCST').AsString := dbeCstDebito.Text;
    cdsDebito.FieldByName('CCD_CSTDES').AsString := fRetDescricaoCSTReformaTributaria(dbeCstDebito.Text) ;

    cdsDebito.FieldByName('CCD_CLATRI').AsString := dbeClaFisDebito.Text;
    cdsDebito.FieldByName('CCD_CLADES').AsString := fRetDescricaoClaFisReformaTributaria(dbeClaFisDebito.Text) ;

    cdsDebito.FieldByName('CCD_DOCREF').AsString := edtDocRefDebito.Text;
    cdsDebito.FieldByName('CCD_MESANO').AsString := edtMesAnoDebito.Text;
    cdsDebito.FieldByName('CCD_CBSIBS').AsString := edtCbsIbsDebito.Text;

    cdsDebito.Post;
  Except
    On E: Exception Do
    Begin
      cdsDebito.Cancel;
      pMensagensErro(E.Message, '[TfrmCadReformaTributariaCreditoDebito.pAdicionaDebito]');
      fMensagem('ATENÇÃO', 'Não foi possível adicionar o registro de débito.', ['&OK']);
    End;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pLimpaInclusao;
begin
  dbeTipoDebito.Clear;
  dbeTipoDebitoDescr.Clear;
  dbeCstDebito.Clear;
  dbeCstDebitoDescr.Clear;
  dbeClaFisDebito.Clear;
  dbeClaFisDebitoDescr.Clear;
  edtDocRefDebito.Clear;
  edtMesAnoDebito.Clear;
  edtCbsIbsDebito.Clear;

  dbeTipoCredito.Clear;
  dbeTipoCreditoDescr.Clear;
  dbeCstCredito.Clear;
  dbeCstCreditoDescr.Clear;
  dbeClaFisCredito.Clear;
  dbeClaFisCreditoDescr.Clear;
  edtDocRefCredito.Clear;
  edtMesAnoCredito.Clear;
  edtCbsIbsCredito.Clear;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pAcessoTela(blnHabilitado: Boolean);
begin
  pnlPrincipal.Enabled := blnHabilitado;

  btnAlterar.Enabled  := not blnHabilitado;
  btnCancelar.Enabled := blnHabilitado;
  btnConfirma.Enabled := blnHabilitado;

  dbeTipoCredito.Color   := $00FFDFB8;
  dbeCstCredito.Color    := $00FFDFB8;
  dbeClaFisCredito.Color := $00FFDFB8;
  edtDocRefCredito.Color := $00FFDFB8;
  edtMesAnoCredito.Color := $00FFDFB8;
  edtCbsIbsCredito.Color := $00FFDFB8;

  dbeTipoDebito.Color    := $00FFDFB8;
  dbeCstDebito.Color     := $00FFDFB8;
  dbeClaFisDebito.Color  := $00FFDFB8;
  edtDocRefDebito.Color  := $00FFDFB8;
  edtMesAnoDebito.Color  := $00FFDFB8;
  edtCbsIbsDebito.Color  := $00FFDFB8;

  If blnHabilitado Then
  Begin
    dbeTipoCredito.Color   := clWindow;
    dbeCstCredito.Color    := clWindow;
    dbeClaFisCredito.Color := clWindow;
    edtDocRefCredito.Color := clWindow;
    edtMesAnoCredito.Color := clWindow;
    edtCbsIbsCredito.Color := clWindow;

    dbeTipoDebito.Color    := clWindow;
    dbeCstDebito.Color     := clWindow;
    dbeClaFisDebito.Color  := clWindow;
    edtDocRefDebito.Color  := clWindow;
    edtMesAnoDebito.Color  := clWindow;
    edtCbsIbsDebito.Color  := clWindow;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeTipoCreditoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeTipoCredito.ReadOnly then
    Exit;

  if fPesqReformaTributariaTipoDeCredito(Self, dbeTipoCredito, dbeTipoCreditoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeTipoCredito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeCstCreditoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeCstCredito.ReadOnly then
    Exit;

  if fPesqCSTReformaTributaria(Self, dbeCstCredito, dbeCstCreditoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeCstCredito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAcessoTela(True);
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnCancelaCreditoClick(Sender: TObject);
begin
  inherited;
  pLimpaInclusao;
  pSetFocus(cxCredito);
  cxCredito.Enabled := True;
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnCancelaDebitoClick(Sender: TObject);
begin
  inherited;
  pLimpaInclusao;
  pSetFocus(cxDebito);
  cxDebito.Enabled := True;
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pCarregaCredito;
  pCarregaDebito;
  pLimpaInclusao;
  pAcessoTela(False);
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fMensagem('', 'Deseja confirmar?', ['&Sim', '&Não']) = 1 Then
  Begin
    pConfirma;
    pAcessoTela(False);
  End
  Else
    pSetFocus(btnConfirma);
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnConfirmaCreditoClick(Sender: TObject);
begin
  inherited;

  If not Assigned(cdsCredito) Then
    Exit;

  If fEmptyStr(dbeTipoCredito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o tipo de crédito!', ['&OK']);
    pSetFocus(dbeTipoCredito);
    Exit;
  End;

  If fEmptyStr(dbeCstCredito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o código da situação tributária!', ['&OK']);
    pSetFocus(dbeCstCredito);
    Exit;
  End;

  If fEmptyStr(dbeClaFisCredito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o código da classificação tributária!', ['&OK']);
    pSetFocus(dbeClaFisCredito);
    Exit;
  End;

  If not fValidaCampos(dbeTipoCredito, true) Then
    Exit;

  If not fValidaCampos(dbeCstCredito, true) Then
    Exit;

  If not fValidaCampos(dbeClaFisCredito, true) Then
    Exit;

  If not fValidaCampos(edtDocRefCredito, true) Then
    Exit;

  If not fValidaCampos(edtMesAnoCredito, true) Then
    Exit;

  If not fValidaCampos(edtCbsIbsCredito, true) Then
    Exit;

  cxCredito.Enabled := True;

  pAdicionaCredito;
  pLimpaInclusao;
  pSetFocus(cxCredito);
end;

procedure TfrmCadReformaTributariaCreditoDebito.btnConfirmaDebitoClick(Sender: TObject);
begin

  If not Assigned(cdsDebito) Then
    Exit;

  If fEmptyStr(dbeTipoDebito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o tipo de débito!', ['&OK']);
    pSetFocus(dbeTipoDebito);
    Exit;
  End;

  If fEmptyStr(dbeCstDebito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o código da situação tributária!', ['&OK']);
    pSetFocus(dbeCstDebito);
    Exit;
  End;

  If fEmptyStr(dbeClaFisDebito.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o código da classificação tributária!', ['&OK']);
    pSetFocus(dbeClaFisDebito);
    Exit;
  End;

  If not fValidaCampos(dbeTipoDebito, true) Then
    Exit;

  If not fValidaCampos(dbeCstDebito, true) Then
    Exit;

  If not fValidaCampos(dbeClaFisDebito, true) Then
    Exit;

  If not fValidaCampos(edtDocRefDebito, true) Then
    Exit;

  If not fValidaCampos(edtMesAnoDebito, true) Then
    Exit;

  If not fValidaCampos(edtCbsIbsDebito, true) Then
    Exit;

  cxDebito.Enabled := True;

  pAdicionaDebito;
  pLimpaInclusao;
  pSetFocus(cxDebito);
end;

procedure TfrmCadReformaTributariaCreditoDebito.cxGridCreditoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If not Assigned(cdsCredito) Then
    Exit;

  Case Key Of
    VK_RETURN: pMostraCredito;
    VK_DELETE: pRemoveCredito;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.cxGridDebitoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If not Assigned(cdsDebito) Then
    Exit;

  Case Key Of
    VK_RETURN: pMostraDebito;
    VK_DELETE: pRemoveDebito;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pMostraCredito;
begin
  If cdsCredito.IsEmpty Then
    Exit;

  btnConfirmaCredito.Enabled := True;
  btnCancelaCredito.Enabled  := True;
  pnlCredito.Enabled         := True;
  cxCredito.Enabled          := False;

  dbeTipoCredito.Text        := cdsCredito.FieldByName('CCD_TIPFIN').AsString;
  dbeTipoCreditoDescr.Text   := cdsCredito.FieldByName('CCD_TIPDES').AsString;

  dbeCstCredito.Text         := cdsCredito.FieldByName('CCD_CODCST').AsString;
  dbeCstCreditoDescr.Text    := cdsCredito.FieldByName('CCD_CSTDES').AsString;

  dbeClaFisCredito.Text      := cdsCredito.FieldByName('CCD_CLATRI').AsString;
  dbeClaFisCreditoDescr.Text := cdsCredito.FieldByName('CCD_CLADES').AsString;

  edtDocRefCredito.Text      := cdsCredito.FieldByName('CCD_DOCREF').AsString;
  edtMesAnoCredito.Text      := cdsCredito.FieldByName('CCD_MESANO').AsString;
  edtCbsIbsCredito.Text      := cdsCredito.FieldByName('CCD_CBSIBS').AsString;

  pSetFocus(dbeTipoCredito);
end;

procedure TfrmCadReformaTributariaCreditoDebito.pMostraDebito;
begin
  If cdsDebito.IsEmpty Then
    Exit;

  btnConfirmaDebito.Enabled := True;
  btnCancelaDebito.Enabled  := True;
  pnlDebito.Enabled         := True;
  cxDebito.Enabled          := False;

  dbeTipoDebito.Text        := cdsDebito.FieldByName('CCD_TIPFIN').AsString;
  dbeTipoDebitoDescr.Text   := cdsDebito.FieldByName('CCD_TIPDES').AsString;

  dbeCstDebito.Text         := cdsDebito.FieldByName('CCD_CODCST').AsString;
  dbeCstDebitoDescr.Text    := cdsDebito.FieldByName('CCD_CSTDES').AsString;

  dbeClaFisDebito.Text      := cdsDebito.FieldByName('CCD_CLATRI').AsString;
  dbeClaFisDebitoDescr.Text := cdsDebito.FieldByName('CCD_CLADES').AsString;

  edtDocRefDebito.Text      := cdsDebito.FieldByName('CCD_DOCREF').AsString;
  edtMesAnoDebito.Text      := cdsDebito.FieldByName('CCD_MESANO').AsString;
  edtCbsIbsDebito.Text      := cdsDebito.FieldByName('CCD_CBSIBS').AsString;

  pSetFocus(dbeTipoDebito);
end;

procedure TfrmCadReformaTributariaCreditoDebito.pRemoveCredito;
begin
  If cdsCredito.IsEmpty Then
    Exit;

  If fMensagem('', 'Deseja excluir o registro selecionado?', ['&Sim', '&Não']) = 1 Then
    cdsCredito.Delete;
end;

procedure TfrmCadReformaTributariaCreditoDebito.pRemoveDebito;
begin
  If cdsDebito.IsEmpty Then
    Exit;

  If fMensagem('', 'Deseja excluir o registro selecionado?', ['&Sim', '&Não']) = 1 Then
    cdsDebito.Delete;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeClaFisCreditoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeClaFisCredito.ReadOnly then
    Exit;

  if fPesqReformaTributariaClassificacaoTributaria(Self, dbeClaFisCredito, dbeClaFisCreditoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeClaFisCredito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeTipoDebitoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeTipoDebito.ReadOnly then
    Exit;

  if fPesqReformaTributariaTipoDeDebito(Self, dbeTipoDebito, dbeTipoDebitoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeTipoDebito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If Assigned(cdsDebito) Then
    FreeAndNil(cdsDebito);

  If Assigned(cdsCredito) Then
    FreeAndNil(cdsCredito);
end;

procedure TfrmCadReformaTributariaCreditoDebito.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaClientDataSet;
  pCarregaCredito;
  pCarregaDebito;
  pLimpaInclusao;
  pAcessoTela(False);
  pSetFocus(btnAlterar);
end;

procedure TfrmCadReformaTributariaCreditoDebito.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2    : btnAlterar.Click;
    VK_F3    : btnCancelar.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: Begin
                 Key := VK_CLEAR;

                 If pnlPrincipal.Enabled And
                    Assigned(ActiveControl) And
                    (ActiveControl.Parent Is TPanel) And
                    ((TPanel(ActiveControl.Parent).Name = 'pnlCredito') Or (TPanel(ActiveControl.Parent).Name = 'pnlDebito')) Then
                 Begin
                   btnCancelar.Click;
                 End
                 Else
                 Begin
                   If fMensagem('', 'Deseja realmente sair?', ['&Sim', '&Não']) = 1 Then
                     btnSair.Click
                   Else
                     btnCancelar.Click;
                 End;
               End;
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeCstDebitoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeCstDebito.ReadOnly then
    Exit;

  if fPesqCSTReformaTributaria(Self, dbeCstDebito, dbeCstDebitoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeCstDebito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadReformaTributariaCreditoDebito.dbeClaFisDebitoKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If dbeClaFisDebito.ReadOnly then
    Exit;

  if fPesqReformaTributariaClassificacaoTributaria(Self, dbeClaFisDebito, dbeClaFisDebitoDescr, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(dbeClaFisDebito) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
