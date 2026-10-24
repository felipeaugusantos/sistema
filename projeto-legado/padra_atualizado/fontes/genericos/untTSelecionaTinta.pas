unit untTSelecionaTinta;

interface

uses
  System.SysUtils, Tintas.View.Interfaces, Data.DB, System.StrUtils,
  System.Classes, System.Generics.Collections, Vcl.Forms,
  untFuncTinta, untFuncoesSimples
  {$IFDEF TESTABILIDADE_AUTCOM}
  ;
  {$Else}
  , Principal.View.FMXPrincipal
  , Tintas.View.FMXEscolheTinta;
  {$ENDIF}

type
  TSelecionaTinta = class(TInterfacedObject, ISelecionaTinta)
  private
    FLista: TStringList;
    FCodCli: String;
    FProAca,
    FCampanha: Boolean;

    procedure CarregarListaTintas;

  public
    function SetListaTintas(ALista: TStringList):ISelecionaTinta;
    function GetListaTintas: TStringList;
    function EscolheTintaNovo: ShortString;

    constructor Create(ACodCli: String; AProAca, ACampanha: Boolean);
  end;

function fEscolheTintaNovo(strCodCli:String; blnProAca: Boolean = True; blnCampanha: Boolean = False): String;

implementation

function fEscolheTintaNovo(strCodCli:String; blnProAca: Boolean = True; blnCampanha: Boolean = False): String;
Var
  objSelTinta: ISelecionaTinta;
begin
  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    objSelTinta := TSelecionaTinta.Create(strCodCli, blnProAca, blnCampanha);
    Result      := String(objSelTinta.EscolheTintaNovo);
  End
  Else
    Result      := String(fEscolheTinta(strCodCli, blnProAca, blnCampanha));
end;

{ TSelecionaTinta }

procedure TSelecionaTinta.CarregarListaTintas;
begin
  FLista := fGetListaTintas(FCodCli, FProAca, FCampanha);
end;

constructor TSelecionaTinta.Create(ACodCli: String; AProAca, ACampanha: Boolean);
begin
  FCodCli   := ACodCli;
  FProAca   := AProAca;
  FCampanha := ACampanha;
  FLista    := Nil;
end;

function TSelecionaTinta.EscolheTintaNovo: ShortString;
var
  LLogTmr: ILogTmr;
begin
  CarregarListaTintas;

{$IFDEF TESTABILIDADE_AUTCOM}
  Result := '';
{$ELSE}
  DefineStatusActionAtalhos(False);
  try
    TNewTimer.SuspendedTimers.Add('frmPrincipal');
    try
      LLogTmr := TLogTmr.New('TNewTimer.SuspendedTimers.Add(frmPrincipal)')
        .Enter('FMXEscolheTinta.SelecionaTinta');
      try
        Result := Tintas.View.FMXEscolheTinta.SelecionaTinta(FLista);
      finally
        LLogTmr.Exit('TNewTimer.SuspendedTimers.Remove(frmPrincipal)');
      end;
    finally
      TNewTimer.SuspendedTimers.Remove('frmPrincipal');
    end;
  finally
    DefineStatusActionAtalhos(True);
  end;
{$ENDIF}
end;

function TSelecionaTinta.GetListaTintas: TStringList;
begin
  Result := FLista;
end;

function TSelecionaTinta.SetListaTintas(ALista: TStringList): ISelecionaTinta;
begin
  Result := Self;
  FLista := ALista;
end;

end.
