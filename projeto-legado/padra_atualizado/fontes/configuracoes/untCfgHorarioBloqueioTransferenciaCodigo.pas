unit untCfgHorarioBloqueioTransferenciaCodigo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxTimeEdit;

type
  TfrmCfgHorarioBloqueioTransferenciaCodigo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    HroInicial: TcxTimeEdit;
    HroFim: TcxTimeEdit;
    Label3: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    FPeriodo: String;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetPeriodo: String;
    procedure pSetPeriodo(const pValue: String);
  public
    property strPeriodo: String Read FPeriodo Write pSetPeriodo;
    { Public declarations }
  end;

var
  frmCfgHorarioBloqueioTransferenciaCodigo: TfrmCfgHorarioBloqueioTransferenciaCodigo;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgHorarioBloqueioTransferenciaCodigo }

procedure TfrmCfgHorarioBloqueioTransferenciaCodigo.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  FPeriodo := fGetPeriodo;
end;

function TfrmCfgHorarioBloqueioTransferenciaCodigo.fGetPeriodo: String;
begin
  Result := FormatDateTime('hh:mm',HroInicial.time)+'|'+FormatDateTime('hh:mm', HroFim.time);
end;

function TfrmCfgHorarioBloqueioTransferenciaCodigo.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result:= True;

  If (Sender = HroFim) Then
  Begin
    If  HroFim.Time < HroInicial.Time  Then
    Begin
      fMensagem('ATENÇÃO!', 'O Horário Final deve ser maior que a Horário Inicial!',['&Ok']);
      Result := False;
    End;
  End;

 If Not Result Then
   pSetFocus(Sender);

end;

procedure TfrmCfgHorarioBloqueioTransferenciaCodigo.pSetPeriodo(
  const pValue: String);
Var
  ldtaAux: TDateTime;
  lHrInicial,
  lHrFinal: TTime;
  lstrAux: String;
begin
  If fEmptyStr(pValue) or
       (length(pValue) <> 11) or
         (pos('|', pValue) <> 6) then
  begin
    lHrInicial := StrToTime('07:30');
    lHrFinal := StrToTime('18:30');
  end
  else
  begin
    lstrAux := Copy(pValue, 1, 5);
    if TryStrToTime(lstrAux, ldtaAux) then
      lHrInicial := ldtaAux
    else
      lHrInicial := StrToTime('07:30');

    lstrAux := Copy(pValue, 7, 5);
    if TryStrToTime(lstrAux, ldtaAux) then
      lHrFinal := ldtaAux
    else
      lHrFinal := StrToTime('18:30');
  end;
  HroInicial.Time := lHrInicial;
  HroFim.Time := lHrFinal;
end;

end.
