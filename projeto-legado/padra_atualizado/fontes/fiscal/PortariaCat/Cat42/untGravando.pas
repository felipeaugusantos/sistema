unit untGravando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxProgressBar, untConstantes, StrUtils, DateUtils, untFuncoes,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  untTypesSistema, dxGDIPlusClasses, cxImage, Vcl.AppEvnts;

type
  TRecTempoEstimado = Record
    HorInicio: TTime;
    intPosicao: Integer;
    blnTempoRestante: Boolean;
  End;

  TfrmGravando = class(TForm)
    imgGravando: TcxImage;
    shaFundo: TShape;
    AppEvents: TApplicationEvents;
    lblTempoRestante: TLabel;
    tmrEstimado: TTimer;
    pnlInfo: TPanel;
    lblGravando: TLabel;
    pgbStatus: TcxProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrEstimadoTimer(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    intPrimeira: Integer;
    strTextoAnterior: string;
    FChave: String;
    Procedure pSetaTempoRestante(Value: Boolean);

  protected
    procedure pAlteraTexto(strCaption: String; const blnLimitarTexto: Boolean = True);
    procedure pRestauraTexto;
  public
    { Public declarations }
    blnDesabilitaMouse,
    blnConfirma: Boolean;

    recTempoEstimado: TRecTempoEstimado;

    fExecutarAcao: TFunctionFormGravando;

    FForcarExibirMensagemAguarde: Boolean;

    procedure pAtualizaTempoRestante;

    class var CorPadraoTema: TColor;

    class function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
    class function fExecutarModalA(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean; overload; static;

  published
    property strChave: String Read FChave Write FChave;

    property blnTempoRestante: Boolean Read recTempoEstimado.blnTempoRestante Write pSetaTempoRestante;

  end;

  function fRetInformacao(pgbStatus: TcxProgressBar): String;
  procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
  procedure pProcessMessages(ANow: Boolean = False);
  procedure SetForcarProcessMessages(const AValue: Boolean);

var
  frmGravando: TfrmGravando;
  frmGravandoGenericProcedure: TfrmGravando;

implementation

uses untGenericProcedureFormGravando;

var
  FLastProcessMessages: TDateTime;
  FForcarProcessMessages: Boolean;

{$R *.dfm}

procedure SetForcarProcessMessages(const AValue: Boolean);
begin
  FForcarProcessMessages := AValue;
end;

procedure pProcessMessages(ANow: Boolean = False);
begin
  If (FForcarProcessMessages) Or (ANow) Or (MilliSecondsBetween(Now(), FLastProcessMessages) >= 500) Then
  Begin
    Application.ProcessMessages;
    FLastProcessMessages := Now();
  End;
end;


function fRetInformacao(pgbStatus: TcxProgressBar): String;
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    Result := TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption;
  End;
end;

procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    pProcessMessages;
  End;
end;

function MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then
  begin
    Result := I >= 0;
    while I < 0 do begin
      Result := ShowCursor(LongBool(true)) >= 0;
      Inc(I);
    end;
  end
  else
  begin
    Result := I < 0;
    while I >= 0 do
    begin
      Result := ShowCursor(LongBool(false)) < 0;
      Dec(I);
    end;
  end;
end;

procedure TfrmGravando.FormCreate(Sender: TObject);
begin
  ShaFundo.Brush.Color := CorPadraoTema;
  pnlInfo.Color := CorPadraoTema;

  blnFecharForm := False;
  blnConfirma   := False;
  intPrimeira   := -1;

  fExecutarAcao := Nil;
  pgbStatus.Position := 0;

  blnDesabilitaMouse := False;
  FForcarExibirMensagemAguarde := False;

  FillChar(recTempoEstimado, Sizeof(recTempoEstimado), #0);
end;

procedure TfrmGravando.FormDestroy(Sender: TObject);
begin
  If blnDesabilitaMouse Then
    MouseShowCursor(True);
end;

procedure TfrmGravando.FormShow(Sender: TObject);
begin
  If blnDesabilitaMouse Then
    MouseShowCursor(False);
end;

class function TfrmGravando.fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
  var
    wrapper: TGenericProcedureFormGravando;
    blnCreateForm: Boolean;

  function GetFormGravando: Boolean;
  begin
    Result := Assigned(frmGravandoGenericProcedure);
    If Result Then
      frmGravandoGenericProcedure.pAlteraTexto(strTexto);
  end;

  procedure ResetarTexto;
  begin
    Result := Assigned(frmGravandoGenericProcedure);
    If Result Then
      frmGravandoGenericProcedure.pRestauraTexto;
  end;

  procedure Executar;
  begin
    Application.CreateForm(TfrmGravando, frmGravandoGenericProcedure);
    frmGravandoGenericProcedure.strChave := strChave;
    wrapper := TGenericProcedureFormGravando.Create(prcGen);
    frmGravandoGenericProcedure.fExecutarAcao := wrapper.functionFormGravando;
    frmGravandoGenericProcedure.pAlteraTexto(strTexto);
    frmGravandoGenericProcedure.pgbStatus.Visible := False;
    frmGravandoGenericProcedure.ShowModal;
    Result := frmGravandoGenericProcedure.blnConfirma;
  end;
begin
  wrapper := nil;
  blnCreateForm := False;

  Try
    Try
      if GetFormGravando then
      begin
        prcGen;
        ResetarTexto;
        Result := True;
      end
      else
      begin
        blnCreateForm := True;
        Executar;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(wrapper) then
      FreeAndNil(wrapper);
    if blnCreateForm And Assigned(frmGravandoGenericProcedure) then
      FreeAndNil(frmGravandoGenericProcedure);
  End;
end;

class function TfrmGravando.fExecutarModalA(const prcGen: TGenericProcedure;
  const strTexto, strChave: string): Boolean;
  Var
    frmAguarde: TfrmGravando;
    wrapper: TGenericProcedureFormGravando;

  procedure Executar;
  begin
    Application.CreateForm(TfrmGravando, frmAguarde);
    frmAguarde.strChave := strChave;
    wrapper := TGenericProcedureFormGravando.Create(prcGen);
    frmAguarde.fExecutarAcao := wrapper.functionFormGravando;
    frmAguarde.pAlteraTexto(strTexto);
    frmAguarde.pgbStatus.Visible := False;
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  end;

begin

  Try
    Try
      Executar;
    Except
      on E: Exception do
        raise;
    End;
  Finally
    If Assigned(wrapper) Then
      FreeAndNil(wrapper);

    If Assigned(frmAguarde) Then
      FreeAndNil(frmAguarde);
  End;
end;

procedure TfrmGravando.FormActivate(Sender: TObject);
begin
  Self.Repaint;

  If InterlockedIncrement(intPrimeira) = 0 Then
  Begin

    Try

      Try
        pProcessMessages(True);

        If      strChave = 'FATVENDAS'    Then pgbStatus.Properties.Max := 16
        Else If strChave = 'PEDCOM'       Then pgbStatus.Properties.Max := 6
        Else If strChave = 'CANCELAMENTO' Then pgbStatus.Properties.Max := 8
        Else If strChave = 'RCXIMPCUPVEL' Then pgbStatus.Properties.Max := 12;

        If Assigned(fExecutarAcao) Then
          blnConfirma := fExecutarAcao(pgbStatus);

      Except
        On E: EAbort Do
        Begin
          blnConfirma := False;
          raise;
        End;

        On E: ExceptionAutCom Do
        Begin
          blnConfirma := False;
          Raise ExceptionAutCom.Create(E.Message);
        End;

        On E: Exception Do
        Begin
          blnConfirma := False;
          Raise Exception.Create(E.Message);
        End;
      End;

    Finally
      Self.AppEvents.OnMessage := nil;
      If Assigned(Self.OnClose) Then
      Begin
        blnFecharForm := True;
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      End;
    End;

  End;

end;

procedure TfrmGravando.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If Not blnFecharForm Then
    Action := caNone;

end;

procedure TfrmGravando.pAlteraTexto(strCaption: String; const blnLimitarTexto: Boolean = True);

  function fRemoveAcento(Str:String): String;
    Const
      ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ"´';
      SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
    //Var
      //x : Integer;
  Begin
    {For x := 1 to Length(Str) do
      If Pos(Str[x],ComAcento)<>0 Then
        Str[x] := SemAcento[Pos(Str[x],ComAcento)];} //porque está tirando acento?? Falar com AF.
    Result := Str;
  end;

  function SetDescri(const strDescri: string): string;
  begin
    Result := fRemoveAcento(strDescri);
    if (blnLimitarTexto) And (Length(Result) > 59) then
      Result := LeftStr(Result, 56) + '...';
    Result := Result + #0;
  end;

begin
  strTextoAnterior := lblGravando.Caption;
  lblGravando.Caption := SetDescri(strCaption);
  pProcessMessages;
end;

procedure TfrmGravando.pRestauraTexto;
begin
  lblGravando.Caption := strTextoAnterior;
  pProcessMessages;
end;

Procedure TfrmGravando.pSetaTempoRestante(Value: Boolean);
Begin
  If Value <> recTempoEstimado.blnTempoRestante Then
  Begin
    recTempoEstimado.blnTempoRestante := Value;
    tmrEstimado.Enabled := Value;
    lblTempoRestante.Visible := Value;
  End;
End;

procedure TfrmGravando.tmrEstimadoTimer(Sender: TObject);
begin
  pAtualizaTempoRestante;
end;

procedure TfrmGravando.pAtualizaTempoRestante;
  Var
    timTempoEstimado: TTime;
    intPosicao: Integer;
begin
  If recTempoEstimado.HorInicio = 0 Then
    recTempoEstimado.HorInicio := Time;

  intPosicao := Trunc(pgbStatus.Position);

  If recTempoEstimado.intPosicao < intPosicao Then
  Begin
    recTempoEstimado.intPosicao := intPosicao;
    timTempoEstimado := ((pgbStatus.Properties.Max - intPosicao) * (Time - recTempoEstimado.HorInicio)) / intPosicao;
    lblTempoRestante.Caption := 'Tempo restante estimado: ' + FormatDateTime('HH:NN:SS', timTempoEstimado);
  End;
end;

initialization
  TfrmGravando.CorPadraoTema := ClGray;
  FLastProcessMessages := Now();
  FForcarProcessMessages := False;

finalization

end.
