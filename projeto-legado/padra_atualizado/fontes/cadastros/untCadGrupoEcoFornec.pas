unit untCadGrupoEcoFornec;

interface

uses
  Windows, Classes, Controls, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DB, Mask, DBEditFocus, untRedeLojas, AppEvnts, BitBtnLockedIncrem,
  DBCtrls, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadGrupoEcoFornec = class(TfrmPaiCad)
    pnlCadastro: TPanel;
    dbeCodGef: TDBEditFocus;
    dbeDesGef: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    dtsDados: TDataSource;
  public
    { Public declarations }

  protected

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;


implementation

uses Forms, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadGrupoEcoFornec.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'GRECFR';
  strNomeCampo  := 'GEF_CODGEF';

  qryTabela := fCriarQuery('SELECT * FROM GRECFR');
  dtsDados  := fCriaDataSource(qryTabela);

  qryTabela.FieldByName('GEF_CODGEF').DisplayLabel := 'Código';
  qryTabela.FieldByName('GEF_DESGEF').DisplayLabel := 'Descrição';
  qryTabela.FieldByName('AUTOINCREM').Visible := False;

  dbeCodGef.DataSource := dtsDados;
  dbeDesGef.DataSource := dtsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGef;
  pHabilitaCodigo(dbeCodGef, dbeDesGef, False);
end;

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmCadGrupoEcoFornec.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeDesGef) Then
  Begin

    If fEmptyStr(dbeDesGef.Text) Then
    Begin

      fMensagem('','O nome do Grupo deve ser informado !',['&OK']);
      Result := False;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadGrupoEcoFornec.pInicializaIndices;
begin

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('GEF_CODGEF');
  stlCamInd.Add('GEF_DESGEF');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');

end;

procedure TfrmCadGrupoEcoFornec.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRedeLojas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoEcoFornec.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadRedeLojas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadGrupoEcoFornec.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodGef, dbeDesGef, False)
  Else
    pHabilitaCodigo(dbeCodGef, dbeDesGef, True)

end;

procedure TfrmCadGrupoEcoFornec.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodGef, dbeDesGef, False);
end;

procedure TfrmCadGrupoEcoFornec.FormShow(Sender: TObject);
begin
  inherited;

  qryTabela.FieldByName('GEF_CODGEF').DisplayLabel := 'Código';
  qryTabela.FieldByName('GEF_DESGEF').DisplayLabel := 'Nome';

  qryTabela.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmCadGrupoEcoFornec.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqGrupoEcoFornec(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
    pSetFocus(btnAlterar);
end;

end.

