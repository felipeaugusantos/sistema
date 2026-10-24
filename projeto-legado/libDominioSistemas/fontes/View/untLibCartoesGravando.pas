unit untLibCartoesGravando;

interface

uses
  WinAPI.Windows, WinAPI.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.StrUtils, System.DateUtils, Vcl.AppEvnts,

  cxControls, cxContainer, cxEdit, cxProgressBar, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxGDIPlusClasses, cxImage,

  untDominioSistemasTelasAbertas, untLibDominioSistemasInterfacesTipos, untDominioSistemasConstantes;

type
  TFncFormGravandoKeyDow = reference to procedure (Sender: TObject; var Key: Word; Shift: TShiftState);

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
    lblEscCancelar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tmrEstimadoTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    intPrimeira: Integer;
    strTextoAnterior: string;
    FChave: String;
    FTelas: ITelasAbertas;
    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;
    Procedure pSetaTempoRestante(Value: Boolean);
    procedure CarregarImagemLogo;

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
    class function fExecutarModalA(const fExecutaAcao: TReferenceFunctionProgresso; const strTexto, strChave: string): Boolean; overload; static;
    class function fNotificacaoSistema(const fExecutaAcao: TReferenceFunctionProgresso; const strTexto: string; const CorFonte: TColor; const blnNegrito: Boolean): Boolean; static;

    Class Function fExecuta(fExecutaAcao: TFunctionFormGravando; Var frmGravando: TfrmGravando; strTitulo: String = '';
                            blnMostrarProgresso: Boolean = True;
                            blnTempoRestante: Boolean = False): Boolean;

  published
    property strChave: String Read FChave Write FChave;

    property blnTempoRestante: Boolean Read recTempoEstimado.blnTempoRestante Write pSetaTempoRestante;

  end;

  function fRetInformacao(pgbStatus: TcxProgressBar): String;
  procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
  procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
  procedure pProcessMessages(ANow: Boolean = False);
  procedure SetForcarProcessMessages(const AValue: Boolean);

var
  frmGravando: TfrmGravando;
  frmGravandoGenericProcedure: TfrmGravando;
  prcMenOK : TProcMensagemOK;
  fncFormGravandoKeyDow : TFncFormGravandoKeyDow;

implementation

uses untGenericProcedureFormGravando;

var
  FLastCaption: String;
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

procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
var
  lblGravando: TLabel;
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando'));
    lblGravando.Caption := strInfo;

    If (Not VS_ExibirMensagemAguarde) And Assigned(VS_OnMensagemAguarde) And (lblGravando.Caption <> FLastCaption) Then
    Begin
      FLastCaption := lblGravando.Caption;
      VS_OnMensagemAguarde(FLastCaption);
    End;
    pProcessMessages;
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
  If Assigned(fncFormGravandoKeyDow) Then
  Begin
    Self.KeyPreview := True;
    lblEscCancelar.Visible := True;
  End;

  ShaFundo.Brush.Color := CorPadraoTema;
  pnlInfo.Color := CorPadraoTema;

  blnFecharForm := False;
  blnConfirma   := False;
  intPrimeira   := -1;

  fExecutarAcao := Nil;
  pgbStatus.Position := 0;

  blnDesabilitaMouse := False;
  FForcarExibirMensagemAguarde := False;

  pEmpilharTelaAberta;

  FillChar(recTempoEstimado, Sizeof(recTempoEstimado), #0);
end;

procedure TfrmGravando.FormDestroy(Sender: TObject);
begin
  If blnDesabilitaMouse Then
    MouseShowCursor(True);

  pRemoverTelaAberta;
end;

procedure TfrmGravando.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Not Assigned(fncFormGravandoKeyDow)) Then
    Exit;
  fncFormGravandoKeyDow(Sender, Key, Shift);
end;

procedure TfrmGravando.FormShow(Sender: TObject);
  Var
    aHandle      : THandle;
    wrdTexto     : Word;
begin
  CarregarImagemLogo;

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


class function TfrmGravando.fNotificacaoSistema(const fExecutaAcao: TReferenceFunctionProgresso; const strTexto: string; const CorFonte: TColor; const blnNegrito: Boolean): Boolean;
  Var
    frmAguarde: TfrmGravando;
    wrapper: TGenericProcedureFormGravando;

  procedure Executar;
    Var
      FontStyle : TFontStyles;
  begin
    Application.CreateForm(TfrmGravando, frmAguarde);
    frmAguarde.strChave := EmptyStr;
    wrapper := TGenericProcedureFormGravando.Create(fExecutaAcao);
    frmAguarde.pgbStatus.Visible := False;
    frmAguarde.lblGravando.Font.Color := CorFonte;
    FontStyle := [];
    If (blnNegrito) Then
      FontStyle := FontStyle + [fsBold];
    frmAguarde.lblGravando.Font.Style := FontStyle;
    frmAguarde.fExecutarAcao := wrapper.functionFormGravandoProgresso;
    frmAguarde.pAlteraTexto(strTexto, False);
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

class function TfrmGravando.fExecutarModalA(const fExecutaAcao: TReferenceFunctionProgresso;
  const strTexto, strChave: string): Boolean;
  Var
    frmAguarde: TfrmGravando;
    wrapper: TGenericProcedureFormGravando;

  procedure Executar;
  begin
    Application.CreateForm(TfrmGravando, frmAguarde);
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

procedure TfrmGravando.FormActivate(Sender: TObject);
begin
  Self.Repaint;

  If (Not FForcarExibirMensagemAguarde) and (Not VS_ExibirMensagemAguarde) Then
    Self.Hide;

  If InterlockedIncrement(intPrimeira) = 0 Then
  Begin

    Try
      Self.AppEvents.OnMessage := Self.AppEventsMessage;
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

procedure TfrmGravando.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If Not blnFecharForm Then
    Action := caNone;

end;

procedure TfrmGravando.pAlteraTexto(strCaption: String; const blnLimitarTexto: Boolean = True);

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
    if (blnLimitarTexto) And (Length(Result) > 59) then
      Result := LeftStr(Result, 56) + '...';
    Result := Result + #0;
  end;

begin
  strTextoAnterior := lblGravando.Caption;
  lblGravando.Caption := SetDescri(strCaption);
  pProcessMessages;
end;

procedure TfrmGravando.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmGravando.pRestauraTexto;
begin
  lblGravando.Caption := strTextoAnterior;
  pProcessMessages;
end;

procedure TfrmGravando.AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
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

procedure TfrmGravando.CarregarImagemLogo;
var
  LFilePath: string;
begin
  LFilePath := ExtractFilePath(ParamStr(0)) + 'untGravando.png';

  if FileExists(LFilePath) then
    imgGravando.Picture.LoadFromFile(LFilePath);
end;

Class Function TfrmGravando.fExecuta(fExecutaAcao: TFunctionFormGravando;
                                     Var frmGravando: TfrmGravando; strTitulo: String = '';
                                     blnMostrarProgresso: Boolean = True;
                                     blnTempoRestante: Boolean = False): Boolean;
Begin
  Try
    Application.CreateForm(TfrmGravando, frmGravando);

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

procedure TfrmGravando.pEmpilharTelaAberta;
begin
  FTelas := untDominioSistemasTelasAbertas.objTelasAbertas;
  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

initialization
  TfrmGravando.CorPadraoTema := ClGray;
  FLastProcessMessages := Now();
  FForcarProcessMessages := False;
  prcMenOK := nil;
  fncFormGravandoKeyDow := Nil;

finalization
  prcMenOK := nil;
  fncFormGravandoKeyDow := Nil;

end.
