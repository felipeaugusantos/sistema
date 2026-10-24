unit untCadAdquirente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadAdquirente = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeNomAdq: TDBEditFocus;
    dbeCodAdq: TDBEditFocus;
    dbeChvReq: TDBEditFocus;
    dtsTabela: TDataSource;
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
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas;

{ TfrmCadAdquirente }

procedure TfrmCadAdquirente.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAdq, dbeNomAdq, False);
end;

procedure TfrmCadAdquirente.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdquirente.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdquirente.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdquirente.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdquirente.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAdq, dbeNomAdq, False)
  Else
    pHabilitaCodigo(dbeCodAdq, dbeCodAdq, True);
end;

procedure TfrmCadAdquirente.btnPesquisaClick(Sender: TObject);
  Var
    arrAdq : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqAdquirente(Self, Nil, Nil, qryTabela, chrKey, arrAdq) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAdquirente.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadAdquirente.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADADQ';
  strNomeCampo      := 'ADQ_CODADQ';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodAdq;
end;

procedure TfrmCadAdquirente.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadAdquirente.fValidaCampos(Sender: TWinControl;
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

    Else If (Sender = dbeNomAdq) Then
    Begin
      If fEmptyStr(dbeNomAdq.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O nome da adquirente deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeChvReq) Then
    Begin
      If fEmptyStr(dbeChvReq.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Chave requisição deve ser preenchida!', ['&Ok']);
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadAdquirente.pInicializaIndices;
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

end.
