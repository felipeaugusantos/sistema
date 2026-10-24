unit untControleRemoto;

interface

uses Classes, SysUtils, Windows, DateUtils, Forms, Dialogs, System.UITypes;

type
  TControleRemoto = class
    private
      class var FLock: Integer;
      class procedure pFinalizarControleRemoto();
      class procedure pFinalizarProcesso(strProcesso: string);
      class procedure pExecutarControleRemoto();
      class function fControleRemotoAberto(): Boolean;
      class procedure pExecutarInterna();
    public
      class procedure pExecutar();
  end;

implementation

{ TControleRemoto }

uses untFuncoesSimples, untGravando, untConstantes;

class function TControleRemoto.fControleRemotoAberto(): Boolean;
  Var
    strNomeJanela: String;
begin
  strNomeJanela := fCfgSis('REMNOM');
  Result := FindWindow(nil, PChar(strNomeJanela)) > 0;
end;

class procedure TControleRemoto.pExecutar();
begin
  Try
    If InterlockedIncrement(FLock) = 0 Then
    Begin
      Screen.Cursor := crHourGlass;
      pExecutarInterna;
      Screen.Cursor := crDefault;
    End;
  Finally
    InterlockedDecrement(FLock);
  End;
end;

class procedure TControleRemoto.pExecutarInterna();
begin
  pFinalizarControleRemoto;
  pExecutarControleRemoto;
end;

class procedure TControleRemoto.pExecutarControleRemoto();
  Const
    TEMPO_LIMITE_SEGUNDOS = 60;
  Var
    strExeName: AnsiString;
    strComandLine: AnsiString;
    horInicial: TDateTime;
begin
  strComandLine := AnsiString(fCfgSis('REMARQ'));
  strExeName := AnsiString(ExtractFileName(String(strComandLine)));

  If Not FileExists(String(strComandLine)) Then
    strComandLine := AnsiString(ExtractFilePath(Application.ExeName)) + 'Util\' + strExeName;

  If Not FileExists(String(strComandLine)) Then
  Begin
    pMensagemSonora('Não foi encontrado o arquivo "' +
      ExtractFileName(String(strComandLine)) + '". ' +
      'Favor entrar em contato com a Citel imediatamente!');
    Exit;
  End;

  horInicial := VS_Date + Time();

  If strExeName = EXE_ACESSO_REMOTO_CITEL Then
    strComandLine := strComandLine +
      ' --operador="' +
      AnsiString(strLoginUsuarioLogado + ' - ' +
        fTiraCaracEspeciais(fRetNomeOperador(strLoginUsuarioLogado)).ToUpper) +
      '" --cnpj="' +
      AnsiString(fTiraCaracEspeciais(fCadEmp('C_G_C_'))) + '"';

  WinExec(PAnsiChar(strComandLine), SW_NORMAL);

  Repeat
    Application.ProcessMessages;
    Sleep(1000);

    If SecondsBetween(VS_Date + Time(), horInicial) > TEMPO_LIMITE_SEGUNDOS Then
    Begin
      pFinalizarControleRemoto;

      pMensagemSonora('Excedido tempo limite para abertura do software para controle remoto "' +
        ExtractFileName(String(strComandLine)) + '". ' +
        'Favor entrar em contato com a Citel imediatamente!');
      Break;
    End;

  Until fControleRemotoAberto();

  Windows.setFocus(0);
end;

class procedure TControleRemoto.pFinalizarProcesso(strProcesso: string);
begin
  KillProcessStartsWith(strProcesso);
end;

class procedure TControleRemoto.pFinalizarControleRemoto();
  Var
    stlProcessos: TStringList;
    strProcesso: String;
begin
  stlProcessos := TStringList.Create;
  stlProcessos.CommaText := fCfgSis('REMFIN');

  For strProcesso In stlProcessos Do
    pFinalizarProcesso(strProcesso.Trim);

  stlProcessos.Free;

  Sleep(3000);
end;

initialization
  TControleRemoto.FLock := -1;

end.
