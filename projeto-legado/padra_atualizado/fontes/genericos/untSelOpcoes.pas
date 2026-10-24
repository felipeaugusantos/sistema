unit untSelOpcoes;

interface

uses
  Windows, SysUtils, Winapi.Messages, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, Menus, ComCtrls, Buttons, Math,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Data.DB, Datasnap.DBClient, UniClientDataSet, Vcl.DBGrids, DBGridCitel,
  System.UITypes;

type
  TDBgridCitel = class(DBGridCitel.TDBGridCitel)
    private
      //Removemos as barras de rolagem horizontal e vertical do grid
      procedure WMNCCalcSize(var msg: TMessage); message WM_NCCALCSIZE;
    end;

  TfrmSelOpcoes = class(TfrmPaiSimples)
    cdsOpcoes: TUniClientDataSet;
    cdsOpcoesDescricao: TStringField;
    dbgOpcoes: TDBGridCitel;
    dtsOpcoes: TDataSource;
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    tmrAjustarTela: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgOpcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgOpcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure tmrAjustarTelaTimer(Sender: TObject);
    procedure dbgOpcoesDblClick(Sender: TObject);
  private
    { Private declarations }
    intMaxTextLengthGrid: Integer;
    intCellHeight: Integer;
    intFormHeight: Integer;

    procedure pAjustarTela;
    procedure pMarcarRegistro;
  protected
    stlSelecionados: TStringList;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnSaiComEsc: Boolean;
    arrOpcoes: Array Of String;
    strSelecionados: String;
  end;

  function fSelOpcoes(strTitulo: String; arrOpcoes: Array Of String; blnSaiComEsc: Boolean = False): String;

var
  frmSelOpcoes: TfrmSelOpcoes;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

function fSelOpcoes(strTitulo: String; arrOpcoes: Array Of String; blnSaiComEsc: Boolean = False): String;
  Var
    intContador: Integer;
begin
  Try
    pCriarFormularios(TfrmSelOpcoes, frmSelOpcoes);
    SetLength(frmSelOpcoes.arrOpcoes, Length(arrOpcoes));

    For intContador := 0 To Length(arrOpcoes)-1 Do
    Begin
      frmSelOpcoes.arrOpcoes[intContador] := arrOpcoes[intContador];
    End;

    frmSelOpcoes.blnSaiComEsc := blnSaiComEsc;
    frmSelOpcoes.Caption      := strTitulo;

    frmSelOpcoes.showModal;

    If frmSelOpcoes.blnConfirma Then
      Result := frmSelOpcoes.strSelecionados;
  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmSelOpcoes);
end;

procedure TfrmSelOpcoes.pAjustarTela;
begin
  Self.Width  := Min(intMaxTextLengthGrid + 50, 350);
  Self.Height := Min(intFormHeight + cdsOpcoes.RecordCount * intCellHeight, 768);
  Self.Left   := Screen.Width  div 2 - Self.Width  div 2;
  Self.Top    := Screen.Height div 2 - Self.Height div 2;
end;

procedure TfrmSelOpcoes.FormShow(Sender: TObject);
  Var
    strOpcao: String;
begin
  inherited;
  intFormHeight := Self.Height;

  cdsOpcoes.CreateDataSet;

  For strOpcao In arrOpcoes Do
  Begin
    cdsOpcoes.AppendRecord([strOpcao]);
    stlSelecionados.Add(strOpcao);
  End;

  tmrAjustarTela.Enabled := True;
end;

procedure TfrmSelOpcoes.pEscapePressed;
begin
  If blnSaiComEsc Then
    inherited;
end;

procedure TfrmSelOpcoes.pMarcarRegistro;
begin
  If stlSelecionados.IndexOf(cdsOpcoesDescricao.AsString) >= 0 Then
    stlSelecionados.Delete(stlSelecionados.IndexOf(cdsOpcoesDescricao.AsString))
  Else
    stlSelecionados.Add(cdsOpcoesDescricao.AsString);

  If cdsOpcoes.RecNo < cdsOpcoes.RecordCount Then
    cdsOpcoes.Next
  Else
    pSetFocus(btnConfirma);
end;

procedure TfrmSelOpcoes.tmrAjustarTelaTimer(Sender: TObject);
begin
  inherited;
  If intMaxTextLengthGrid > 0 Then
  Begin
    tmrAjustarTela.Enabled := False;
    pAjustarTela;
    If stlSelecionados.Count = cdsOpcoes.RecordCount Then
      pSetFocus(btnConfirma)
    Else
      pSetFocus(dbgOpcoes)
  End;
end;

procedure TfrmSelOpcoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If stlSelecionados.Count = 0 Then
  Begin
    pMensagemOk('Nenhum registro foi selecionado!');
    Exit;
  End;
  strSelecionados := stlSelecionados.CommaText;
  blnConfirma := True;
  Close;
end;

procedure TfrmSelOpcoes.dbgOpcoesDblClick(Sender: TObject);
begin
  inherited;
  pMarcarRegistro;
end;

procedure TfrmSelOpcoes.dbgOpcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If stlSelecionados.IndexOf(Column.Field.AsString) >= 0 Then
  Begin
    If dbgOpcoes.Canvas.Brush.Color = clHighlight Then
      dbgOpcoes.Canvas.Pen.Color := clYellow
    Else
      dbgOpcoes.Canvas.Brush.Color := clMoneyGreen;
  End;

  intCellHeight := Rect.Bottom - Rect.Top;
  intMaxTextLengthGrid := Max(intMaxTextLengthGrid, Canvas.TextWidth(Column.Field.AsString));

  dbgOpcoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmSelOpcoes.dbgOpcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_UP, VK_DOWN: pAjustarTela;
    VK_F10: btnConfirma.Click;
    VK_ESCAPE: pEscapePressed;
    VK_RETURN: pMarcarRegistro;
  end;
end;

procedure TfrmSelOpcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnSaiComEsc And Not blnConfirma Then
    Action := caNone
  Else
    stlSelecionados.Free;
end;

procedure TfrmSelOpcoes.FormCreate(Sender: TObject);
begin
  inherited;
  strSelecionados := '';
  stlSelecionados := TStringList.Create;
end;

{ TDBgridCitel }

procedure TDBgridCitel.WMNCCalcSize(var msg: TMessage);
  Var
    style: Integer;
begin
  //Removemos as barras de rolagem horizontal e vertical do grid
  style := getWindowLong( handle, GWL_STYLE );
  SetWindowLong( handle, GWL_STYLE, style and not WS_HSCROLL and not WS_VSCROLL);
  inherited;
end;

end.

