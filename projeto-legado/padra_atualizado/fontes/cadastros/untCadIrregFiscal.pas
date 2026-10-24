{******************************}
{* qryCadIrr -> CADIRR        *}
{***************************RV*}
unit untCadIrregFiscal;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem;

type
  TfrmCadIrregFiscal = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeCodIrr: TDBEditFocus;
    dbeDesIrr: TDBEditFocus;
    pnlFundo: TPanel;
    dtsCadIrr: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadIrr: TUniQuery;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untPai, untConsultas;

{$R *.dfm}

procedure TfrmCadIrregFiscal.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadIrregFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadIrr);
end;

procedure TfrmCadIrregFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADIRR';
  strNomeCampo      := 'IRR_CODIRR';

  qryCadIrr         := fCriaQuery(Self);
  qryTabela         := qryCadIrr;
  dtsCadIrr.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodIrr;
end;

function TfrmCadIrregFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓDIGO DA IRREGULARIDADE     *}
    {**************************************MV*}
    If (Sender = dbeCodIrr) Then
    Begin
      If (fEmptyStr(dbeCodIrr.Text)) And (dbeCodIrr.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Irregularidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA IRREGULARIDADE  *}
    {**************************************MV*}
    Else If (Sender = dbeDesIrr) Then
    Begin
      If fEmptyStr(dbeDesIrr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Irregularidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadIrregFiscal.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('IRR_DESIRR');
  stlCampos.Add('IRR_CODIRR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('IRR_DESIRR');
  stlCamInd.Add('IRR_CODIRR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadIrregFiscal.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadIrregFiscal.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadIrregFiscal.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadIrregFiscal.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadIrregFiscal.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodIrr, dbeDesIrr, False)
  Else
    pHabilitaCodigo(dbeCodIrr, dbeCodIrr, True);
end;

procedure TfrmCadIrregFiscal.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  {********************************************}
  {* NOVA CONSULTA DE IRREGULARIDADES FISCAIS *}
  {*****************************************RV*}
  chrKey := '/';
  If fPesqIrregFiscal(Self, Nil, Nil, qryTabela, chrKey) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadIrregFiscal.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodIrr, dbeCodIrr, True);
end;

procedure TfrmCadIrregFiscal.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

end.

