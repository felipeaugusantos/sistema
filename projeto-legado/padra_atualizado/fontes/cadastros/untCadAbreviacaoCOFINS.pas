unit untCadAbreviacaoCOFINS;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, ExtCtrls,
  DBGridCitel, DBGrids, EditFocus, MaskEditFocus, DB, UniClientDataSet, Uni, BitBtnLockedIncrem,
  Mask, Grids, Buttons, frxClass, frxExportCSVTestabilidade, untConsultas, untTypesSistema,
  Datasnap.DBClient, untAbreviacoes;

type
  TfrmCadAbreviacaoCOFINS = class(TfrmPai)
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
    cdsSaidaAPC_BASSAI: TFloatField;
    cdsSaidaAPC_ALQSAI: TFloatField;
    cdsSaidaAPC_CFOSAI: TStringField;
    cdsSaidaAPC_MOTISE: TStringField;
    dtsEntrada: TDataSource;
    cdsEntrada: TUniClientDataSet;
    cdsEntradaAPC_CSTENT: TStringField;
    cdsEntradaAPC_BASENT: TFloatField;
    cdsEntradaAPC_ALQENT: TFloatField;
    cdsEntradaAPC_CFOENT: TStringField;
    pnlSaida: TPanel;
    gpbSaida: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    edtCstSaida: TEditFocus;
    edtBaseSaida: TEditFocus;
    edtAliqSaida: TEditFocus;
    mskCfopSaida: TMaskEditFocus;
    edtMotivoIsen: TEditFocus;
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
    cdsSaidaAUTOINCREM: TStringField;
    cdsEntradaAUTOINCREM: TStringField;
    Label12: TLabel;
    mskVigenciaSai: TMaskEditFocus;
    Label13: TLabel;
    mskVigenciaEnt: TMaskEditFocus;
    cdsSaidaAPC_VIGENC: TDateField;
    cdsEntradaAPC_VIGENC: TDateField;
    btnPesquisa: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnCopiarPIS: TBitBtnLocked;
    btnPreCadastramentoPadrao: TBitBtnLocked;
    btnConfirmaSaida: TBitBtnLocked;
    btnCancelaSaida: TBitBtnLocked;
    btnConfirmaEntrada: TBitBtnLocked;
    btnCancelaEntrada: TBitBtnLocked;
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
    procedure btnPreCadastramentoPadraoClick(Sender: TObject);
    procedure btnCopiarPISClick(Sender: TObject);
    procedure mskVigenciaSaiKeyPress(Sender: TObject; var Key: Char);
    procedure cdsSaidaAPC_VIGENCGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
    function fValidaCfops(strCfops: string): Boolean;
    function fCfopCadastrada(strCfop: String): Boolean;
    function fAbreviacaoCOFExiste(strCod: String): Boolean;
    procedure pCarregaDadosAbreviacao(strCodApc: String);
    procedure pComecaEdicaoDoRegistro;
    function fGeraAutoIncremTmp: String;
    function fDataStr(dtaData: TDateTime): String;
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

uses SysUtils, StrUtils, untFuncoesSimples, untFuncoes, untGeralPisCofins, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmCadAbreviacaoCOFINS.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadAbreviacaoCOFINS.btnCancelaEntradaClick(Sender: TObject);
begin
  inherited;
  pLimparDadosEntrada;
  pSetFocus(edtCstEntrada);
end;

procedure TfrmCadAbreviacaoCOFINS.btnCancelaSaidaClick(Sender: TObject);
begin
  inherited;
  pLimparDadosSaida;
  pSetFocus(edtCstSaida);
end;

procedure TfrmCadAbreviacaoCOFINS.btnConfirmaEntradaClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  cdsEntrada.AfterScroll := Nil;
  If (Not fEmptyStr(edtCodApc.Text)  And
      fValidaCampos(edtCstEntrada)   And
      fValidaCampos(edtBaseEntrada)  And
      fValidaCampos(edtAliqEntrada)  And
      fValidaCampos(mskVigenciaEnt)  And
      fValidaCampos(mskCfopEntrada)  And
      fAbreviacaoCfopExiste(cdsEntrada, mskCfopEntrada.Text, 'ENT', edtCstEntrada.Text) And
      (Not fCSTJaCadastrada(cdsEntrada, edtCstEntrada.Text, strAutIncEnt, StrToDateDef(mskVigenciaEnt.Text, 0)))) Then
  Begin
    If (Not fEmptyStr(strAutIncEnt))                     And
       (cdsEntrada.Locate('AUTOINCREM', strAutIncEnt, [])) Then
    Begin
      cdsEntrada.Edit;
    End
    Else
      cdsEntrada.Append;

    cdsEntrada.FieldByName('APC_CSTENT').AsString := edtCstEntrada.Text;
    cdsEntrada.FieldByName('APC_BASENT').AsFloat := fStrToFloat(edtBaseEntrada.Text);
    cdsEntrada.FieldByName('APC_ALQENT').AsFloat := fStrToFloat(edtAliqEntrada.Text);
    cdsEntrada.FieldByName('APC_VIGENC').AsDateTime := StrToDateDef(mskVigenciaEnt.Text, 0);
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

procedure TfrmCadAbreviacaoCOFINS.btnConfirmaSaidaClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  cdsSaida.AfterScroll := Nil;

  If (Not fEmptyStr(edtCodApc.Text)And
      fValidaCampos(edtCstSaida)   And
      fValidaCampos(edtBaseSaida)  And
      fValidaCampos(edtAliqSaida)  And
      fValidaCampos(mskVigenciaSai)And
      fValidaCampos(edtMotivoIsen) And
      fValidaCampos(mskCfopSaida)  And
      fAbreviacaoCfopExiste(cdsSaida, mskCfopSaida.Text, 'SAI', edtCstSaida.Text) And
      (Not fCSTJaCadastrada(cdsSaida, edtCstSaida.Text, strAutIncSai, StrToDateDef(mskVigenciaSai.Text, 0)))) Then
  Begin
    If (Not fEmptyStr(strAutIncSai))                     And
       (cdsSaida.Locate('AUTOINCREM', strAutIncSai, [])) Then
    Begin
      cdsSaida.Edit;
    End
    Else
      cdsSaida.Append;

    cdsSaida.FieldByName('APC_CSTSAI').AsString := edtCstSaida.Text;
    cdsSaida.FieldByName('APC_BASSAI').AsFloat := fStrToFloat(edtBaseSaida.Text);
    cdsSaida.FieldByName('APC_ALQSAI').AsFloat := fStrToFloat(edtAliqSaida.Text);
    cdsSaida.FieldByName('APC_VIGENC').AsDateTime := StrToDateDef(mskVigenciaSai.Text, 0);
    cdsSaida.FieldByName('APC_CFOSAI').AsString := mskCfopSaida.Text;
    cdsSaida.FieldByName('APC_MOTISE').AsString := edtMotivoIsen.Text;
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

function TfrmCadAbreviacaoCOFINS.fGeraAutoIncremTmp: String;
begin
  Result := FloatToStr(Int(fTime()*10000000000));
end;

procedure TfrmCadAbreviacaoCOFINS.btnCopiarPISClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  If (fEmptyStr(edtCodApc.Text)) Or (btnGravar.Enabled) Then
    Exit;

  pCopiarAbreviacaoCofinsParaPis(edtCodApc.Text);
end;

procedure TfrmCadAbreviacaoCOFINS.btnExcluirClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

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

procedure TfrmCadAbreviacaoCOFINS.pExcluirRegrasDeAbreviacao;
  Var
    qryDel: TUniQuery;
begin
  fStartTransaction;

  Try
    qryDel := fCriaQuery(Self);
    qryDel.SQL.Add('DELETE FROM COFSAI WHERE APC_CODAPC = :CODAPC');
    qryDel.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryDel.ExecSQL;

    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM COFENT WHERE APC_CODAPC = :CODAPC');
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

procedure TfrmCadAbreviacaoCOFINS.btnGravarClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

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

procedure TfrmCadAbreviacaoCOFINS.pGravarRegrasDeAbreviacao;
  Var
    qryCadastro: TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  fStartTransaction;

  Try
    fHabilitarForeignKey(False);
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('DELETE FROM COFSAI WHERE APC_CODAPC = :CODAPC');
    qryCadastro.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryCadastro.ExecSQL;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COFSAI WHERE FALSE');
    qryCadastro.Open;

    cdsSaida.First;
    While (Not cdsSaida.Eof) Do
    Begin
      qryCadastro.Append;
      qryCadastro.FieldByName('APC_CODAPC').AsString := edtCodApc.Text;
      qryCadastro.FieldByName('APC_DESCRI').AsString := edtDescri.Text;
      qryCadastro.FieldByName('APC_CSTSAI').AsString := cdsSaida.FieldByName('APC_CSTSAI').AsString;
      qryCadastro.FieldByName('APC_BASSAI').AsFloat  := cdsSaida.FieldByName('APC_BASSAI').AsFloat;
      qryCadastro.FieldByName('APC_ALQSAI').AsFloat  := cdsSaida.FieldByName('APC_ALQSAI').AsFloat;
      qryCadastro.FieldByName('APC_VIGENC').AsDateTime := cdsSaida.FieldByName('APC_VIGENC').AsDateTime;
      qryCadastro.FieldByName('APC_CFOSAI').AsString := AnsiReplaceStr(cdsSaida.FieldByName('APC_CFOSAI').AsString, '-', '');
      qryCadastro.FieldByName('APC_MOTISE').AsString := cdsSaida.FieldByName('APC_MOTISE').AsString;
      qryCadastro.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COFSAI', VS_strCodEmp);
      qryCadastro.Post;

      cdsSaida.Next;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('DELETE FROM COFENT WHERE APC_CODAPC = :CODAPC');
    qryCadastro.ParamByName('CODAPC').AsString := edtCodApc.Text;
    qryCadastro.ExecSQL;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COFENT WHERE FALSE');
    qryCadastro.Open;

    cdsEntrada.First;
    While (Not cdsEntrada.Eof) Do
    Begin
      qryCadastro.Append;
      qryCadastro.FieldByName('APC_CODAPC').AsString := edtCodApc.Text;
      qryCadastro.FieldByName('APC_DESCRI').AsString := edtDescri.Text;
      qryCadastro.FieldByName('APC_CSTENT').AsString := cdsEntrada.FieldByName('APC_CSTENT').AsString;
      qryCadastro.FieldByName('APC_BASENT').AsFloat  := cdsEntrada.FieldByName('APC_BASENT').AsFloat;
      qryCadastro.FieldByName('APC_ALQENT').AsFloat  := cdsEntrada.FieldByName('APC_ALQENT').AsFloat;
      qryCadastro.FieldByName('APC_VIGENC').AsDateTime := cdsEntrada.FieldByName('APC_VIGENC').AsDateTime;
      qryCadastro.FieldByName('APC_CFOENT').AsString := AnsiReplaceStr(cdsEntrada.FieldByName('APC_CFOENT').AsString, '-', '');
      qryCadastro.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COFENT', VS_strCodEmp);
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

procedure TfrmCadAbreviacaoCOFINS.btnIncluirClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;

  pLimpaAutIncControle;
end;

procedure TfrmCadAbreviacaoCOFINS.btnPesquisaClick(Sender: TObject);
  Var
    qryConsulta: TUniQuery;
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;

  qryConsulta := fCriaQuery;
  chrKey := '?';
  If fPesqCofSai(Self, Nil, Nil, qryConsulta, chrKey, arrSel) Then
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

procedure TfrmCadAbreviacaoCOFINS.btnPreCadastramentoPadraoClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(217, 7692, [],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmCadAbreviacaoCOFINS.pCarregaDadosAbreviacao(strCodApc: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);
  qryDados.SQL.Add('SELECT * FROM COFSAI WHERE APC_CODAPC = :CODAPC');
  qryDados.ParamByName('CODAPC').AsString := strCodApc;
  qryDados.Open;

  edtCodApc.Text := qryDados.FieldByName('APC_CODAPC').AsString;
  edtDescri.Text := qryDados.FieldByName('APC_DESCRI').AsString;

  cdsSaida.EmptyDataSet;
  While (Not qryDados.Eof) Do
  Begin
    cdsSaida.Append;
    cdsSaida.FieldByName('APC_CSTSAI').AsString := qryDados.FieldByName('APC_CSTSAI').AsString;
    cdsSaida.FieldByName('APC_BASSAI').AsFloat  := qryDados.FieldByName('APC_BASSAI').AsFloat;
    cdsSaida.FieldByName('APC_ALQSAI').AsFloat  := qryDados.FieldByName('APC_ALQSAI').AsFloat;
    cdsSaida.FieldByName('APC_VIGENC').AsDateTime  := qryDados.FieldByName('APC_VIGENC').AsDateTime;
    cdsSaida.FieldByName('APC_CFOSAI').AsString := fTransform(qryDados.FieldByName('APC_CFOSAI').AsString, 4, '-');
    cdsSaida.FieldByName('APC_MOTISE').AsString := qryDados.FieldByName('APC_MOTISE').AsString;
    cdsSaida.FieldByName('AUTOINCREM').AsString := qryDados.FieldByName('AUTOINCREM').AsString;
    cdsSaida.Post;
    qryDados.Next;
  End;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add('SELECT * FROM COFENT WHERE APC_CODAPC = :CODAPC');
  qryDados.ParamByName('CODAPC').AsString := strCodApc;
  qryDados.Open;

  cdsEntrada.EmptyDataSet;
  While (Not qryDados.Eof) Do
  Begin
    cdsEntrada.Append;
    cdsEntrada.FieldByName('APC_CSTENT').AsString := qryDados.FieldByName('APC_CSTENT').AsString;
    cdsEntrada.FieldByName('APC_BASENT').AsFloat  := qryDados.FieldByName('APC_BASENT').AsFloat;
    cdsEntrada.FieldByName('APC_ALQENT').AsFloat  := qryDados.FieldByName('APC_ALQENT').AsFloat;
    cdsEntrada.FieldByName('APC_VIGENC').AsDateTime  := qryDados.FieldByName('APC_VIGENC').AsDateTime;
    cdsEntrada.FieldByName('APC_CFOENT').AsString := fTransform(qryDados.FieldByName('APC_CFOENT').AsString, 4, '-');
    cdsEntrada.FieldByName('AUTOINCREM').AsString := qryDados.FieldByName('AUTOINCREM').AsString;
    cdsEntrada.Post;
    qryDados.Next;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmCadAbreviacaoCOFINS.cdsEntradaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtCstEntrada.Text  := cdsEntrada.FieldByName('APC_CSTENT').AsString;
  edtBaseEntrada.Text := FloatToStrF(cdsEntrada.FieldByName('APC_BASENT').AsFloat, ffNumber, 12, 2);
  edtAliqEntrada.Text := FloatToStrF(cdsEntrada.FieldByName('APC_ALQENT').AsFloat, ffNumber, 12, 4);
  mskVigenciaEnt.Text := fDataStr(cdsEntrada.FieldByName('APC_VIGENC').AsDateTime);
  mskCfopEntrada.Text := cdsEntrada.FieldByName('APC_CFOENT').AsString;

  If cdsEntrada.FieldByName('AUTOINCREM').AsString <> strAutIncEnt Then
    strAutIncEnt := '';
  pHabilitaParaEdicaoEntrada;
end;

procedure TfrmCadAbreviacaoCOFINS.cdsSaidaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtCstSaida.Text   := cdsSaida.FieldByName('APC_CSTSAI').AsString;
  edtBaseSaida.Text  := FloatToStrF(cdsSaida.FieldByName('APC_BASSAI').AsFloat, ffNumber, 12, 2);
  edtAliqSaida.Text  := FloatToStrF(cdsSaida.FieldByName('APC_ALQSAI').AsFloat, ffNumber, 12, 4);
  mskVigenciaSai.Text := fDataStr(cdsSaida.FieldByName('APC_VIGENC').AsDateTime);
  mskCfopSaida.Text  := cdsSaida.FieldByName('APC_CFOSAI').AsString;
  edtMotivoIsen.Text := cdsSaida.FieldByName('APC_MOTISE').AsString;

  If cdsSaida.FieldByName('AUTOINCREM').AsString <> strAutIncSai Then
    strAutIncSai := '';
  pHabilitaParaEdicaoSaida;
end;

procedure TfrmCadAbreviacaoCOFINS.cdsSaidaAPC_VIGENCGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  If Sender.AsDateTime <= 0 Then
    Text := ''
  Else
    Text := FormatDateTime('dd/mm/yyyy', Sender.AsDateTime);
end;

function TfrmCadAbreviacaoCOFINS.fDataStr(dtaData: TDateTime): String;
begin
  If dtaData <= 0 Then
    Result := ''
  Else
    Result := DateToStr(dtaData);
end;

procedure TfrmCadAbreviacaoCOFINS.dbgEntradaKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadAbreviacaoCOFINS.pComecaEdicaoDoRegistro;
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

procedure TfrmCadAbreviacaoCOFINS.dbgSaidaKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadAbreviacaoCOFINS.edtCstEntradaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTCof(Self, edtCstEntrada, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadAbreviacaoCOFINS.edtCstSaidaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqCSTCof(Self, edtCstSaida, Nil, Nil, Key, arrSel);
end;

function TfrmCadAbreviacaoCOFINS.fValidaCampos(Sender: TWinControl;
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
    Else If (fAbreviacaoCOFExiste(edtCodApc.Text)) And (Not blnAlterando) Then
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

  Else If (Sender = edtCstSaida) Then
  Begin
    If (fEmptyStr(edtCstSaida.Text)) And (blnBuscaPorChave) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(dbgSaida);
    End
    Else If (Not fCstCofValida(edtCstSaida.Text)) Then
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
    End
    Else If (Pos(edtCstSaida.Text, '05_07_08_09_70_71_72_74') > 0) And
            (fStrToFloat(edtBaseSaida.Text) > 0) Then
    Begin
      edtBaseSaida.Text := '0,00';
      fMensagem('', 'Essa CST só permite base de COFINS zerada', ['&Ok']);
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
    End
    Else If (Pos(edtCstSaida.Text, '04_07_08_09_70_71_72_74') > 0) And
            (fStrToFloat(edtAliqSaida.Text) > 0) Then
    Begin
      edtAliqSaida.Text := '0,00';
      fMensagem('', 'Essa CST só permite alíquota de COFINS zerada', ['&Ok']);
    End;
  End

  Else If (Sender = mskVigenciaSai) Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskVigenciaSai.Text)) Then
    Begin
      If StrToDateDef(mskVigenciaSai.Text, 0) < StrToDate('01/01/2000') Then
      Begin
        fMensagem('', 'A vigência deve ser maior ou igual a 01/01/2000.', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtMotivoIsen) Then
  Begin
    If Not fEmptyStr(edtMotivoIsen.Text) then
    Begin
      If Length(edtMotivoIsen.Text) <> 3 Then
      Begin
        fMensagem('', 'A natureza da receita deve ser um código de 3 dígitos.', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      If StrToIntDef(edtCstSaida.Text,0) in [2..9] Then
      Begin
        fMensagem('', 'É necessário preencher a Natureza da Receita quando CST estiver entre "02" e "09".' + #13#10 +
                      'Favor consultar a contabilidade e/ou o manual de configuração do SPED PIS/COFINS.', ['&Ok']);
        Result := False;
      End
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
    Else If (Not fCstCofValida(edtCstEntrada.Text)) Then
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

procedure TfrmCadAbreviacaoCOFINS.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadAbreviacaoCOFINS.FormClose(Sender: TObject;
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

procedure TfrmCadAbreviacaoCOFINS.FormCreate(Sender: TObject);
begin
  inherited;
  cdsSaida.CreateDataSet;
  cdsEntrada.CreateDataSet;

  pHabilitar(True);

  pLimpaAutIncControle;
end;

procedure TfrmCadAbreviacaoCOFINS.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadAbreviacaoCOFINS.fValidaCfops(strCfops: string): Boolean;
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

procedure TfrmCadAbreviacaoCOFINS.mskVigenciaSaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (blnAlterando) Or (blnInserindo) Then
  Begin
    Exit;
  End;

  blnAlterando := True;
  pComecaEdicaoDoRegistro;
end;

function TfrmCadAbreviacaoCOFINS.fCfopCadastrada(strCfop: String): Boolean;
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

function TfrmCadAbreviacaoCOFINS.fAbreviacaoCOFExiste(strCod: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM COFSAI WHERE APC_CODAPC = :CODAPC');
  qryAux.ParamByName('CODAPC').AsString := strCod;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

procedure TfrmCadAbreviacaoCOFINS.pHabilitaParaEdicaoEntrada;
  Var
   blnHabil: Boolean;
begin
  blnHabil := (fEmptyStr(strAutIncEnt) And fEmptyStr(edtCstEntrada.Text)) Or
              ((Not fEmptyStr(strAutIncEnt)) And (cdsEntrada.FieldByName('AUTOINCREM').AsString = strAutIncEnt));

  pEnableConjuntoControles(gpbEntrada, blnHabil, [TEditFocus, TMaskEditFocus], []);
end;

procedure TfrmCadAbreviacaoCOFINS.pHabilitaParaEdicaoSaida;
  Var
   blnHabil: Boolean;
begin
  blnHabil := (fEmptyStr(strAutIncSai) And fEmptyStr(edtCstSaida.Text)) Or
              ((Not fEmptyStr(strAutIncSai)) And (cdsSaida.FieldByName('AUTOINCREM').AsString = strAutIncSai));

  pEnableConjuntoControles(gpbSaida, blnHabil, [TEditFocus, TMaskEditFocus], []);
end;

procedure TfrmCadAbreviacaoCOFINS.pLimpaAutIncControle;
begin
  strAutIncSai := '';
  strAutIncEnt := '';
end;

procedure TfrmCadAbreviacaoCOFINS.pHabilitar(blnHabilitar: Boolean);
begin
  btnIncluir.Enabled := blnHabilitar;
  btnGravar.Enabled := Not blnHabilitar;
  btnExcluir.Enabled := blnHabilitar;
  btnCancela.Enabled := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

//  pnlGeral.Enabled := Not blnHabilitar;
  edtCodApc.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;
  btnPreCadastramentoPadrao.Enabled := Not blnHabilitar;

  If Not blnHabilitar Then
  Begin
    pLimpaAutIncControle;
  End;
end;

procedure TfrmCadAbreviacaoCOFINS.pLimparTela;
begin
  cdsSaida.EmptyDataSet;
  cdsEntrada.EmptyDataSet;

  edtCodApc.Clear;
  edtDescri.Clear;

  pLimparDadosSaida;
  pLimparDadosEntrada;

  pSetFocus(edtCodApc);
end;

procedure TfrmCadAbreviacaoCOFINS.pLimparDadosSaida;
begin
  edtCstSaida.Clear;
  edtBaseSaida.Text := '0,00';
  edtAliqSaida.Text := '0,00';
  mskVigenciaSai.Clear;
  edtMotivoIsen.Clear;
  mskCfopSaida.Clear;

  strAutIncSai := '';

  pHabilitaParaEdicaoSaida;
end;

procedure TfrmCadAbreviacaoCOFINS.pLimparDadosEntrada;
begin
  edtCstEntrada.Clear;
  edtBaseEntrada.Text := '0,00';
  edtAliqEntrada.Text := '0,00';
  mskVigenciaEnt.Clear;
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
function TfrmCadAbreviacaoCOFINS.fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
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

