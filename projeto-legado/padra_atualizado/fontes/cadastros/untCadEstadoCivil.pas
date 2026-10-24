unit untCadEstadoCivil;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadEstadoCivil = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDesEci: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsCadEci: TDataSource;
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

procedure TfrmCadEstadoCivil.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesEci, False);
end;

procedure TfrmCadEstadoCivil.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEstadoCivil.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEstadoCivil.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadEstadoCivil.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEstadoCivil.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesEci, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadEstadoCivil.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEstadoCivil: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CARGOS     *}
  {****************************AC*}
  chrKey := '/';
  If fPesqEstadosCivisCliCon(Self, Nil, Nil, qryTabela, chrKey, arrEstadoCivil) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadEstadoCivil.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADECI';
  strNomeCampo      := 'ECI_CODECI';
  qryTabela         := fCriarQuery('SELECT * FROM CADECI', Self);
  dtsCadEci.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadEstadoCivil.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadEstadoCivil.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ECI_CODECI');
  stlCampos.Add('ECI_DESECI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ECI_DESECI');
  stlCamInd.Add('ECI_CODECI');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Estado Civil');
end;

function TfrmCadEstadoCivil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Estado Civil deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesEci) Then
    Begin
      If fEmptyStr(dbeDesEci.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Estado Civil deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


end.

