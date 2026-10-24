unit untFuncoesInicializarLibContasBancarias;

interface

uses
  System.Classes, System.IOUtils, Vcl.Forms, System.SysUtils, Vcl.Menus,
  WinApi.Windows, System.Generics.Collections, Vcl.StdCtrls, System.StrUtils,
  Data.DB, cxEdit, cxRadioGroup, cxEditRepositoryItems, cxCurrencyEdit,
  cxTextEdit, Uni, UniClientDataset, cxButtonEdit, untInterfacesLibContasBancariasAutcom,
  untTLibContasBancariasAutcom, untTypesSistema, untFuncoesSimples, untExtratoBaseClass
  {$IF Declared(VS_TELAS_ABERTAS_EXISTE)}, untTelasAbertas{$ENDIF};

type
  TLibContasBancarias = class
  private
    class var
      FHandleLibContasBancarias: THandle;
      FObjetoLibContasBancarias: ILibContasBancarias;
      FInicializaObjetoLibContasBancarias: procedure(AObjetoLibContasBancarias: ILibContasBancarias); StdCall;
      FSetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;
      FImportarContasBancarias: function: String; stdcall;
      FConsultaSaldoContasBancarias: procedure; StdCall;
      FdxInitialize: procedure; StdCall;
      FdxFinalize: procedure; StdCall;

    class function ObterCaminhoDLL: string;
    class procedure CarregarFuncoesDLL;
    class procedure InicializarDLL;
    class function DLLExiste: Boolean;
  public
    class procedure CarregarDLL;
    class procedure Finalizar;

    class procedure ConsultarSaldoContaBancaria;
    class function ImportarExtratoBancario: String;
  end;

implementation

{ TLibContasBancarias }

class function TLibContasBancarias.ObterCaminhoDLL: string;
begin
  Result := ExtractFilePath(Application.ExeName) + 'libIntegracaoContasBancarias.dll';
end;

class function TLibContasBancarias.DLLExiste: Boolean;
var
  LCaminhoDLL: string;
begin
  LCaminhoDLL := ObterCaminhoDLL;
  Result := FileExists(LCaminhoDLL);

  if not Result then
  begin
    fMensagem(
      'ATENÇÃO',
      'O arquivo ' + LCaminhoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',
      ['&OK']
    );
  end;
end;

class procedure TLibContasBancarias.CarregarFuncoesDLL;
begin
  FdxInitialize := GetProcAddress(FHandleLibContasBancarias, 'dxInitialize');
  FdxFinalize := GetProcAddress(FHandleLibContasBancarias, 'dxFinalize');
  FInicializaObjetoLibContasBancarias := GetProcAddress(FHandleLibContasBancarias, 'InicializaObjetoLibContasBancarias');
  FSetStyleAutcom := GetProcAddress(FHandleLibContasBancarias, 'SetStyleAutcom');
  FImportarContasBancarias := GetProcAddress(FHandleLibContasBancarias, 'ImportarContasBancarias');
  FConsultaSaldoContasBancarias := GetProcAddress(FHandleLibContasBancarias, 'ConsultaSaldoContasBancarias');
end;

class procedure TLibContasBancarias.InicializarDLL;
begin
  if Assigned(FdxInitialize) then
    FdxInitialize();

  FObjetoLibContasBancarias := TILibContasBancariasAutcom.Create;

  if Assigned(FInicializaObjetoLibContasBancarias) then
    FInicializaObjetoLibContasBancarias(FObjetoLibContasBancarias);

  if Assigned(FSetStyleAutcom) then
    FSetStyleAutcom(FObjetoLibContasBancarias.fIExecutandoModoClassico);
end;

class procedure TLibContasBancarias.CarregarDLL;
begin
  if FHandleLibContasBancarias <> 0 then
    Exit;

  if not DLLExiste then
    Exit;

  FHandleLibContasBancarias := LoadLibrary(PChar(ObterCaminhoDLL));
  if FHandleLibContasBancarias = 0 then
  begin
    fMensagem(
      'ERRO',
      'Não foi possível carregar a biblioteca de integração com contas bancárias.',
      ['&OK']
    );
    Exit;
  end;

  try
    CarregarFuncoesDLL;
    InicializarDLL;

  except
    on E: Exception do
    begin
      fMensagem(
        'ERRO',
        'Erro ao inicializar a biblioteca: ' + E.Message,
        ['&OK']
      );
      Finalizar;
    end;
  end;
end;

class procedure TLibContasBancarias.Finalizar;
begin
  if Assigned(FdxFinalize) then
    FdxFinalize;

  FObjetoLibContasBancarias := nil;
  FdxFinalize := nil;

  FdxInitialize := nil;
  FInicializaObjetoLibContasBancarias := nil;
  FSetStyleAutcom := nil;
  FImportarContasBancarias := nil;
  FConsultaSaldoContasBancarias := nil;

  if FHandleLibContasBancarias <> 0 then
  begin
    FreeLibrary(FHandleLibContasBancarias);
    FHandleLibContasBancarias := 0;
  end;
end;

class procedure TLibContasBancarias.ConsultarSaldoContaBancaria;
begin
  if not DLLExiste then
    Exit;

  CarregarDLL;

  if not Assigned(FConsultaSaldoContasBancarias) then
  begin
    fMensagem(
      'ERRO',
      'Função de consulta de saldo não disponível na biblioteca.',
      ['&OK']
    );
    Exit;
  end;

  Try
   FConsultaSaldoContasBancarias;
  Finally
   Finalizar;
  End;
end;

class function TLibContasBancarias.ImportarExtratoBancario: String;
begin
  if not DLLExiste then
    Exit;

  CarregarDLL;

  if not Assigned(FImportarContasBancarias) then
  begin
   fMensagem(
      'ERRO',
      'Função de importação de extrato não disponível na biblioteca.',
      ['&OK']
    );
    Exit;
  end;

  try
    Result := FImportarContasBancarias();
  finally
    Finalizar;
  end;
end;

end.
