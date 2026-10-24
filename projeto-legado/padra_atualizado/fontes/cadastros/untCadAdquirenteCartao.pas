unit untCadAdquirenteCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, MemDS, DBAccess, Uni, QColorLabel;

type
  TfrmCadAdquirenteCartao = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodAdq: TDBEditFocus;
    Label2: TLabel;
    dbeNomAdq: TDBEditFocus;
    lbCodOperadora: TLabel;
    DBETFTOPE: TDBEditFocus;
    Label3: TLabel;
    DBETFRED2: TDBEditFocus;
    lblModPos: TLabel;
    dbeModPos: TDBEditFocus;
    ColorLabel2: TColorLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    function fValidaDadosCnfTef(const AStrAutoInc: String): Boolean;
    procedure pNaoCompletaZerosSeValorVazio(AEdit: TDBEditFocus);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untRegrasCadastroCartaoTef;

{ TfrmCadAdquirente }

procedure TfrmCadAdquirenteCartao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAdq, dbeNomAdq, False);
end;

procedure TfrmCadAdquirenteCartao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdquirenteCartao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdquirenteCartao.btnGravarClick(Sender: TObject);
var LAltNome: boolean;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  if not fValidaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) then
    Exit ;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  LAltNome := (qryTabela.FieldByName('ADQ_NOMADQ').OldValue <> qryTabela.FieldByName('ADQ_NOMADQ').NewValue);
  Try
    inherited;
    If LAltNome Then
      TRegrasCadastroCartaoTef.fAlteraNomeCartaoDoCadastro(dbeCodAdq.Text, '');
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdquirenteCartao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdquirenteCartao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAdq, dbeNomAdq, False)
  Else
    pHabilitaCodigo(dbeCodAdq, dbeCodAdq, True);
  qryTabela.FieldByName('ADQ_MODPOS').AsString := 'N';
end;

procedure TfrmCadAdquirenteCartao.btnPesquisaClick(Sender: TObject);
  Var
    arrAdq : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqAdquirenteCartao(Self, Nil, Nil, qryTabela, chrKey, arrAdq) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAdquirenteCartao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadAdquirenteCartao.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CDADQC';
  strNomeCampo      := 'ADQ_CODADQ';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodAdq;
end;

procedure TfrmCadAdquirenteCartao.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadAdquirenteCartao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodAdq) Then
    Begin
      If (fEmptyStr(dbeCodAdq.Text)) And (dbeCodAdq.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da adquirente deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End
    Else If (Sender = dbeModPos) Then
    Begin

      If Not fValidoSimNao(dbeModPos.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo "Usar somente para POS?" deve ser informado S ou N!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = dbeNomAdq) Then
    Begin
      If fEmptyStr(dbeNomAdq.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O nome da adquirente deve ser preenchido!', ['&Ok']);
      End;
    End
    else if (Sender = DBETFTOPE) then
    begin
      pNaoCompletaZerosSeValorVazio(DBETFTOPE);
    end
    else if (Sender = DBETFRED2) then
    begin
      pNaoCompletaZerosSeValorVazio(DBETFRED2);
    end ;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadAdquirenteCartao.fValidaDadosCnfTef(
  const AStrAutoInc: String): Boolean;
var
  LqryVerif: TUniQuery;
  LstrTftRed: String;
begin
  Result := False ;

  LqryVerif := fCriaQuery() ;
  try
    LqryVerif.Close ;
    LqryVerif.SQL.Clear ;
    LqryVerif.SQL.Add(' SELECT ADQ_CODADQ, ADQ_NOMADQ, ADQ_TFTRED, ADQ_TFRED2 FROM CDADQC ') ;
    if not fEmptyStr(AStrAutoInc) then
    begin
      LqryVerif.SQL.Add(' WHERE AUTOINCREM <> :SEQBAN ') ;
      LqryVerif.ParamByName('SEQBAN').AsString := AStrAutoInc ;
    end ;

    LqryVerif.Open ;

    LstrTftRed := qryTabela.FieldByName('ADQ_TFTRED').AsString ;
    if (not fEmptyStr(LstrTftRed)) and (LqryVerif.Locate('ADQ_TFTRED', LstrTftRed, [loCaseInsensitive])) then
    begin
      fMensagem('ATENÇÃO!', format('Cód Operadora Fiserv-ClisiTef [%s] já associada na adquirente [%s - %s]!', [LstrTftRed, LqryVerif.FieldByName('ADQ_CODADQ').AsString, LqryVerif.FieldByName('ADQ_NOMADQ').AsString]), ['&OK']);
      Exit ;
    end ;

    LstrTftRed := qryTabela.FieldByName('ADQ_TFRED2').AsString ;
    if (not fEmptyStr(LstrTftRed)) and (LqryVerif.Locate('ADQ_TFRED2', LstrTftRed, [loCaseInsensitive])) then
    begin
      fMensagem('ATENÇÃO!', format('Cód Operadora ConexãoTech-Scope [%s] já associada na adquirente [%s - %s]!', [LstrTftRed, LqryVerif.FieldByName('ADQ_CODADQ').AsString, LqryVerif.FieldByName('ADQ_NOMADQ').AsString]), ['&OK']);
      Exit ;
    end ;

  finally
    FreeAndNil(LqryVerif) ;
  end ;
  Result := True ;
end;

procedure TfrmCadAdquirenteCartao.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ADQ_CODADQ');
  stlCampos.Add('ADQ_NOMADQ');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ADQ_NOMADQ');
  stlCamInd.Add('ADQ_CODADQ');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmCadAdquirenteCartao.pNaoCompletaZerosSeValorVazio(AEdit: TDBEditFocus);
begin
  If Not(AEdit.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
    Exit;

  AEdit.CompZeros:= false;
  AEdit.Field.AsString:= AEdit.Text;

  // Se o texto for '0' ou vazio, limpamos o Field para evitar o "0000"
  if (StrToIntDef(AEdit.Text, 0) = 0) then
  begin
    AEdit.Field.Clear;
    exit;
  end;

  AEdit.Field.AsString := fStrZero(AEdit.Field.AsString, 5);
end;

end.
