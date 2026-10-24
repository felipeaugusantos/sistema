unit untProcessList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, Uni, AppEvnts, Menus, StdCtrls,
  EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmProcessList = class(TfrmPaiOrdena)
    btnKill: TBitBtnLocked;
    btnRefresh: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnKillClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pKill;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetOrderBy: String; Override;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmProcessList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE : If ActiveControl.Parent <> pnlPesquisa Then btnKill.Click;
    VK_ESCAPE : Close;
    VK_F9     : btnRefresh.Click;
  End;

end;

procedure TfrmProcessList.btnRefreshClick(Sender: TObject);
begin
  inherited;
  pLimpaPesquisa;
  fAbreConsulta(TRUE);
end;

procedure TfrmProcessList.btnKillClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.Active Then
    pKill
  Else
    If fMensagem('AVISO',
                 'Nenhuma conexão, Deseja Atualizar novamente?', ['&Sim', '&Não']) = 1 Then
      btnRefresh.Click
    Else
      Self.Close;

end;

procedure TfrmProcessList.pKill;
  Var
    qryGen: TUniQuery;
begin
  If fMensagem('Exclusão de Processo',
               'Confirma a exclusão do Processo ' + cdsConsulta.FieldByName('Id').AsString + '?', ['&Sim', '&Não']) = 2 Then
    exit;

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    add('KILL :ID');
    ParamByName('ID').AsString := cdsConsulta.FieldByName('Id').AsString;
    ExecSQL;

    pLimpaPesquisa;  
    fAbreConsulta(TRUE);

  End;
  FreeAndNil(qryGen);
end;


procedure TfrmProcessList.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao := FALSE;
  fAbreConsulta(TRUE);
end;

function TfrmProcessList.fGetSql(blnLike: Boolean): String;
Begin
  Result := 'SHOW PROCESSLIST';
End;

function TfrmProcessList.fGetOrderBy: String;
Begin
  Result := ' -- ';
End;

end.
