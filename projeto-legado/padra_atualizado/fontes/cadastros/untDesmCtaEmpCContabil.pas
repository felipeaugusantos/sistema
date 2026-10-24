unit untDesmCtaEmpCContabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, DB, DBClient, Grids, DBGridCitel, DBGrids, EditFocus, Mask,
  DBCtrls, DBEditFocus, Uni, frxClass, frxExportCSVTestabilidade,
  UniClientDataSet;

type
  TfrmDesmCtaEmpCContabil = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodEmp: TDBEditFocus;
    edtConcon: TDBEditFocus;
    edtNomEmp: TEditFocus;
    dbgCtaEmp: TDBGridCitel;
    dtsAux: TDataSource;
    dtsEmpCta: TDataSource;
    cdsAux: TUniClientDataSet;
    cdsAuxCTC_CODEMP: TStringField;
    cdsAuxEMP_NOMEMP: TStringField;
    cdsAuxCTC_CONCON: TStringField;
    cdsAuxAUTOINCREM: TStringField;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtsAuxStateChange(Sender: TObject);
    procedure dbgCtaEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
  private
    FCodCta: String;
    strNomEmp: String;

    procedure pCarregaDescrEmpresa;
    procedure pAtualizaGrid;
    procedure pLimpaCampos;

    function fEmpresaJaDesmembr(strCodEmp: String): Boolean;
  public
    property strCodCta: String read FCodCta write FCodCta;

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDesmCtaEmpCContabil: TfrmDesmCtaEmpCContabil;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmDesmCtaEmpCContabil.btnAlterarClick(Sender: TObject);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM CTCEMP WHERE AUTOINCREM = :AUTOINCREM');
  qryTabela.ParamByName('AUTOINCREM').AsString := cdsAuxAUTOINCREM.AsString;
  qryTabela.Open;

  edtNomEmp.Text := fRetNomeEmpresaSelec(qryTabela.FieldByName('CTC_CODEMP').AsString);

  inherited;

  pSetFocus(edtCodEmp);
end;

procedure TfrmDesmCtaEmpCContabil.btnCancelaClick(Sender: TObject);
begin
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    Try
      qryTabela.Cancel;
      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);
        
      pnlInfo.Caption := '';
      pLimpaCampos;      
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;
end;

procedure TfrmDesmCtaEmpCContabil.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM CTCEMP WHERE AUTOINCREM = :AUTOINCREM');
  qryTabela.ParamByName('AUTOINCREM').AsString := cdsAuxAUTOINCREM.AsString;
  qryTabela.Open;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmDesmCtaEmpCContabil.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pAtualizaGrid;

  pLimpaCampos;
end;

procedure TfrmDesmCtaEmpCContabil.btnGravarClick(Sender: TObject);
begin
  If fValidacoesBotaoGravarPai Then
  Begin
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If qryTabela.State in [dsInsert] Then
    Begin
      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTCEMP', VS_strCodEmp);
      qryTabela.FieldByName('CTC_CODCTA').AsString := FCodCta;
    End;

    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmDesmCtaEmpCContabil.btnGravarClick]');
      End;
    End;

    If blnGravou Then
      fCommit
    Else
      fRollBack;

    pAtualizaGrid;

    pSetFocus(dbgCtaEmp);
  End;
end;

procedure TfrmDesmCtaEmpCContabil.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pLimpaCampos;
  pSetFocus(edtCodEmp);
end;

procedure TfrmDesmCtaEmpCContabil.dbgCtaEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (qryTabela.State <> dsInsert) And (Key = #13) Then
    btnAlterarClick(Sender);
end;

procedure TfrmDesmCtaEmpCContabil.dtsAuxStateChange(Sender: TObject);
begin
  inherited;

  dbgCtaEmp.Enabled := Not (dtsAux.State in [dsInsert, dsEdit]);
end;

procedure TfrmDesmCtaEmpCContabil.edtCodEmpExit(Sender: TObject);
  Var
    qryAux: TUniQuery;
    strSql: String;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    qryAux := fCriaQuery;
    Try
      strSql := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP';

      qryAux.SQL.Text := strSql;
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryAux.Open;

      edtCodEmp.Text := qryAux.FieldByName('EMP_CODEMP').AsString;
      edtNomEmp.Text := qryAux.FieldByName('EMP_NOMEMP').AsString;
    Finally
      qryAux.Free;
    End;
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmDesmCtaEmpCContabil.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(edtCodEmp, False) Then
        pSetFocus(edtConCon)
      Else
        pSetFocus(edtCodEmp);
    End;
  End;
end;

function TfrmDesmCtaEmpCContabil.fEmpresaJaDesmembr(strCodEmp: String): Boolean;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  qryAux := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                      ';
    strSQL := strSQL + '   COUNT(*) AS CONT          ';
    strSQL := strSQL + ' FROM                        ';
    strSQL := strSQL + '   CTCEMP                    ';
    strSQL := strSQL + ' WHERE                       ';
    strSQL := strSQL + '   CTC_CODEMP = :CODEMP  AND ';
    strSQL := strSQL + '   CTC_CODCTA = :CODCTA      ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCTA').AsString := FCodCta;
      Open;
    End;

    Result := qryAux.FieldByName('CONT').AsInteger > 0;
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmDesmCtaEmpCContabil.FormCreate(Sender: TObject);
begin
  inherited;

  cdsAux.CreateDataSet;

  pValidaProCod('CTCEMP');

  strNomeTabela := 'CTCEMP';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM CTCEMP WHERE CTC_CODCTA = :CODCTA ', Self);
  qryTabela.ParamByName('CODCTA').AsString := FCodCta;

  dtsEmpCta.DataSet := qryTabela;
end;

procedure TfrmDesmCtaEmpCContabil.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaGrid;
end;

function TfrmDesmCtaEmpCContabil.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓD. DA EMPRESA              *}
    {**************************************JU*}
    If (Sender = edtCodEmp) And edtCodEmp.Enabled Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaDescrEmpresa;

        If fEmptyStr(strNomEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        If (fEmpresaJaDesmembr(edtCodEmp.Text)) And
           (qryTabela.State = dsInsert) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa já está incluida no desmembramento!', ['&O k']);
          Result := False;
        End;
      End;
    End
    {*****************************************}
    {* VALIDA O CONTA CONTÁBIL               *}
    {**************************************JU*}
    Else If (Sender = edtConCon) Then
    Begin
      If fEmptyStr(edtConCon.Text) Then
      Begin
        fMensagem('', 'Conta Contábil deve ser preechido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDesmCtaEmpCContabil.pAtualizaGrid;
  Var
    qryAuxEmp: TUniQuery;
begin
  qryAuxEmp := fCriaQuery(Nil);
  Try
    cdsAux.EmptyDataSet;

    qryAuxEmp.Close;
    qryAuxEmp.SQL.Add('SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CTCEMP WHERE CTC_CODCTA = :CODCTA ORDER BY CTC_CODEMP');
    qryTabela.ParamByName('CODCTA').AsString := FCodCta;
    qryTabela.Open;

    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      qryAuxEmp.Close;
      qryAuxEmp.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTC_CODEMP').AsString;
      qryAuxEmp.Open;

      cdsAux.Append;
      cdsAuxCTC_CODEMP.AsString := qryTabela.FieldByName('CTC_CODEMP').AsString;
      cdsAuxEMP_NOMEMP.AsString := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;
      cdsAuxCTC_CONCON.AsString := qryTabela.FieldByName('CTC_CONCON').AsString;
      cdsAuxAUTOINCREM.AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      cdsAux.Post;

      edtNomEmp.Text := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;

      Application.ProcessMessages;

      qryTabela.Next;
    End;
  Finally
    qryAuxEmp.Free;
  End;
end;

procedure TfrmDesmCtaEmpCContabil.pCarregaDescrEmpresa;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  EMP_NOMEMP ');
    qryAux.SQL.Add('FROM');
    qryAux.SQL.Add('  CADEMP ');
    qryAux.SQL.Add('WHERE EMP_CODEMP = :CODEMP');

    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.Open;

    strNomEmp := qryAux.FieldByName('EMP_NOMEMP').AsString;
    edtNomEmp.Text := strNomEmp;
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmDesmCtaEmpCContabil.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('CTC_CODCTA');
  stlCampos.Add('CTC_CODEMP');
  stlCampos.Add('CTC_CONCON');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CTC_CODCTA');
end;

procedure TfrmDesmCtaEmpCContabil.pLimpaCampos;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtConcon.Clear;
end;

end.
