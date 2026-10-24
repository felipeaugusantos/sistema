unit untAuttinWrapper;

interface

uses
  untIAuttinWrapper, untIGravandoExecucaoNome, untGravandoFactory,
  Forms, untGenericGravando, untGravandoExecucaoWrapper,
  SysUtils, untFuncTinta, untIConfiguradorTinta, untICadLibTintas,
  untCadLibTintas, untFuncoesSimples;

type
  TAuttinWrapper = class(TInterfacedObject, IAuttinWrapper)
  public
    procedure ProcessarArquivos(const strNomeTinta: string; const arrProcessadores: array of IGravandoExecucaoNome);
    procedure Configurar(const configuradorTinta: IConfiguradorTinta);
    procedure Cadastrar(const cadLibTintas: ICadLibTintas);
  end;

  function fConfirmaGeracao(blnNovasFormulas: Boolean): Boolean;

implementation

uses
  untCfgTin;

{ TAuttinWrapper }

procedure TAuttinWrapper.Cadastrar(const cadLibTintas: ICadLibTintas);
var
  frmCad: TfrmCadLibTintas;
begin
  frmCad := nil;
  Try
    Try
      frmCad := TfrmCadLibTintas.Create(Screen.ActiveForm, cadLibTintas);
      frmCad.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmCad) then FreeAndNil(frmCad);
  End;                              
end;

procedure TAuttinWrapper.Configurar(const configuradorTinta: IConfiguradorTinta);
var
  frmCfg: TfrmCfgTin;
begin
  frmCfg := nil;
  Try
    Try
      frmCfg := TfrmCfgTin.Create(Screen.ActiveForm, configuradorTinta);
      frmCfg.Caption := Format('Configurações %s', [fRetornaNomeTinta(configuradorTinta.IdePro)]);
      frmCfg.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmCfg) then FreeAndNil(frmCfg);
  End;
end;

procedure TAuttinWrapper.ProcessarArquivos(const strNomeTinta: string;
  const arrProcessadores: array of IGravandoExecucaoNome);
var
  intCont: Integer;
  arrGravandoExecucao: TArrayGravandoExecucao;
  blnNovasFormulas: Boolean;
begin
  blnNovasFormulas := False;

  SetLength(arrGravandoExecucao, Length(arrProcessadores));

  for intCont := Low(arrProcessadores) to High(arrProcessadores) do
  begin
    arrGravandoExecucao[intCont] := TGravandoExecucaoWrapper.Create(arrProcessadores[intCont]);
    if (arrGravandoExecucao[intCont].fGetNomeGravacao = 'Cadastro de Novas Fórmulas') then
      blnNovasFormulas := True;
  end;

  If fConfirmaGeracao(blnNovasFormulas) Then
    TGravandoFactory.Gravar(Screen.ActiveForm, strNomeTinta, arrGravandoExecucao);
end;

function fConfirmaGeracao(blnNovasFormulas: Boolean): Boolean;
begin
  if blnNovasFormulas then
    Result := fMensagem('ATENÇÃO','Este procedimento irá gerar as novas fórmulas no cadastro de formulação.' + #13#10 +
                                  'Confirma o procedimento ? ', ['&Não','&Sim']) = 2
  Else
    Result := fMensagem('ATENÇÃO','Este procedimento irá apagar e gerar novamente todas as cores,' + #13#10 +
                                  'deste fabricante tintométrico. Não faça sem orientação da CITEL,' + #13#10 +
                                  'para não comprometer todos os vínculos com os produtos envolvidos' + #13#10 +
                                  'na composição do tintométrico. Confirma o procedimento ? ', ['&Não','&Sim']) = 2;
end;

end.
