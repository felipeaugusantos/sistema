unit untEntConfPedidosMotorola;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untEntConferenciaFuncoes,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmEntConfPedidosMotorola = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    btnSeleciona: TBitBtnLocked;
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodFor : String;
    objConEnt : TConfereEntrada;
    stlRegSel : TStringList;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pAddListaQuery; Override;
  end;

var
  frmEntConfPedidosMotorola: TfrmEntConfPedidosMotorola;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntConfPedidosMotorola.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
  dbgConsulta.Refresh;
  
end;

procedure TfrmEntConfPedidosMotorola.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;

  btnSeleciona.Click;
end;

function TfrmEntConfPedidosMotorola.fGetSql(blnLike: Boolean): String;
Begin

  Result := objConEnt.fSqlSelecPedidos(blnLike, False);

End;

procedure TfrmEntConfPedidosMotorola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult = mrOk) And (stlListSelecao.Count = 0) Then
  Begin
    fMensagemAuto('','Selecione um pedido para conferência!', ['&Ok']);
    Action := caNone;
  End;

  If Assigned(stlRegSel) Then
    stlRegSel.Text:=stlListSelecao.Text;

  inherited;
end;

procedure TfrmEntConfPedidosMotorola.FormCreate(Sender: TObject);
begin
  inherited;

  strCodFor := '';

end;

procedure TfrmEntConfPedidosMotorola.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_SPACE: btnSeleciona.Click;
    VK_F10  : Begin
                btnConfirma.Click;
                Key := 0;
              End;
  End;

end;

procedure TfrmEntConfPedidosMotorola.FormShow(Sender: TObject);
begin
  inherited;

  stlListSelecao.Text := objConEnt.stlPedidos.Text;

  blnQuoteLista := False;
  strCampoLista := 'AUTOINCREM';
  blnSempreRelerBanco := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta(True);

end;

procedure TfrmEntConfPedidosMotorola.pAddListaQuery;
Begin
  If objConEnt.fValidaPedidoSelec(cdsConsulta, strCodFor, True) Then
  Begin

    inherited pAddListaQuery;

    If stlListSelecao.Count = 0 Then
      strCodFor := ''
    Else
      strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
  End;

End;

end.
