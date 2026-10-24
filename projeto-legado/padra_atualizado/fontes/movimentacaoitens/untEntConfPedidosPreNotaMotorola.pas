unit untEntConfPedidosPreNotaMotorola;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, MemDS, DBAccess, Uni, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  Vcl.Mask, MaskEditFocus, Vcl.Grids, DBGridCitel, DBGrids, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untEntConfPreNotaFuncoes;

type
  TfrmEntConfPedidosPreNotaMotorola = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    btnSeleciona: TBitBtnLocked;
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objConfPreNota: TConferePreNota;

  protected
  	function fGetSql(blnLike: Boolean): String; Override;
  	procedure pAddListaQuery; Override;
  end;

var
  frmEntConfPedidosPreNotaMotorola: TfrmEntConfPedidosPreNotaMotorola;

implementation

uses untFuncoesSimples, StrUtils;

{$R *.dfm}

{ TfrmEntConfPedidosPreNotaMotorola }

procedure TfrmEntConfPedidosPreNotaMotorola.btnConfirmaClick(Sender: TObject);
var
  intCont: Integer;
begin

  If stlListSelecao.Count = 0 Then
    Exit;

  inherited;

  With cdsConsulta Do
  Begin
    pLimpaPesquisa;

    objConfPreNota.strDocume := '';

    For intCont := 0 To stlListSelecao.Count -1 Do
    Begin
      If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intCont], []) Then
      Begin
        objConfPreNota.strDocume := objConfPreNota.strDocume + FieldByName('NUMDOC').AsString + '-' +
                                                               FieldByName('ESPDOC').AsString + ' ' +
                                                               FieldByName('SERDOC').AsString + ', ';
      End;
    end;

    objConfPreNota.strCodFor := objConfPreNota.strCodFor + '-' + fRetNomFornecedor(objConfPreNota.strCodFor);
    objConfPreNota.strDocume := LeftStr(objConfPreNota.strDocume, Length(objConfPreNota.strDocume) -2);
    objConfPreNota.strIncrem := stlListSelecao.Text;
  end;
end;

procedure TfrmEntConfPedidosPreNotaMotorola.btnSelecionaClick(Sender: TObject);
begin
  inherited;
  pAddListaQuery;
  dbgConsulta.Refresh;
end;

function TfrmEntConfPedidosPreNotaMotorola.fGetSql(blnLike: Boolean): String;
begin
  Result := objConfPreNota.fGetSqlConfer(blnLike);
end;

procedure TfrmEntConfPedidosPreNotaMotorola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (ModalResult = mrOk) And (stlListSelecao.Count = 0) Then
  Begin
    fMensagem('','Selecione um documento para conferência!', ['&Ok']);
    Action := caNone;
  End;
  inherited;
end;

procedure TfrmEntConfPedidosPreNotaMotorola.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_SPACE: Begin
                If dbgConsulta.Focused Then
                  btnSeleciona.Click;
              End;

    VK_F10  : Begin
                btnConfirma.Click;
                Key := 0;
              End;
  End;
end;

procedure TfrmEntConfPedidosPreNotaMotorola.FormShow(Sender: TObject);
begin
  inherited;
  blnQuoteLista := False;
  strCampoLista := 'AUTOINCREM';
  blnSempreRelerBanco := False;

  objConfPreNota.strCodFor := '';

  fAbreConsulta(True);
end;

procedure TfrmEntConfPedidosPreNotaMotorola.pAddListaQuery;
Var
  strIncAtu: String;
Begin

  if objConfPreNota.fValidaPedidoSelec(cdsConsulta, objConfPreNota.strCodFor) then
  begin

    With cdsConsulta Do
    If (stlListSelecao.Count > 0) And (Not SameText(objConfPreNota.strIdeDig, FieldByName('IDEDIG').AsString)) Then
    Begin
      fMensagem('','Selecione documentos da mesma conferência!', ['&Ok']);
    End

    Else
    Begin
      inherited pAddListaQuery;

      objConfPreNota.strIdeDig := FieldByName('IDEDIG').AsString;
      strIncAtu := FieldByName('AUTOINCREM').AsString;

      If Not fEmptyStr(objConfPreNota.strIdeDig) Then
      Begin
        pLimpaPesquisa;

        cdsConsulta.Filter := 'IDEDIG = ' + QuotedStr(objConfPreNota.strIdeDig);
        cdsConsulta.Filtered := True;

        While Not Eof Do
        Begin
          If strIncAtu <> FieldByName('AUTOINCREM').AsString Then
            inherited pAddListaQuery;
          Next;
        End;

        pLimpaPesquisa;
        Locate('AUTOINCREM', strIncAtu, []);
      end;

      If stlListSelecao.Count = 0 Then
        objConfPreNota.strCodFor := ''
      Else
        objConfPreNota.strCodFor := cdsConsulta.FieldByName('CODFOR').AsString;
    End;

  end;
end;

end.
