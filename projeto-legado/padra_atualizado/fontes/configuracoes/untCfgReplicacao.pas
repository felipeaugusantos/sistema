unit untCfgReplicacao;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, DBGridCitel, DBGrids, Uni, UniDataSetProvider, AppEvnts, BitBtnLockedIncrem, MemDS,
  DBAccess, Provider, Grids, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCfgReplicacao = class(TfrmPai)
    pnlFundo: TPanel;
    dbgNaoReplica: TDBGridCitel;
    Label1: TLabel;
    dtsTabNRE: TDataSource;
    cdsTabNRE: TUniClientDataSet;
    cdsTabNRENOMTAB: TStringField;
    dspTabNre: TUniDataSetProvider;
    qryTabNre: TUniQuery;
    btnGravar: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgNaoReplicaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pCarregaArqIni;
    procedure pGravaArqIni;
    { Private declarations }
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;


  end;

implementation

uses Forms, untFuncoesSimples;

{$R *.dfm}


function TfrmCfgReplicacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgReplicacao.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;

end;

{**************************************}
{* CARREGA DADOS DO ARQUIVO .INI      *}
{***********************************AF*}
procedure TfrmCfgReplicacao.pCarregaArqIni;
begin
  cdsTabNRE.Open;
end;

{**************************************}
{* GRAVA DADOS DO ARQUIVO .INI        *}
{***********************************AF*}
procedure TfrmCfgReplicacao.pGravaArqIni;
begin
  cdsTabNRE.ApplyUpdates(0);
end;


procedure TfrmCfgReplicacao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

procedure TfrmCfgReplicacao.dbgNaoReplicaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Delete: If Not cdsTabNRE.IsEmpty Then cdsTabNRE.Delete;
    VK_ESCAPE: btnSairClick(Sender);
  End;

end;

initialization
  RegisterClass(TfrmCfgReplicacao);
finalization
  UnRegisterClass(TfrmCfgReplicacao);

end.

