unit untCadHobbys;

interface

uses
  Windows, Classes, Controls, Forms,
  untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DB, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, SysUtils;

type
  TfrmCadHobbys = class(TfrmPaiCad)
    pnlDados: TPanel;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDesHob: TDBEditFocus;
    dtsCadHob: TDataSource;
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

procedure TfrmCadHobbys.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesHob, False);
end;

procedure TfrmCadHobbys.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadHobbys.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadHobbys.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadHobbys.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadHobbys.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesHob, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadHobbys.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrHobby: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE HOBBYS     *}
  {****************************AC*}
  chrKey := '/';
  If fPesqHobbysCliCon(Self, Nil, Nil, qryTabela, chrKey, arrHobby) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadHobbys.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADHOB';
  strNomeCampo      := 'HOB_CODHOB';
  qryTabela         := fCriarQuery('SELECT * FROM CADHOB', Self);
  dtsCadHob.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadHobbys.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadHobbys.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('HOB_CODHOB');
  stlCampos.Add('HOB_DESHOB');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('HOB_DESHOB');
  stlCamInd.Add('HOB_CODHOB');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Hobby');
end;

function TfrmCadHobbys.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Hobby deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesHob) Then
    Begin
      If fEmptyStr(dbeDesHob.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Hobby deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

