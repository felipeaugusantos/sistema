unit untCadGrupoAtributo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadGrupoAtributo = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsGruAtr: TDataSource;
    chkExiCon: TDBCheckBox;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadGrupoAtributo: TfrmCadGrupoAtributo;

  function fChamaAtrGru(Key: Word): String;

implementation

{$R *.dfm}

Uses
  untFuncIns2,
  untFuncoesConsulta, untTypesSistema, untConsultas, untFuncoesSimples;

procedure TfrmCadGrupoAtributo.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadGrupoAtributo.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadGrupoAtributo.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadGrupoAtributo.btnGravarClick(Sender: TObject);
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
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadGrupoAtributo.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
  Begin
    pnlInfo.Caption := '';
    fRollBack;
  End;

end;

procedure TfrmCadGrupoAtributo.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);

end;

procedure TfrmCadGrupoAtributo.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';

  If fPesqGrupoAtributo(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadGrupoAtributo.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'GRUATR';
  strNomeCampo          := 'GRU_CODIGO';

  qryTabela             := fCriaQuery(Self);
  dtsGruAtr.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
end;

procedure TfrmCadGrupoAtributo.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

procedure TfrmCadGrupoAtributo.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
end;

function TfrmCadGrupoAtributo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Grupo de Atributo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Grupo de Atributo deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function fChamaAtrGru(Key: Word): String;
begin
  Result := fChamaForm(Key, TfrmCadGrupoAtributo, frmCadGrupoAtributo);
end;

end.
