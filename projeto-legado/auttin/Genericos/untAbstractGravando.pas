unit untAbstractGravando;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untIGravando, StdCtrls, AppEvnts, Menus, ExtCtrls, Gauges, CheckLst,
  untStatusGravando, untIGravandoExecucao,
  BitBtnLockedIncrem, Buttons, DateUtils, StrUtils, Math, ActnList,
  System.Actions;

type
  TfrmAbstractGravando = class(TForm, IGravando)
    prgProgresso: TGauge;
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    pnlCabecalho: TPanel;
    mmoSaida: TMemo;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    grpOpcoes: TGroupBox;
    chklstOpcoes: TCheckListBox;
    btnSair: TBitBtnLocked;
    btnConfirmaGeracao: TBitBtnLocked;
    actlstPadrao: TActionList;
    actCancelar: TAction;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    stlAnimacao: TStrings;
    intMaximoLarguraAnimacao: Integer;
    function GetMaximoLarguraAnimacao: Integer;
  protected
    status: TStatusGravando;
    gravandoExecucao: IGravandoExecucao;
    tmrInicio: TTime;
    procedure AjustarAnimacao(const stlAnimacao: TStrings); virtual;
  public
    procedure Cancelar;
    function GetStatus: TStatusGravando;
    function GetTexto: string;
    procedure RegistrarProgresso(intInicio: Integer; intAtual: Integer; intFinal: Integer);
    procedure ResetarProgresso();
    procedure SetTexto(strTexto: string);
    procedure AnimarEsperar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmAbstractGravando: TfrmAbstractGravando;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmAbstractGravando }

procedure TfrmAbstractGravando.AjustarAnimacao(const stlAnimacao: TStrings);
begin
  stlAnimacao.Add('[|]');
  stlAnimacao.Add('[/]');
  stlAnimacao.Add('[-]');
  stlAnimacao.Add('[\]');
end;

procedure TfrmAbstractGravando.AnimarEsperar;
var
  strTexto: string;
  strAmpulheta: string;

  procedure AjustaTexto;
  begin
    strTexto := Copy(strTexto, 0, Length(strTexto) - (intMaximoLarguraAnimacao + 1)) +
      RightStr(StringOfChar(' ', intMaximoLarguraAnimacao + 1) + strAmpulheta, intMaximoLarguraAnimacao + 1);
  end;
begin
  if stlAnimacao.Count = 0 then
    Exit;

  strTexto := Trim(mmoSaida.Lines.Text);
  strAmpulheta := Trim(RightStr(strTexto, (intMaximoLarguraAnimacao + 1)));

  if stlAnimacao.IndexOf(strAmpulheta) < 0 then
  begin
    strAmpulheta := stlAnimacao[0];
    strTexto := strTexto + RightStr(StringOfChar(' ', intMaximoLarguraAnimacao + 1) + strAmpulheta, intMaximoLarguraAnimacao + 1);
  end
  else
  begin
    strAmpulheta := stlAnimacao[(stlAnimacao.IndexOf(strAmpulheta) + 1) mod stlAnimacao.Count];
  end;

  AjustaTexto;

  mmoSaida.Lines.Text := strTexto;
  Application.ProcessMessages;
end;

procedure TfrmAbstractGravando.btnSairClick(Sender: TObject);
begin
  if Assigned(gravandoExecucao) and (status = sgGravando) then
  begin
    if fMensagem('ATENÇÃO', 'Você está executando um processo de gravação, deseja cancelar esse processo?', ['&NÃO','&SIM']) = 2 then
    begin
      ResetarProgresso;
      Cancelar;
    end;
  end
  else
    Close;
end;

procedure TfrmAbstractGravando.Cancelar;
begin
  status := sgCancelado;
  SetTexto('O Processo foi cancelado');
end;

constructor TfrmAbstractGravando.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Caption := pnlCabecalho.Caption;
  status := sgIniciando;
  tmrInicio := 0;
  stlAnimacao := TStringList.Create;
  AjustarAnimacao(stlAnimacao);
  intMaximoLarguraAnimacao := GetMaximoLarguraAnimacao;
end;

destructor TfrmAbstractGravando.Destroy;
begin
  if Assigned(stlAnimacao) then FreeAndNil(stlAnimacao);
  inherited;
end;

procedure TfrmAbstractGravando.FormShow(Sender: TObject);
begin
  pSetFocus(chklstOpcoes);
  prgProgresso.Top := grpOpcoes.Top + grpOpcoes.Height; 
end;

function TfrmAbstractGravando.GetMaximoLarguraAnimacao: Integer;
var
  strAnimacao: string;
begin
  Result := 0;
  for strAnimacao in stlAnimacao do
  begin
    Result := Max(Result, Length(strAnimacao));
  end;  
    
end;

function TfrmAbstractGravando.GetStatus: TStatusGravando;
begin
  Result := status;
end;

function TfrmAbstractGravando.GetTexto: string;
begin
  Result := mmoSaida.Lines[mmoSaida.Lines.Count - 1];
end;

procedure TfrmAbstractGravando.RegistrarProgresso(intInicio, intAtual, intFinal: Integer);
var
  intSegundos: Integer;
begin
  Try
    prgProgresso.MaxValue := intFinal;
    prgProgresso.MinValue := intInicio;
    prgProgresso.Progress := intAtual;

    if Abs(intAtual - intInicio) <= 1 then
      tmrInicio := fNow();
    

    if intAtual <> intInicio then
    begin
      intSegundos := SecondsBetween(fNow(), tmrInicio);

      if intSegundos > 0 then
      begin
        pnlInfo.Caption:= Format('Processando %d / %d  (Registros por Segundo: %d) (Restante: %s)', [intAtual, intFinal,
          Trunc((intAtual - intInicio) / intSegundos),
          TimeToStr((intFinal - intAtual) * (fNow() - tmrInicio) / (intAtual - intInicio))
        ]);
      end
      else
      begin
        pnlInfo.Caption:= Format('Processando %d / %d (Restante: %s)', [intAtual, intFinal,
          TimeToStr((intFinal - intAtual) * (fNow() - tmrInicio) / (intAtual - intInicio))
        ]);
      end;
    end
    else
    begin
      pnlInfo.Caption:= Format('Processando %d / %d', [intAtual, intFinal]);
    end;  

    Application.ProcessMessages;

  Except
    on E: Exception do
    begin
    end;
  End;

end;

procedure TfrmAbstractGravando.ResetarProgresso;
begin
  tmrInicio := 0;
  RegistrarProgresso(prgProgresso.MinValue, prgProgresso.MinValue, prgProgresso.MaxValue);
end;

procedure TfrmAbstractGravando.SetTexto(strTexto: string);
begin
  mmoSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strTexto);
end;

end.
