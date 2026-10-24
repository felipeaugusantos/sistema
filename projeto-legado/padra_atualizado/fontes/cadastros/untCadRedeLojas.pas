unit untCadRedeLojas;

interface

uses
  Windows, Classes, Controls, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DB, Mask, DBEditFocus, untRedeLojas, AppEvnts, BitBtnLockedIncrem,
  DBCtrls, SysUtils;

type
  TfrmCadRedeLojas = class(TfrmPaiCad)
    pnlCadastro: TPanel;
    dbeCodRed: TDBEditFocus;
    dbeDesRed: TDBEditFocus;
    dtsCadRec: TDataSource;
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

    objRedeLojas: TRedeLojas;
  public
    { Public declarations }

  protected

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

uses Forms, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadRedeLojas.FormCreate(Sender: TObject);
begin
  inherited;

  objRedeLojas := TRedeLojas.Create(Self);

  qryTabela         := objRedeLojas.qryCadRed;
  dtsCadRec.DataSet := qryTabela;

  strNomeTabela := 'CADRED';
  strNomeCampo  := 'RED_CODRED';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodRed;

end;

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmCadRedeLojas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  
  {**************************************}
  {* VALIDA NOME DA REDE                *}
  {***********************************RL*}
  If (Sender = dbeDesRed) Then
  Begin

    If fEmptyStr(dbeDesRed.Text) Then
    Begin

      fMensagem('','O nome da rede deve ser informado !',['&OK']);
      Result := False;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadRedeLojas.pInicializaIndices;
begin

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('RED_CODRED');
  stlCamInd.Add('RED_DESRED');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');

end;

procedure TfrmCadRedeLojas.btnExcluirClick(Sender: TObject);
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

procedure TfrmCadRedeLojas.btnGravarClick(Sender: TObject);
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

procedure TfrmCadRedeLojas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodRed, dbeDesRed, False)
  Else
    pHabilitaCodigo(dbeCodRed, dbeDesRed, True)

end;

procedure TfrmCadRedeLojas.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodRed, dbeDesRed, False);
end;

procedure TfrmCadRedeLojas.FormShow(Sender: TObject);
begin
  inherited;

  qryTabela.FieldByName('RED_CODRED').DisplayLabel := 'Código';
  qryTabela.FieldByName('RED_DESRED').DisplayLabel := 'Nome';

  qryTabela.FieldByName('RED_CODEMP').Visible := False;
  qryTabela.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmCadRedeLojas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRede: TConsultasArray;
begin
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  chrKey := '/';
  If fPesqRedeLojas(Self, Nil, Nil, qryTabela, chrKey, arrRede) Then
    pSetFocus(btnAlterar);
end;

end.

