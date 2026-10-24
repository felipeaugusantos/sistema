unit untExecutarFatImpressao;

interface

uses
  Classes, SysUtils, WinApi.Windows, Dialogs, Forms, UITypes;

procedure pExecutarImpressao;

implementation

uses
  untFuncoesSimples, untModulo, untModuloReplicacao, untModuloSPR, untFatImpressao;

procedure pConectarModulos;
begin
  pCriarFormularios(TfrmModulo, frmModulo);
  pCriarFormularios(TfrmModuloReplicacao, frmModuloReplicacao);
  pCriarFormularios(TfrmModuloSPR, frmModuloSPR);
end;

procedure pFinalizarModulos;
begin
  pDestroiModulo(frmModuloSPR);
  pDestroiModulo(frmModuloReplicacao);
  pFecharBanco(frmModulo.GetCurrentConnection);
  pDestroiModulo(frmModulo);
end;

procedure pDefinirEmpresa;
begin
  pSetaEmpresaLogada(ParamStr(1));
  If fEmptyStr(VS_strCodEmp) Then
    Raise Exception.Create('Não foi informado o código da empresa');
end;

procedure pDefinirUsuario;
begin
  strLoginUsuarioLogado := ParamStr(2);
  If fEmptyStr(strLoginUsuarioLogado) Then
    Raise Exception.Create('Não foi informado o código da operador');
end;

procedure pTerminate;
begin
  KillProcess(GetCurrentProcessId);
end;

procedure pExecutarImprimeFatImp;
var
  LParams: TImprimeFatImpParams;
  LFile: string;
begin
  LFile := ParamStr(4);

  if LFile.IsEmpty then
    raise Exception.Create('Arquivo de parâmetros não foi informado');

  if not FileExists(LFile) then
    raise Exception.Create('Arquivo de parâmetros não existe: ' + LFile);

  LParams.FromTempFile(LFile);

  pImprimeFatImp(LParams);
end;

procedure pImprimirDocumento;
begin
  if SameText(ParamStr(3), 'pImprimeFatImp') then
  begin
    pExecutarImprimeFatImp;
    Exit;
  end;
  raise Exception.Create('Opção inválida "' + ParamStr(3) + '"');
end;

procedure pExecutarImpressao;
begin
  try
    pDefinirEmpresa;
    pDefinirUsuario;
    pConectarModulos;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      pTerminate;
    end;
  end;

  //Caso libUtil encerre a aplicacao
  if Application.Terminated then
    pTerminate;

  try
    try
      try
        fAjustaDataSistema;
        pCarregarVariaveisUsuarioLogado;
        pAtuVarGlobaisSimples;
        VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));
        pImprimirDocumento;
      except
        on E: Exception do
        begin
          pGravarErro(True, ExtractFileName(ParamStr(0)) + ' (pExecutarImpressao): ' + E.Message, fRetornaStack);
          MessageDlg(E.Message, mtError, [mbOK], 0);
        end;
      end;
    finally
      pFinalizarModulos;
    end;
  finally
    pTerminate;
  end;
end;

end.
