unit untCadDepartamentosCliCon;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, DBCtrls, DBEditFocus, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadDepartamentosCliCon = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDesDpt: TDBEditFocus;
    Label2: TLabel;
    dtsCadDpt: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadDepartamentosCliCon.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesDpt, False);
end;

procedure TfrmCadDepartamentosCliCon.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDepartamentosCliCon.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadDepartamentosCliCon.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadDepartamentosCliCon.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadDepartamentosCliCon.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesDpt, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadDepartamentosCliCon.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrDepart: TConsultasArray;
begin
  {***********************************}
  {* NOVA CONSULTA DE DEPARTAMENTOS  *}
  {********************************AC*}
  chrKey := '/';
  If fPesqDepartamentosCliCon(Self, Nil, Nil, qryTabela, chrKey, arrDepart) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadDepartamentosCliCon.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADDPT';
  strNomeCampo      := 'DPT_CODDPT';
  qryTabela         := fCriarQuery('SELECT * FROM CADDPT', Self);
  dtsCadDpt.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadDepartamentosCliCon.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadDepartamentosCliCon.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DPT_CODDPT');
  stlCampos.Add('DPT_DESDPT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DPT_DESDPT');
  stlCamInd.Add('DPT_CODDPT');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Departamento');
end;

function TfrmCadDepartamentosCliCon.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Departamento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesDpt) Then
    Begin
      If fEmptyStr(dbeDesDpt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Departamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

