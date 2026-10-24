unit untWhatsapp;

interface

uses
  System.Classes, System.SysUtils, untTypesSistema, untDadosEnviaWhatsapp;

type
  TWhatsapp = class
  private
  public
    class function fEnviarWhatsapp(strCodCli,
                                   strMensagem: String;
                                   recArquivo: TArray<TRecArquivosGatilhos>;
                                   blnUtilizarThread: Boolean): Boolean;
  end;

implementation

uses untFuncoes, untFuncoesSimples, untDllGatIme;

class function TWhatsapp.fEnviarWhatsapp(strCodCli,
                                         strMensagem: String;
                                         recArquivo: TArray<TRecArquivosGatilhos>;
                                         blnUtilizarThread: Boolean): Boolean;
var
  strAutIncCtt,
  strCelular: String;
  strFilaEnv: String;

  DadosEnviaWhatsapp: TDadosEnviaWhatsapp;
  LstrJson: String;
begin
  Result := True;
  try
    if not fRetFilaEContatoEnvio(strAutIncCtt,
                                 strCelular,
                                 strFilaEnv,
                                 strCodCli,
                                 IIF(fEmptyStr(strCodCli), 'Contato', ''),
                                 '',
                                 '',
                                 True) then
      Exit(False);

    DadosEnviaWhatsapp := TDadosEnviaWhatsapp.Create;
    try
      DadosEnviaWhatsapp.fila.id := strFilaEnv;
      LstrJson := DadosEnviaWhatsapp.ToJsonString;
    finally
      FreeAndNil(DadosEnviaWhatsapp);
    end;

     TDllGatime
      .fNew
      .fGravarGatilhoImediato(TRecGatilhoImediato
                                .Create('ENVIO MANUAL',
                                        strMensagem,
                                        recArquivo,
                                        LstrJson,
                                        EmptyStr,
                                        strCelular,
                                        EmptyStr)
                              );
  except
    on E: Exception do
    begin
      Result := False;
      pGravarErro(True, E.Message, E.StackTrace);
    end;
  end;
end;

end.


