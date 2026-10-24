unit untCadMontadoras;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, DBEditFocus, DB, BitBtnLockedIncrem, Mask,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadMontadoras = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodMon: TDBEditFocus;
    dtsCadMon: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadMontadoras.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMon, dbeDescri, False);
end;

procedure TfrmCadMontadoras.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMontadoras.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMontadoras.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadMontadoras.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMontadoras.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMon, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodMon, dbeCodMon, True);

end;

procedure TfrmCadMontadoras.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAtiv: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMontadora(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadMontadoras.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADMON';
  strNomeCampo          := 'MON_CODMON';

  qryTabela             := fCriaQuery(Self);
  dtsCadMon.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodMon;
end;

procedure TfrmCadMontadoras.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

end;

procedure TfrmCadMontadoras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MON_CODMON');
  stlCampos.Add('MON_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MON_DESCRI');
  stlCamInd.Add('MON_CODMON');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadMontadoras.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodMon) Then
    Begin
      If (fEmptyStr(dbeCodMon.Text)) And (dbeCodMon.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Montadora deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'O nome da Montadora deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

