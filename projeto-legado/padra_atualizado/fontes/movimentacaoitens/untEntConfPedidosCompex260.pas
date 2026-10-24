unit untEntConfPedidosCompex260;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, DBClient, Provider,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, Uni,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untEntConferenciaFuncoes,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, UniClientDataSet,
  UniDataSetProvider, MemDS, DBAccess;

type
  TfrmEntConfPedidosCompex260 = class(TfrmPaiOrdena)
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
    objConEnt: TConfereEntrada;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pAddListaQuery; Override;
  end;

var
  frmEntConfPedidosCompex260: TfrmEntConfPedidosCompex260;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntConfPedidosCompex260.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
  dbgConsulta.Refresh;
  
end;

procedure TfrmEntConfPedidosCompex260.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;

  btnSeleciona.Click;
end;

function TfrmEntConfPedidosCompex260.fGetSql(blnLike: Boolean): String;
Begin

  Result := objConEnt.fSqlSelecPedidos(blnLike, False);

End;

procedure TfrmEntConfPedidosCompex260.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult = mrOk) And (stlListSelecao.Count = 0) Then
  Begin
    fMensagemAuto('','Selecione um pedido para conferência!', ['&Ok']);
    Action := caNone;
  End;

  inherited;
end;

procedure TfrmEntConfPedidosCompex260.FormCreate(Sender: TObject);
begin
  inherited;

  WindowState := wsMaximized;

  strCodFor := '';
end;

procedure TfrmEntConfPedidosCompex260.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmEntConfPedidosCompex260.FormShow(Sender: TObject);
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

procedure TfrmEntConfPedidosCompex260.pAddListaQuery;
Begin
  If objConEnt.fValidaPedidoSelec(cdsConsulta, strCodFor, False) Then
  Begin

    inherited pAddListaQuery;

    If stlListSelecao.Count = 0 Then
      strCodFor := ''
    Else
      strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
  End;

End;

end.
