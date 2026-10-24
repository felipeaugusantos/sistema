unit untCadSetoresFilizola;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, StdCtrls, Mask, DBEditFocus,
  Menus, ComCtrls, Buttons, ExtCtrls, AppEvnts, DB, BitBtnLockedIncrem, DBCtrls,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadSetoresFilizola = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    dbeCodSfz: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsCadSfz: TDataSource;
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

uses untfuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmPaiCad1 }

function TfrmCadSetoresFilizola.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodSfz) And (dbeCodSfz.Enabled) Then
  Begin
    If (fEmptyStr(dbeCodSfz.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If blnBuscaPorChave Then
    Begin
      If (Not fBuscaPorCamposChave) Then
      Begin
        pLimparCampos;
      End
    End;
  End

  Else If (Sender = dbeDescri) Then
  Begin

    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadSetoresFilizola.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SFZ_CODSFZ');
  stlCampos.Add('SFZ_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SFZ_DESCRI');
  stlCamInd.Add('SFZ_CODSFZ');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadSetoresFilizola.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADSFZ';
  strNomeCampo      := 'SFZ_CODSFZ';
  qryTabela         := fCriarQuery('SELECT * FROM CADSFZ', Self);
  dtsCadSfz.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodSfz;
end;

procedure TfrmCadSetoresFilizola.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadSetoresFilizola.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadSetoresFilizola.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadSetoresFilizola.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadSetoresFilizola.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodSfz, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodSfz, dbeCodSfz, True);
end;

procedure TfrmCadSetoresFilizola.btnPesquisaClick(Sender: TObject);
  Var
    chrKey    : Char;
    arrSetFlz : TConsultasArray;
begin
  //inherited;
  {*************************************}
  {* NOVA CONSULTA DE SETORES FILIZOLA *}
  {**********************************DP*}
  chrKey := '/';
  If fPesqSetFlz(Self, Nil, Nil, qryTabela, chrKey, arrSetFlz) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadSetoresFilizola.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodSfz, dbeDescri, False);
end;

end.

