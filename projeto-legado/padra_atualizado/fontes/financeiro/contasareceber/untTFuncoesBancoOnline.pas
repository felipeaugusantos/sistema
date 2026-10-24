unit untTFuncoesBancoOnline;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
     untfuncoesSimples,untAlteraBoletoApi,untTBancoDoBrasilAPI,
     untTBancoSantanderAPI, untTBancoItauAPI, untTBancoSicoobApi,
     untTBancoSicrediAPI, untFuncoes, untTBancoBradescoAPI;

function CancelaBoletoRegistradoBancoDoBrasil(ACarteira,ADuplicatas:String):Boolean;
function fCancelarBoletosRegistradosSantanderAPI(ACarteiraBoleto, ADuplicatas : String) : Boolean;
function fCancelarBoletosRegistradosItauAPI(ACarteiraBoleto, ADuplicatas : String) : Boolean;
function fCancelarBoletosRegistradosSicoobAPI(ACarteiraBoleto, ADuplicatas : String) : Boolean;
function fCancelarBoletosRegistradosSicredAPI(ACarteiraBoleto, ADuplicatas : String) : Boolean;
function CancelarBoletosRegistradosBradescoAPI(ACarteiraBoleto, ADuplicatas: String): Boolean;

function fValidaArquivosNecessariosPelaAPI: Boolean;

implementation

function CancelaBoletoRegistradoBancoDoBrasil(ACarteira,
  ADuplicatas: String): Boolean;
Var
  LCancelaBoletoApi: TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco do Brasil [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarBancoDoBrasilApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 001 - Banco do Brasil > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '001 - Banco do Brasil [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteira,14,1),0);
    LCancelaBoletoApi.Configuracao     := 'CONFIG001API-';
    LCancelaBoletoApi.CodigoDoBanco    := '001';
    LCancelaBoletoApi.CarteiraCompleta := ACarteira;
    LCancelaBoletoApi.ObjetoBanco      := TBancoDoBrasilAPI.Create(ACarteira);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 001 - Banco do Brasil [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

function CancelarBoletosRegistradosBradescoAPI(ACarteiraBoleto, ADuplicatas: String): Boolean;
  Var
  LCancelaBoletoApi: TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Bradesco [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarBradescoApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 237 - Banco Bradesco > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '237 - Banco Bradesco [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteiraBoleto,14,1),0);
    LCancelaBoletoApi.Configuracao     := 'CONFIG237API-';
    LCancelaBoletoApi.CodigoDoBanco    := '237';
    LCancelaBoletoApi.CarteiraCompleta := ACarteiraBoleto;
    LCancelaBoletoApi.ObjetoBanco      := TBancoBradescoAPI.Create(ACarteiraBoleto);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 237 - Banco Bradesco [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
End;

function fCancelarBoletosRegistradosSantanderAPI(ACarteiraBoleto,
  ADuplicatas : String) : Boolean;
var
   LCancelaBoletoApi: TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Santander [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarSantanderApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 033 - Santander > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '033 - Banco Santander [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteiraBoleto,14,1),0);
    LCancelaBoletoApi.CarteiraCompleta := ACarteiraBoleto;
    LCancelaBoletoApi.Configuracao     := 'CONFIG033API-';
    LCancelaBoletoApi.CodigoDoBanco    := '033';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSantanderAPI.Create(ACarteiraBoleto);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 033 - Banco Santander [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

function fCancelarBoletosRegistradosItauAPI(ACarteiraBoleto,
  ADuplicatas : String) : Boolean;
var
   LCancelaBoletoApi: TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Itaú [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarItauApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 341 - Itaú > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '341 - Banco Itaú [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteiraBoleto,14,1),0);
    LCancelaBoletoApi.CarteiraCompleta := ACarteiraBoleto;
    LCancelaBoletoApi.Configuracao     := 'CONFIG341API-';
    LCancelaBoletoApi.CodigoDoBanco    := '341';
    LCancelaBoletoApi.ObjetoBanco      := TBancoItauAPI.Create(ACarteiraBoleto);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 341 - Banco Itaú [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;

end;

function fCancelarBoletosRegistradosSicoobAPI(ACarteiraBoleto,
  ADuplicatas : String) : Boolean;
var
  LCancelaBoletoApi : TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Sicoob [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarSicoobApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 756 - Sicoob > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '756 - Banco Sicoob [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteiraBoleto,14,1),0);
    LCancelaBoletoApi.CarteiraCompleta := ACarteiraBoleto;
    LCancelaBoletoApi.Configuracao     := 'CONFIG756API-';
    LCancelaBoletoApi.CodigoDoBanco    := '756';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSicoobAPI.Create(ACarteiraBoleto);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 756 - Banco Sicoob [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

function fCancelarBoletosRegistradosSicredAPI(ACarteiraBoleto,
  ADuplicatas: String): Boolean;
var
  LCancelaBoletoApi : TfrmAlteraBoletoApi;
begin
  Result := False;
  If Not fValidaArquivosNecessariosPelaAPI Then
  begin
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Sicredi [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
    Exit;
  end;

  if not fVerificaDireitoAutBan('frmCancelarBancoSicrediApi') Then
  begin
    fMensagem('ATENÇÃO', 'Operador não possui permissão de acesso para a rotina de: ' + #13 +
              'Principal > Controle Financeiro > Geração de Layout Bancário > Contas a Receber > Bancos - Online > 748 - Sicredi > B - Cancelar Boletos"', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
  Try
    LCancelaBoletoApi.NomeDoBanco      := '748 - Banco Sicredi [Online]';
    LCancelaBoletoApi.Carteira         := StrToIntDef(Copy(ACarteiraBoleto,14,1),0);
    LCancelaBoletoApi.CarteiraCompleta := ACarteiraBoleto;
    LCancelaBoletoApi.Configuracao     := 'CONFIG748API-';
    LCancelaBoletoApi.CodigoDoBanco    := '748';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSicrediAPI.Create(ACarteiraBoleto);
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 748 - Banco Sicredi [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.Duplicatas       := ADuplicatas;
    LCancelaBoletoApi.ShowModal;

    Result := LCancelaBoletoApi.CancelouTodos;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

function fValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');
end;

end.
