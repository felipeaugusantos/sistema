unit untCadTiposProjeto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel;

type
  TfrmCadTiposProjeto = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeDesTip: TDBEditFocus;
    dbeCodTip: TDBEditFocus;
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
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

Var
  frmCadTiposProjeto : TfrmCadTiposProjeto;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas;

{ TfrmCadTiposProjeto }

procedure TfrmCadTiposProjeto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTip, dbeDesTip, False);
end;

procedure TfrmCadTiposProjeto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposProjeto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTiposProjeto.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTiposProjeto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTiposProjeto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTip, dbeDesTip, False)
  Else
    pHabilitaCodigo(dbeCodTip, dbeDesTip, True);
end;

procedure TfrmCadTiposProjeto.btnPesquisaClick(Sender: TObject);
  Var
    arrTip : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqTipoProjeto(Self, Nil, Nil, qryTabela, chrKey, arrTip) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTiposProjeto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadTiposProjeto.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'TIPPRJ';
  strNomeCampo        := 'TIP_CODTIP';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodTip;
end;

function TfrmCadTiposProjeto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodTip) Then
    Begin
      If (fEmptyStr(dbeCodTip.Text)) And (dbeCodTip.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do tipo de projeto deve ser preenchido!', ['&Ok']);
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

    Else If (Sender = dbeDesTip) Then
    Begin
      If fEmptyStr(dbeDesTip.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A descrição do tipo de projeto deve ser preenchido!', ['&Ok']);
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTiposProjeto.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TIP_CODTIP');
  stlCampos.Add('TIP_DESTIP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TIP_DESTIP');
  stlCamInd.Add('TIP_CODTIP');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
