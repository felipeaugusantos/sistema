unit untCadLocFisicaConsertoEquip;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadLocFisicaConsertoEquip = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodLoc: TDBEditFocus;
    dtsLocEqu: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
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

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadLocFisicaConsertoEquip.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodLoc, dbeDescri, False);
end;

procedure TfrmCadLocFisicaConsertoEquip.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  try
    inherited;
  Except
    On E: Exception Do
    begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadLocFisicaConsertoEquip.btnExcluirClick]');
    end;
  end;

  if blnExcluiu then
    fCommit
  else
    fRollBack;
end;

procedure TfrmCadLocFisicaConsertoEquip.btnGravarClick(Sender: TObject);
begin
  if (Not fValidacoesBotaoGravarPai) then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  try
    inherited;
  Except
    On E: Exception Do
    begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadLocFisicaConsertoEquip.btnGravarClick]');
    end;
  end;

  if blnGravou then
    fCommit
  else
    fRollBack;
end;

procedure TfrmCadLocFisicaConsertoEquip.btnIncluirClick(Sender: TObject);
begin
  inherited;

  if blnUsaProCodigo then
    pHabilitaCodigo(dbeCodLoc, dbeDescri, False)
  else
    pHabilitaCodigo(dbeCodLoc, dbeCodLoc, True);
end;

procedure TfrmCadLocFisicaConsertoEquip.btnPesquisaClick(Sender: TObject);
var
  LKey: Char;
  LLoc: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ACESSÓRIOS *}
  {****************************DH*}
  LKey := '/';

  if fPesqLocFisConsertoEquip(Self, Nil, Nil, qryTabela, LKey, LLoc) then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadLocFisicaConsertoEquip.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADLEQ';
  strNomeCampo      := 'LEQ_CODLOC';
  qryTabela         := fCriarQuery(' SELECT * FROM CADLEQ', Self);
  dtsLocEqu.DataSet := qryTabela;
end;

function TfrmCadLocFisicaConsertoEquip.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender)) then
  begin
    if (Sender = dbeCodLoc) then
    begin
      if (fEmptyStr(dbeCodLoc.Text)) And (dbeCodLoc.Enabled) then
      begin
        fMensagem('ATENÇÃO!', 'O código da localização deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    end

    else if (Sender = dbeDescri) then
    begin
      if fEmptyStr(dbeDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A descrição da localização deve ser preenchida!', ['&Ok']);
        Result := False;
      end;
    end;
  end;

  if (not Result) then
    pSetFocus(Sender);
end;

procedure TfrmCadLocFisicaConsertoEquip.pInicializaIndices;
begin
  inherited;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodLoc;
end;

end.
