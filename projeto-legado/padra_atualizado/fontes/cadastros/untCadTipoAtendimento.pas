unit untCadTipoAtendimento;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadTipoAtendimento = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesTpa: TDBEditFocus;
    dbeCodTpa: TDBEditFocus;
    dtsCadTpa: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTipoAtendimento.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADTPA';
  strNomeCampo      := 'TPA_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CADTPA', Self);
  dtsCadTpa.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTpa;
end;

procedure TfrmCadTipoAtendimento.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTipoAtendimento.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTipoAtendimento.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTipoAtendimento.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTipoAtendimento.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTpa, dbeDesTpa, False)
  Else
    pHabilitaCodigo(dbeCodTpa, dbeCodTpa, True);
end;

procedure TfrmCadTipoAtendimento.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTpaAte: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE AJUDANTES  *}
  {****************************IV*}
  chrKey := '/';
  If fPesqTipoAtendimento(Self, Nil, Nil, qryTabela, chrKey, arrTpaAte) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTipoAtendimento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTpa, dbeDesTpa, False);
end;

function TfrmCadTipoAtendimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodTpa) Then
  Begin

    If (fEmptyStr(dbeCodTpa.Text)) And (dbeCodTpa.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Tipo de Atendimento deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDesTpa) Then
  Begin

    If fEmptyStr(dbeDesTpa.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadTipoAtendimento.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TPA_CODIGO');
  stlCampos.Add('TPA_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TPA_DESCRI');
  stlCamInd.Add('TPA_CODIGO');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

end.

