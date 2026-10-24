unit untLibCartoesGravandoOld;

interface

uses
  WinAPI.Windows, WinAPI.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.StrUtils, System.DateUtils, Vcl.AppEvnts,

  cxControls, cxContainer, cxEdit, cxProgressBar, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxGDIPlusClasses, cxImage,

  untLibCartoesInterfacesTipos, untLibCartoesConstantes, untTLibCartoesFuncoes;

type
  TRecTempoEstimado = Record
    HorInicio: TTime;
    intPosicao: Integer;
    blnTempoRestante: Boolean;
  End;

  TfrmGravandoOld = class(TForm)
    imgGravando: TImage;
    lblGravando: TLabel;
    pgbStatus: TcxProgressBar;
    imgCarregando: TcxImage;
    pgbStatus2: TcxProgressBar;
    AppEvents: TApplicationEvents;
    lblTempoRestante: TLabel;
    tmrEstimado: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tmrEstimadoTimer(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    intPrimeira: Integer;
    strTextoAnterior: string;
    FChave: String;
    FLastCaption: String;

    Procedure pSetaTempoRestante(Value: Boolean);

  protected
    procedure pAlteraTexto(strCaption: String);
    procedure pRestauraTexto;
  public
    { Public declarations }
    blnDesabilitaMouse,
    blnConfirma: Boolean;
    recTempoEstimado: TRecTempoEstimado;

    fExecutarAcao: TFunctionFormGravando;

    procedure pAtualizaTempoRestante;

    class function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
    class function fExecutarModalA(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean; overload; static;
    class function fExecutarModalA(const fExecutaAcao: TReferenceFunctionProgresso; const strTexto, strChave: string): Boolean; overload; static;

    Class Function fExecuta(fExecutaAcao: TFunctionFormGravando; Var frmGravando: TfrmGravandoOld; strTitulo: String = '';
                            blnMostrarProgresso: Boolean = True;
                            blnTempoRestante: Boolean = False): Boolean;

  published
    property strChave: String Read FChave Write FChave;
    property blnTempoRestante: Boolean Read recTempoEstimado.blnTempoRestante Write pSetaTempoRestante;
  end;

  function fRetInformacao(pgbStatus: TcxProgressBar): String;
  procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
  procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);

var
  frmGravando: TfrmGravandoOld;
  frmGravandoGenericProcedure: TfrmGravandoOld;
  prcMenOK : TProcMensagemOK;

implementation

uses untGenericProcedureFormGravando;

{$R *.dfm}

procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (pgbStatus.Parent.FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(pgbStatus.Parent.FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

function fRetInformacao(pgbStatus: TcxProgressBar): String;
begin
  If Assigned(pgbStatus) And (pgbStatus.Parent.FindComponent('lblGravando') <> Nil) Then
  Begin
    Result := TLabel(pgbStatus.Parent.FindComponent('lblGravando')).Caption;
  End;
end;

procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    Application.ProcessMessages;
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

procedure TfrmGravandoOld.FormCreate(Sender: TObject);
begin
  FillChar(recTempoEstimado, Sizeof(recTempoEstimado), #0);

  blnFecharForm := False;
  blnConfirma   := False;
  intPrimeira   := -1;

  fExecutarAcao := Nil;
  pgbStatus.Position := 0;

  blnDesabilitaMouse := False;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    Self.Icon := TLibCartoesFuncoes.FIconeAplicacao;

  Self.Caption := EmptyStr;
end;

procedure TfrmGravandoOld.FormDestroy(Sender: TObject);
begin
  If blnDesabilitaMouse Then
    MouseShowCursor(True);
end;

procedure TfrmGravandoOld.FormShow(Sender: TObject);
  Var
    aHandle      : THandle;
    wrdTexto     : Word;
begin
  If blnDesabilitaMouse Then
    MouseShowCursor(False);

  If Not VS_ExibirMensagemAguarde Then
  Begin
    If Assigned(VS_OnMensagemAguarde) Then
      VS_OnMensagemAguarde(lblGravando.Caption);

    aHandle := FindWindow('TfrmAutcomSvc', Nil);
    If aHandle > 0 Then
    Begin
      wrdTexto := GlobalAddAtom(Pchar(lblGravando.Caption));
      SendMessage(aHandle,CM_AVISOS,0,wrdTexto);
      GlobalDeleteAtom(wrdTexto);
    End;

  End;
end;

class function TfrmGravandoOld.fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
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
    Application.CreateForm(TfrmGravandoOld, frmGravandoGenericProcedure);
    frmGravandoGenericProcedure.strChave := strChave;
    wrapper := TGenericProcedureFormGravando.Create(prcGen);
    frmGravandoGenericProcedure.fExecutarAcao := wrapper.functionFormGravando;
    frmGravandoGenericProcedure.pAlteraTexto(strTexto);
    frmGravandoGenericProcedure.pgbStatus.Visible := False;
    frmGravandoGenericProcedure.ShowModal;
    Result := frmGravandoGenericProcedure.blnConfirma;
  end;
begin
  If Not VS_ExibirMensagemAguarde Then
  Begin
    prcGen;
    Exit(True);
  End;

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

class function TfrmGravandoOld.fExecutarModalA(const fExecutaAcao: TReferenceFunctionProgresso;
  const strTexto, strChave: string): Boolean;
  Var
    frmAguarde: TfrmGravandoOld;
    wrapper: TGenericProcedureFormGravando;

  procedure Executar;
  begin
    Application.CreateForm(TfrmGravandoOld, frmAguarde);
    frmAguarde.strChave := strChave;
    wrapper := TGenericProcedureFormGravando.Create(fExecutaAcao);
    frmAguarde.fExecutarAcao := wrapper.functionFormGravandoProgresso;
    frmAguarde.pAlteraTexto(strTexto);
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  end;

begin
  If Not VS_ExibirMensagemAguarde Then
  Begin
    fExecutaAcao(Nil);
    Exit(True);
  End;

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

class function TfrmGravandoOld.fExecutarModalA(const prcGen: TGenericProcedure;
  const strTexto, strChave: string): Boolean;
  Var
    frmAguarde: TfrmGravandoOld;
    wrapper: TGenericProcedureFormGravando;

  procedure Executar;
  begin
    Application.CreateForm(TfrmGravandoOld, frmAguarde);
    frmAguarde.strChave := strChave;
    wrapper := TGenericProcedureFormGravando.Create(prcGen);
    frmAguarde.fExecutarAcao := wrapper.functionFormGravando;
    frmAguarde.pAlteraTexto(strTexto);
    frmAguarde.pgbStatus.Visible := False;
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  end;

begin
  If Not VS_ExibirMensagemAguarde Then
  Begin
    prcGen;
    Exit(True);
  End;

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

procedure TfrmGravandoOld.FormActivate(Sender: TObject);
begin
  If Not VS_ExibirMensagemAguarde Then
    Self.Hide;

  If InterlockedIncrement(intPrimeira) = 0 Then
  Begin

    Try
      Self.AppEvents.OnMessage := Self.AppEventsMessage;
      Try
        Application.ProcessMessages;

        If      strChave = 'FATVENDAS'    Then pgbStatus.Properties.Max := 16
        Else If strChave = 'PEDCOM'       Then pgbStatus.Properties.Max := 6
        Else If strChave = 'CANCELAMENTO' Then pgbStatus.Properties.Max := 8
        Else If strChave = 'RCXIMPCUPVEL' Then pgbStatus.Properties.Max := 12;

        If Assigned(fExecutarAcao) Then
          blnConfirma := fExecutarAcao(pgbStatus);

      Except
        On E: ExceptionAutCom Do
        Begin
          blnConfirma := False;
          if assigned(prcMenOK) then
            prcMenOK(E.Message)
          else
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

procedure TfrmGravandoOld.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If Not blnFecharForm Then
    Action := caNone;

end;

procedure TfrmGravandoOld.pAlteraTexto(strCaption: String);

  function fRemoveAcento(Str:String): String;
    Const
      ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
      SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
    //Var
      //x : Integer;
  Begin
    {For x := 1 to Length(Str) do
      If Pos(Str[x],ComAcento)<>0 Then
        Str[x] := SemAcento[Pos(Str[x],ComAcento)];} //porque est· tirando acento?? Falar com AF.
    Result := Str;
  end;

  function SetDescri(const strDescri: string): string;
  begin
    Result := fRemoveAcento(strDescri);
    if Length(Result) > 59 then
      Result := LeftStr(Result, 56) + '...';
    Result := Result + #0;
  end;

begin
  strTextoAnterior := lblGravando.Caption;
  lblGravando.Caption := SetDescri(strCaption);
  Application.ProcessMessages;
end;

procedure TfrmGravandoOld.pRestauraTexto;
begin
  lblGravando.Caption := strTextoAnterior;
  Application.ProcessMessages;
end;

procedure TfrmGravandoOld.AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  If (Msg.hwnd = Self.Handle) Then
  Begin
    If (Not VS_ExibirMensagemAguarde) And Assigned(VS_OnMensagemAguarde) And (lblGravando.Caption <> FLastCaption) Then
    Begin
      FLastCaption := lblGravando.Caption;
      VS_OnMensagemAguarde(FLastCaption);
    End;
  End;
end;

Class Function TfrmGravandoOld.fExecuta(fExecutaAcao: TFunctionFormGravando;
                                     Var frmGravando: TfrmGravandoOld; strTitulo: String = '';
                                     blnMostrarProgresso: Boolean = True;
                                     blnTempoRestante: Boolean = False): Boolean;
Begin
  Try
    Application.CreateForm(TfrmGravandoOld, frmGravando);

    If strTitulo <> '' Then
      frmGravando.lblGravando.Caption := strTitulo;

    If Not blnMostrarProgresso Then
      frmGravando.pgbStatus.Visible := False;

    frmGravando.fExecutarAcao := fExecutaAcao;

    frmGravando.blnTempoRestante := blnTempoRestante;

    If Not VS_ExibirMensagemAguarde Then
    Begin
      Result := fExecutaAcao(frmGravando.pgbStatus);
    End
    Else
    Begin
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    End;

  Finally
    FreeAndNil(frmGravando);
  End;

End;

Procedure TfrmGravandoOld.pSetaTempoRestante(Value: Boolean);
Begin
  If Value <> recTempoEstimado.blnTempoRestante Then
  Begin
    recTempoEstimado.blnTempoRestante := Value;
    tmrEstimado.Enabled := Value;
    lblTempoRestante.Visible := Value;
  End;
End;

procedure TfrmGravandoOld.tmrEstimadoTimer(Sender: TObject);
begin
  pAtualizaTempoRestante;
end;

procedure TfrmGravandoOld.pAtualizaTempoRestante;
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
  prcMenOK := nil;

finalization
  prcMenOK := nil;

end.
