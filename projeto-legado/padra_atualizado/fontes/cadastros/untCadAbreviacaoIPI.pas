unit untCadAbreviacaoIPI;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, MaskEditFocus, DB, UniClientDataSet, Uni,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade, untConsultas, untTypesSistema,
  Datasnap.DBClient;

type
  TfrmCadAbreviacaoIPI = class(TfrmPai)
    pnlGeral: TPanel;
    dbgSaida: TDBGridCitel;
    dbgEntrada: TDBGridCitel;
    Label1: TLabel;
    edtCodApc: TEditFocus;
    edtDescri: TEditFocus;
    Label2: TLabel;
    dtsSaida: TDataSource;
    cdsSaida: TUniClientDataSet;
    cdsSaidaAPC_CSTSAI: TStringField;
    cdsSaidaAPC_ENQIPI: TStringField;
    cdsSaidaAPC_BASSAI: TFloatField;
    cdsSaidaAPC_ALQSAI: TFloatField;
    cdsSaidaAPC_CFOSAI: TStringField;
    dtsEntrada: TDataSource;
    cdsEntrada: TUniClientDataSet;
    cdsEntradaAPC_CSTENT: TStringField;
    cdsEntradaAPC_ENQIPI: TStringField;
    cdsEntradaAPC_BASENT: TFloatField;
    cdsEntradaAPC_ALQENT: TFloatField;
    cdsEntradaAPC_CFOENT: TStringField;
    pnlSaida: TPanel;
    gpbSaida: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCstSaida: TEditFocus;
    edtBaseSaida: TEditFocus;
    edtAliqSaida: TEditFocus;
    mskCfopSaida: TMaskEditFocus;
    pnlEntrada: TPanel;
    gpbEntrada: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtCstEntrada: TEditFocus;
    edtBaseEntrada: TEditFocus;
    edtAliqEntrada: TEditFocus;
    mskCfopEntrada: TMaskEditFocus;
    btnPesquisa: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnConfirmaSaida: TBitBtnLocked;
    btnCancelaSaida: TBitBtnLocked;
    btnConfirmaEntrada: TBitBtnLocked;
    btnCancelaEntrada: TBitBtnLocked;
    cdsSaidaAUTOINCREM: TStringField;
    cdsEntradaAUTOINCREM: TStringField;
    edtEnqIpiSai: TEditFocus;
    edtDesEnqIpiSai: TEditFocus;
    lblDigita: TLabel;
    Label11: TLabel;
    edtEnqIpiEnt: TEditFocus;
    edtDesEnqIpiEnt: TEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnConfirmaSaidaClick(Sender: TObject);
    procedure btnConfirmaEntradaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaSaidaClick(Sender: TObject);
    procedure btnCancelaEntradaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbgSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsSaidaAfterScroll(DataSet: TDataSet);
    procedure cdsEntradaAfterScroll(DataSet: TDataSet);
    procedure dbgEntradaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtCstSaidaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCstEntradaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtEnqIpiSaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtEnqIpiEntKeyPress(Sender: TObject; var Key: Char);
    procedure mskCfopSaidaEnter(Sender: TObject);
  private
    strAutIncSai: String;
    strAutIncEnt: String;
    blnInserindo: Boolean;
    blnAlterando: Boolean;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pLimparTela;
    procedure pGravarRegrasDeAbreviacao;
    procedure pLimparDadosSaida;
    procedure pLimparDadosEntrada;
    procedure pExcluirRegrasDeAbreviacao;
    function fCstPisValida(strCst: String): Boolean;
    function fValidaCfops(strCfops: string): Boolean;
    function fCfopCadastrada(strCfop: String): Boolean;
    function fAbreviacaoIPIExiste(strCod: String): Boolean;
    procedure pCarregaDadosAbreviacao(strCodApc: String);
    procedure pComecaEdicaoDoRegistro;
    function fGeraAutoIncremTmp: String;
    procedure pLimpaAutIncControle;
    procedure pHabilitaParaEdicaoSaida;
    procedure pHabilitaParaEdicaoEntrada;
    function fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, StrUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadAbreviacaoIPI.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadAbreviacaoIPI.btnCancelaEntradaClick(Sender: TObject);
begin
  inherited;
  pLimparDadosEntrada;
  pSetFocus(edtCstEntrada);
end;

procedure TfrmCadAbreviacaoIPI.btnCancelaSaidaClick(Sender: TObject);
begin
  inherited;
  pLimparDadosSaida;
  pSetFocus(edtCstSaida);
end;

procedure TfrmCadAbreviacaoIPI.btnConfirmaEntradaClick(Sender: TObject);
begin
  inherited;
  cdsEntrada.AfterScroll := Nil;
  If (Not fEmptyStr(edtCodApc.Text)  And
      fValidaCampos(edtCstEntrada)   And
      fValidaCampos(edtEnqIpiEnt)    And
      fValidaCampos(edtBaseEntrada)  And
      fValidaCampos(edtAliqEntrada)  And
      fValidaCampos(mskCfopEntrada)  And
      fAbreviacaoCfopExiste(cdsEntrada, mskCfopEntrada.Text, 'ENT', edtCstEntrada.Text) And
      (Not fCSTJaCadastrada(cdsEntrada, edtCstEntrada.Text, strAutIncEnt, 0, edtEnqIpiEnt.Text))) Then
  Begin
    If (Not fEmptyStr(strAutIncEnt))                     And
       (cdsEntrada.Locate('AUTOINCREM', strAutIncEnt, [])) Then
    Begin
      cdsEntrada.Edit;
    End
    Else
      cdsEntrada.Append;

    cdsEntrada.FieldByName('APC_CSTENT').AsString := edtCstEntrada.Text;
    cdsEntrada.FieldByName('APC_ENQIPI').AsString := edtEnqIpiEnt.Text;
    cdsEntrada.FieldByName('APC_BASENT').AsFloat := fStrToFloat(edtBaseEntrada.Text);
    cdsEntrada.FieldByName('APC_ALQENT').AsFloat := fStrToFloat(edtAliqEntrada.Text);
    cdsEntrada.FieldByName('APC_CFOENT').AsString := mskCfopEntrada.Text;
    cdsEntrada.FieldByName('AUTOINCREM').AsString := fGeraAutoIncremTmp;
    cdsEntrada.Post;

    pLimparDadosEntrada;
    pSetFocus(edtCstEntrada);

    If Not blnInserindo Then
      blnAlterando := True;

    pHabilitar(False);
  End;
  cdsEntrada.AfterScroll := cdsEntradaAfterScroll;
end;

procedure TfrmCadAbreviacaoIPI.btnConfirmaSaidaClick(Sender: TObject);
begin
  inherited;
  cdsSaida.AfterScroll := Nil;

  If (Not fEmptyStr(edtCodApc.Text)And
      fValidaCampos(edtCstSaida)   And
      fValidaCampos(edtEnqIpiSai)  And
      fValidaCampos(edtBaseSaida)  And
      fValidaCampos(edtAliqSaida)  And
      fValidaCampos(mskCfopSaida)  And
      fAbreviacaoCfopExiste(cdsSaida, mskCfopSaida.Text, 'SAI', edtCstSaida.Text) And
      (Not fCSTJaCadastrada(cdsSaida, edtCstSaida.Text, strAutIncSai, 0, edtEnqIpiSai.Text))) Then
  Begin
    If (Not fEmptyStr(strAutIncSai))                     And
       (cdsSaida.Locate('AUTOINCREM', strAutIncSai, [])) Then
    Begin
      cdsSaida.Edit;
    End
    Else
      cdsSaida.Append;

    cdsSaida.FieldByName('APC_CSTSAI').AsString := edtCstSaida.Text;
    cdsSaida.FieldByName('APC_ENQIPI').AsString := edtEnqIpiSai.Text;
    cdsSaida.FieldByName('APC_BASSAI').AsFloat := fStrToFloat(edtBaseSaida.Text);
    cdsSaida.FieldByName('APC_ALQSAI').AsFloat := fStrToFloat(edtAliqSaida.Text);
    cdsSaida.FieldByName('APC_CFOSAI').AsString := mskCfopSaida.Text;
    cdsSaida.FieldByName('AUTOINCREM').AsString := fGeraAutoIncremTmp;
    cdsSaida.Post;

    pLimparDadosSaida;
    pSetFocus(edtCstSaida);

    If Not blnInserindo Then
      blnAlterando := True;

    pHabilitar(False);
  End;
  cdsSaida.AfterScroll := cdsSaidaAfterScroll;
end;

procedure TfrmCadAbreviacaoIPI.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodApc.Text)) Then
  Begin
    If fMensagem('Atenção!', 'Deseja excluir este registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      pExcluirRegrasDeAbreviacao;
      pLimparTela;

      blnInserindo := False;
      blnAlterando := False;
      pLimpaAutIncControle;
    End;
  End;
end;

procedure TfrmCadAbreviacaoIPI.pExcluirRegrasDeAbreviacao;
  Var
    qryDel: TUniQuery;
begin
  fStartTransaction;

  Try
    qryDel := fCriaQuery(Self);
    qryDel.SQL.Add('DELETE FROM IPISAI WHERE APC_CODAPC = :CODAPC');
    qryDel.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryDel.ExecSQL;

    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM IPIENT WHERE APC_CODAPC = :CODAPC');
    qryDel.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryDel.ExecSQL;

    FreeAndNil(qryDel);

    fCommit;
  Except
    On E: Exception Do
    Begin
      If e.Message = 'SQL Error: Cannot delete or update a parent row: a foreign key constraint fails' Then
        fMensagem('ATENÇÃO!','Não é possivel excluir esse registro, pois existe itens relacionados !',['&O K'])
      Else
        pMensagensErro(e.Message, '[pExcluirRegrasDeAbreviacao]');
      fRollBack;
    End;
  End;
end;

procedure TfrmCadAbreviacaoIPI.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodApc) Then
  Begin
    Exit;
  End;

  If Not fValidaCampos(edtDescri) Then
  Begin
    Exit;
  End;

  If (cdsSaida.IsEmpty) Or (cdsEntrada.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar regras para entrada e saída!', ['&Ok']);
    Exit;
  End;

  pGravarRegrasDeAbreviacao;
  strUltimoCodigo := edtCodApc.Text;  
  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;

  pLimpaAutIncControle;

  dbgSaida.Enabled := True;
  dbgEntrada.Enabled := True;
  pnlSaida.Enabled := True;
  pnlEntrada.Enabled := True;

  btnCancelaEntrada.Click;
  btnCancelaSaida.Click;
end;

procedure TfrmCadAbreviacaoIPI.pGravarRegrasDeAbreviacao;
  Var
    qryCadastro: TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  fStartTransaction;

  Try
    fHabilitarForeignKey(False);
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('DELETE FROM IPISAI WHERE APC_CODAPC = :CODAPC');
    qryCadastro.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryCadastro.ExecSQL;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM IPISAI WHERE FALSE');
    qryCadastro.Open;

    cdsSaida.First;
    While (Not cdsSaida.Eof) Do
    Begin
      qryCadastro.Append;
      qryCadastro.FieldByName('APC_CODAPC').AsString := edtCodApc.Text;
      qryCadastro.FieldByName('APC_DESCRI').AsString := edtDescri.Text;
      qryCadastro.FieldByName('APC_CSTSAI').AsString := cdsSaida.FieldByName('APC_CSTSAI').AsString;
      qryCadastro.FieldByName('APC_ENQIPI').AsString := cdsSaida.FieldByName('APC_ENQIPI').AsString;
      qryCadastro.FieldByName('APC_BASSAI').AsFloat  := cdsSaida.FieldByName('APC_BASSAI').AsFloat;
      qryCadastro.FieldByName('APC_ALQSAI').AsFloat  := cdsSaida.FieldByName('APC_ALQSAI').AsFloat;
      qryCadastro.FieldByName('APC_CFOSAI').AsString := AnsiReplaceStr(cdsSaida.FieldByName('APC_CFOSAI').AsString, '-', '');
      qryCadastro.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('IPISAI', VS_strCodEmp);
      qryCadastro.Post;

      cdsSaida.Next;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('DELETE FROM IPIENT WHERE APC_CODAPC = :CODAPC');
    qryCadastro.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryCadastro.ExecSQL;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM IPIENT WHERE FALSE');
    qryCadastro.Open;

    cdsEntrada.First;
    While (Not cdsEntrada.Eof) Do
    Begin
      qryCadastro.Append;
      qryCadastro.FieldByName('APC_CODAPC').AsString := edtCodApc.Text;
      qryCadastro.FieldByName('APC_DESCRI').AsString := edtDescri.Text;
      qryCadastro.FieldByName('APC_CSTENT').AsString := cdsEntrada.FieldByName('APC_CSTENT').AsString;
      qryCadastro.FieldByName('APC_ENQIPI').AsString := cdsEntrada.FieldByName('APC_ENQIPI').AsString;
      qryCadastro.FieldByName('APC_BASENT').AsFloat  := cdsEntrada.FieldByName('APC_BASENT').AsFloat;
      qryCadastro.FieldByName('APC_ALQENT').AsFloat  := cdsEntrada.FieldByName('APC_ALQENT').AsFloat;
      qryCadastro.FieldByName('APC_CFOENT').AsString := AnsiReplaceStr(cdsEntrada.FieldByName('APC_CFOENT').AsString, '-', '');
      qryCadastro.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('IPIENT', VS_strCodEmp);
      qryCadastro.Post;

      cdsEntrada.Next;
    End;

    fHabilitarForeignKey(True);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fHabilitarForeignKey(True);
      fRollBack;
      pMensagensErro(E.Message, '[pGravarRegrasDeAbreviacao]');
    End;
  End;

  FreeAndNil(qryCadastro);
end;

procedure TfrmCadAbreviacaoIPI.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;

  pLimpaAutIncControle;
end;

procedure TfrmCadAbreviacaoIPI.btnPesquisaClick(Sender: TObject);
  Var
    qryConsulta: TUniQuery;
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;

  qryConsulta := fCriaQuery;
  chrKey := '?';
  If fPesqIPISai(Self, Nil, qryConsulta, chrKey, arrSel) Then
  Begin
    pCarregaDadosAbreviacao(qryConsulta.FieldByName('APC_CODAPC').AsString);
    blnInserindo := False;
    blnAlterando := False;

    pLimpaAutIncControle;

    dbgSaida.Enabled := True;
    dbgEntrada.Enabled := True;
    pnlSaida.Enabled := True;
    pnlEntrada.Enabled := True;
  End;

  FreeAndNil(qryConsulta);
end;

procedure TfrmCadAbreviacaoIPI.pCarregaDadosAbreviacao(strCodApc: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);
  qryDados.SQL.Add('SELECT * FROM IPISAI WHERE APC_CODAPC = :CODAPC');
  qryDados.ParamByName('CODAPC').AsString := strCodApc;
  qryDados.Open;

  edtCodApc.Text := qryDados.FieldByName('APC_CODAPC').AsString;
  edtDescri.Text := qryDados.FieldByName('APC_DESCRI').AsString;

  cdsSaida.EmptyDataSet;
  While (Not qryDados.Eof) Do
  Begin
    cdsSaida.Append;
    cdsSaida.FieldByName('APC_CSTSAI').AsString := qryDados.FieldByName('APC_CSTSAI').AsString;
    cdsSaida.FieldByName('APC_ENQIPI').AsString := qryDados.FieldByName('APC_ENQIPI').AsString;
    cdsSaida.FieldByName('APC_BASSAI').AsFloat  := qryDados.FieldByName('APC_BASSAI').AsFloat;
    cdsSaida.FieldByName('APC_ALQSAI').AsFloat  := qryDados.FieldByName('APC_ALQSAI').AsFloat;
    cdsSaida.FieldByName('APC_CFOSAI').AsString := fTransform(qryDados.FieldByName('APC_CFOSAI').AsString, 4, '-');
    cdsSaida.FieldByName('AUTOINCREM').AsString := qryDados.FieldByName('AUTOINCREM').AsString;
    cdsSaida.Post;
    qryDados.Next;
  End;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add('SELECT * FROM IPIENT WHERE APC_CODAPC = :CODAPC');
  qryDados.ParamByName('CODAPC').AsString := strCodApc;
  qryDados.Open;

  cdsEntrada.EmptyDataSet;
  While (Not qryDados.Eof) Do
  Begin
    cdsEntrada.Append;
    cdsEntrada.FieldByName('APC_CSTENT').AsString := qryDados.FieldByName('APC_CSTENT').AsString;
    cdsEntrada.FieldByName('APC_ENQIPI').AsString := qryDados.FieldByName('APC_ENQIPI').AsString;
    cdsEntrada.FieldByName('APC_BASENT').AsFloat  := qryDados.FieldByName('APC_BASENT').AsFloat;
    cdsEntrada.FieldByName('APC_ALQENT').AsFloat  := qryDados.FieldByName('APC_ALQENT').AsFloat;
    cdsEntrada.FieldByName('APC_CFOENT').AsString := fTransform(qryDados.FieldByName('APC_CFOENT').AsString, 4, '-');
    cdsEntrada.FieldByName('AUTOINCREM').AsString := qryDados.FieldByName('AUTOINCREM').AsString;
    cdsEntrada.Post;
    qryDados.Next;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmCadAbreviacaoIPI.cdsEntradaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtCstEntrada.Text  := cdsEntrada.FieldByName('APC_CSTENT').AsString;
  edtEnqIpiEnt.Text   := cdsEntrada.FieldByName('APC_ENQIPI').AsString;
  edtDesEnqIpiEnt.Text:= fRetDescricaoEnquadramentoIPI(edtEnqIpiEnt.Text);
  edtBaseEntrada.Text := FloatToStrF(cdsEntrada.FieldByName('APC_BASENT').AsFloat, ffNumber, 12, 2);
  edtAliqEntrada.Text := FloatToStrF(cdsEntrada.FieldByName('APC_ALQENT').AsFloat, ffNumber, 12, 2);
  mskCfopEntrada.Text := cdsEntrada.FieldByName('APC_CFOENT').AsString;

  If cdsEntrada.FieldByName('AUTOINCREM').AsString <> strAutIncEnt Then
    strAutIncEnt := '';
  pHabilitaParaEdicaoEntrada;
end;

procedure TfrmCadAbreviacaoIPI.cdsSaidaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtCstSaida.Text   := cdsSaida.FieldByName('APC_CSTSAI').AsString;
  edtEnqIpiSai.Text  := cdsSaida.FieldByName('APC_ENQIPI').AsString;
  edtDesEnqIpiSai.Text:= fRetDescricaoEnquadramentoIPI(edtEnqIpiSai.Text);
  edtBaseSaida.Text  := FloatToStrF(cdsSaida.FieldByName('APC_BASSAI').AsFloat, ffNumber, 12, 2);
  edtAliqSaida.Text  := FloatToStrF(cdsSaida.FieldByName('APC_ALQSAI').AsFloat, ffNumber, 12, 2);
  mskCfopSaida.Text  := cdsSaida.FieldByName('APC_CFOSAI').AsString;

  If cdsSaida.FieldByName('AUTOINCREM').AsString <> strAutIncSai Then
    strAutIncSai := '';
  pHabilitaParaEdicaoSaida;
end;

procedure TfrmCadAbreviacaoIPI.dbgEntradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If (fEmptyStr(edtCodApc.Text)) Then
      Exit;

    pComecaEdicaoDoRegistro;
    strAutIncEnt := cdsEntrada.FieldByName('AUTOINCREM').AsString;

    cdsEntradaAfterScroll(cdsEntrada);

    pSetFocus(edtCstEntrada);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not cdsEntrada.IsEmpty) Then
      cdsEntrada.Delete;

    pComecaEdicaoDoRegistro;
  End;
end;

procedure TfrmCadAbreviacaoIPI.pComecaEdicaoDoRegistro;
begin
  If (Not blnInserindo) Then
    blnAlterando := True;

  pHabilitar(False);

  pnlSaida.Enabled := True;
  dbgSaida.Enabled := True;
  pnlEntrada.Enabled := True;
  dbgEntrada.Enabled := True;

  pHabilitaParaEdicaoSaida;
  pHabilitaParaEdicaoEntrada;
end;

procedure TfrmCadAbreviacaoIPI.dbgSaidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If (fEmptyStr(edtCodApc.Text)) Then
      Exit;
      
    If (Not blnInserindo) Then
      blnAlterando := True;

    pComecaEdicaoDoRegistro;
    strAutIncSai := cdsSaida.FieldByName('AUTOINCREM').AsString;

    cdsSaidaAfterScroll(cdsSaida);

    pSetFocus(edtCstSaida);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not cdsSaida.IsEmpty) Then
      cdsSaida.Delete;

    pComecaEdicaoDoRegistro;
  End;
end;

procedure TfrmCadAbreviacaoIPI.edtCstEntradaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTIPI(Self, edtCstEntrada, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadAbreviacaoIPI.edtCstSaidaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqCSTIPI(Self, edtCstSaida, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadAbreviacaoIPI.edtEnqIpiEntKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqEnquadramentoIPI(Self, edtEnqIpiEnt, edtDesEnqIpiEnt, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAbreviacaoIPI.edtEnqIpiSaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqEnquadramentoIPI(Self, edtEnqIpiSai, edtDesEnqIpiSai, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadAbreviacaoIPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodApc) Then
  Begin
    If fEmptyStr(edtCodApc.Text) Then
    Begin
      fMensagem('', 'O código da abreviação deve ser preenchido.', ['&Ok']);
      Result := False;
    End
    Else If (fAbreviacaoIPIExiste(edtCodApc.Text)) And (Not blnAlterando) Then
    Begin
      fMensagem('', 'Já existe uma abreviação com esses dados.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDescri) Then
  Begin
    If fEmptyStr(edtDescri.Text) Then
    Begin
      fMensagem('', 'A descrição da abreviação deve ser preenchida.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEnqIpiSai) Then
  Begin
    edtDesEnqIpiSai.Text := fRetDescricaoEnquadramentoIPI(edtEnqIpiSai.Text);

    If (fEmptyStr(edtEnqIpiSai.Text)) And (blnBuscaPorChave) Then
    Begin
      fMensagem('', 'É necessário informar o código de enquadramento de IPI.', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr(edtDesEnqIpiSai.Text)) And (blnBuscaPorChave) Then
    Begin
      fMensagem('', 'Código de enquadramento de IPI inválido.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEnqIpiEnt) Then
  Begin
    edtDesEnqIpiEnt.Text := fRetDescricaoEnquadramentoIPI(edtEnqIpiEnt.Text);

    If (fEmptyStr(edtEnqIpiEnt.Text)) And (blnBuscaPorChave) Then
    Begin
      fMensagem('', 'É necessário informar o código de enquadramento de IPI.', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr(edtDesEnqIpiEnt.Text)) And (blnBuscaPorChave) Then
    Begin
      fMensagem('', 'Código de enquadramento de IPI inválido.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtCstSaida) Then
  Begin
    If (fEmptyStr(edtCstSaida.Text)) And (blnBuscaPorChave) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(dbgSaida);
    End
    Else If (Not fCstPisValida(edtCstSaida.Text)) Then
    Begin
      fMensagem('', 'É necessário informar uma CST válida.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtBaseSaida) Then
  Begin
    If fEmptyStr(edtBaseSaida.Text) Then
    Begin
      edtBaseSaida.Text := '0,00';
    End
    Else IF (fStrToFloat(edtBaseSaida.Text) < 0) Or (fStrToFloat(edtBaseSaida.Text) > 100) Then
    Begin
      fMensagem('', 'O percentual de base deve estar entre 0 e 100.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtAliqSaida) Then
  Begin
    If fEmptyStr(edtAliqSaida.Text) Then
    Begin
      edtAliqSaida.Text := '0,00';
    End
    Else IF (fStrToFloat(edtBaseSaida.Text) > 0) And (fStrToFloat(edtAliqSaida.Text) <= 0) Then
    Begin
      fMensagem('', 'Se a base for maior que zero, a alíquota deve ser informada!', ['&Ok']);
      Result := False;
    End
    Else IF (fStrToFloat(edtAliqSaida.Text) < 0) Or (fStrToFloat(edtAliqSaida.Text) > 100) Then
    Begin
      fMensagem('', 'A alíquota deve estar entre 0 e 100.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskCfopSaida) Then
  Begin
    If fEmptyStr(AnsiReplaceStr(mskCfopSaida.Text, '-', '')) Then
    Begin
      fMensagem('', 'É necessário informar pelo menos uma CFOP.', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaCfops(mskCfopSaida.Text)) Then
    Begin
      Result := False;
    End;
  End

  Else If (Sender = edtCstEntrada) Then
  Begin
    If (fEmptyStr(edtCstEntrada.Text)) And (blnBuscaPorChave) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(dbgEntrada);
    End
    Else If (Not fCstPisValida(edtCstEntrada.Text)) Then
    Begin
      fMensagem('', 'É necessário informar uma CST válida.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtBaseEntrada) Then
  Begin
    If fEmptyStr(edtBaseEntrada.Text) Then
    Begin
      edtBaseEntrada.Text := '0,00';
    End
    Else IF (fStrToFloat(edtBaseEntrada.Text) < 0) Or (fStrToFloat(edtBaseEntrada.Text) > 100) Then
    Begin
      fMensagem('', 'O percentual de base deve estar entre 0 e 100.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtAliqEntrada) Then
  Begin
    If fEmptyStr(edtAliqEntrada.Text) Then
    Begin
      edtAliqEntrada.Text := '0,00';
    End
    Else IF (fStrToFloat(edtBaseEntrada.Text) > 0) And (fStrToFloat(edtAliqEntrada.Text) <= 0) Then
    Begin
      fMensagem('', 'Se a base for maior que zero, a alíquota deve ser informada!', ['&Ok']);
      Result := False;
    End
    Else IF (fStrToFloat(edtAliqEntrada.Text) < 0) Or (fStrToFloat(edtAliqEntrada.Text) > 100) Then
    Begin
      fMensagem('', 'A alíquota deve estar entre 0 e 100.', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskCfopEntrada) Then
  Begin
    If fEmptyStr(AnsiReplaceStr(mskCfopEntrada.Text, '-', '')) Then
    Begin
      fMensagem('', 'É necessário informar pelo menos uma CFOP.', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaCfops(mskCfopEntrada.Text)) Then
    Begin
      Result := False;
    End;
  End;


  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAbreviacaoIPI.fCstPisValida(strCst: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CSTIPI WHERE CST_CODCST = :CODCST');
  qryAux.ParamByName('CODCST').AsString := strCst;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

function TfrmCadAbreviacaoIPI.fGeraAutoIncremTmp: String;
begin
  Result := FloatToStr(Int(fTime()*10000000000));
end;

procedure TfrmCadAbreviacaoIPI.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadAbreviacaoIPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (btnGravar.Enabled) Then
  Begin
    If fMensagem('', 'Deseja cancelar essa operação?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      btnCancela.Click;
    End;
    Action := caNone;
  End;
end;

procedure TfrmCadAbreviacaoIPI.FormCreate(Sender: TObject);
begin
  inherited;
  cdsSaida.CreateDataSet;
  cdsEntrada.CreateDataSet;

  pHabilitar(True);

  pLimpaAutIncControle;
end;

procedure TfrmCadAbreviacaoIPI.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadAbreviacaoIPI.fValidaCfops(strCfops: string): Boolean;
  Var
    stlCfops: TStringList;
    strCfop: String;
    strCfopNaoCad: String;
begin
  Result := True;
  strCfopNaoCad := '';

  stlCfops := TStringList.Create;
  stlCfops.Delimiter := '-';
  stlCfops.DelimitedText := strCfops;

  For strCfop In stlCfops Do
  Begin
    If (Not fEmptyStr(strCfop)) And (Not fCfopCadastrada(strCfop)) Then
      strCfopNaoCad := strCfopNaoCad + strCfop + ',';
  End;

  FreeAndNil(stlCfops);

  If Not fEmptyStr(strCfopNaoCad) Then
  Begin
    strCfopNaoCad := LeftStr(strCfopNaoCad, Length(strCfopNaoCad)-1);
    fMensagem('', 'As seguintes CFOPs não estão cadastradas: ' + strCfopNaoCad, ['&Ok']);
    Result := False;
  End;
end;

procedure TfrmCadAbreviacaoIPI.mskCfopSaidaEnter(Sender: TObject);
begin
  inherited;
  TMaskEditFocus(Sender).SelStart  := 0;
  TMaskEditFocus(Sender).SelLength := 4;
end;

function TfrmCadAbreviacaoIPI.fCfopCadastrada(strCfop: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CADCFO WHERE CFO_CODCFO = :CODCFO');
  qryAux.ParamByName('CODCFO').AsString := strCfop;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

function TfrmCadAbreviacaoIPI.fAbreviacaoIPIExiste(strCod: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM IPISAI WHERE APC_CODAPC = :CODAPC');
  qryAux.ParamByName('CODAPC').AsString := strCod;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

procedure TfrmCadAbreviacaoIPI.pHabilitaParaEdicaoEntrada;
  Var
   blnHabil: Boolean;
begin
  blnHabil := (fEmptyStr(strAutIncEnt) And fEmptyStr(edtCstEntrada.Text)) Or
              ((Not fEmptyStr(strAutIncEnt)) And (cdsEntrada.FieldByName('AUTOINCREM').AsString = strAutIncEnt));

  pEnableConjuntoControles(gpbEntrada, blnHabil, [TEditFocus, TMaskEditFocus], []);
end;

procedure TfrmCadAbreviacaoIPI.pHabilitaParaEdicaoSaida;
  Var
   blnHabil: Boolean;
begin
  blnHabil := (fEmptyStr(strAutIncSai) And fEmptyStr(edtCstSaida.Text)) Or
              ((Not fEmptyStr(strAutIncSai)) And (cdsSaida.FieldByName('AUTOINCREM').AsString = strAutIncSai));

  pEnableConjuntoControles(gpbSaida, blnHabil, [TEditFocus, TMaskEditFocus], []);
end;

procedure TfrmCadAbreviacaoIPI.pLimpaAutIncControle;
begin
  strAutIncSai := '';
  strAutIncEnt := '';
end;

procedure TfrmCadAbreviacaoIPI.pHabilitar(blnHabilitar: Boolean);
begin
  btnIncluir.Enabled := blnHabilitar;
  btnGravar.Enabled := Not blnHabilitar;
  btnExcluir.Enabled := blnHabilitar;
  btnCancela.Enabled := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  pnlGeral.Enabled := Not blnHabilitar;

  If Not blnHabilitar Then
  Begin
    pLimpaAutIncControle;
  End;
end;

procedure TfrmCadAbreviacaoIPI.pLimparTela;
begin
  cdsSaida.EmptyDataSet;
  cdsEntrada.EmptyDataSet;

  edtCodApc.Clear;
  edtDescri.Clear;

  pLimparDadosSaida;
  pLimparDadosEntrada;

  pSetFocus(edtCodApc);
end;

procedure TfrmCadAbreviacaoIPI.pLimparDadosSaida;
begin
  edtCstSaida.Clear;
  edtEnqIpiSai.Clear;
  edtDesEnqIpiSai.Clear;
  edtBaseSaida.Text := '0,00';
  edtAliqSaida.Text := '0,00';
  mskCfopSaida.Clear;

  strAutIncSai := '';

  pHabilitaParaEdicaoSaida;
end;

procedure TfrmCadAbreviacaoIPI.pLimparDadosEntrada;
begin
  edtCstEntrada.Clear;
  edtEnqIpiEnt.Clear;
  edtDesEnqIpiEnt.Clear;
  edtBaseEntrada.Text := '0,00';
  edtAliqEntrada.Text := '0,00';
  mskCfopEntrada.Clear;

  strAutIncEnt := '';

  pHabilitaParaEdicaoEntrada;
end;

{*******************************************}
{* ESSA FUNÇÃO NÃO DEVE MAIS SER UTILIZADA,*}
{* POIS CAUSA PROBLEMA NA REPLICAÇÃO       *}
{*******************************************}
{* HABILITA DESABILITA VERIFICAÇÃO DE      *}
{* CHAVE ESTRANGEIRA (DESCOBERTO PELO      *}
{* EDUARDO)                                *}
{****************************************MV*}
function TfrmCadAbreviacaoIPI.fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    Try

      With qryGenTmp Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add('SET FOREIGN_KEY_CHECKS=' + IIF(blnHabilitar, '1', '0'));
        ExecSQL;
        Close;
        Result := True;

      End;

    Except
      On E: Exception Do
      Begin

        Result := False;
        pMensagensErro(E.Message, '[fHabilitarForeignKey]');

      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

end.

