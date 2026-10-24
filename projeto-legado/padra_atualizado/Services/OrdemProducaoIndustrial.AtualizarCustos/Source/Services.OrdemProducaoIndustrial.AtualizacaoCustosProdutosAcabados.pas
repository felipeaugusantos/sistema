unit Services.OrdemProducaoIndustrial.AtualizacaoCustosProdutosAcabados;

interface

uses
  System.DateUtils, System.Classes, System.SysUtils, System.UITypes,
  OrdemProducaoIndustrial.TAtualizacaoCustosProdutosAcabadosGeral,
  {$I '..\..\..\core\services.core.uses.inc'};

type
  TAtualizacaoCustosProdutosAcabados = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
    FUltimaExecucao: TDateTime;
    function ValidarHorarioParaExecutar: Boolean;
  public
    procedure pExecute;
    procedure pExecuteAll;
  end;

function AtualizacaoCustosProdutosAcabados(): Boolean;

implementation

const
  NO_TIME_LIMIT = 0;

function AtualizacaoCustosProdutosAcabados(): Boolean;
Var
  LTask: TTaskMonitor;
begin
  Result := False;
  pIniciarConexao;
  Try
    Try
      pDefinirEmpresa;
      pDefinirUsuario;
      pIniciarVariaveis;
    Except
      On E: Exception Do
      Begin
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
        Exit;
      End;
    End;

    Try
      If Not fCfgSis('UTIIND', varBoolean) Then
      Begin
        Writeln(DateTimeToStr(fNow) +
          ' - Empresa configurada para nao utilizar Modulo Industrial (' +
          VS_strCodEmp + ')');
        Exit;
      End;

      If HasParam('-f') Then
        TTaskLock.pDestravaLockForcado(Format(spIdLockProdAcabadosIndustrial,
          [VS_strCodEmp]), 0);

      If TUtilTaskMonitor.fLockTaskMonitor(spIdLockProdAcabadosIndustrial,
        VS_strLockProdutosAcabadosIndustrial) Then
      Begin
        Try
          LTask := TTaskMonitor.Create(spIdLockProdAcabadosIndustrial,
            NO_TIME_LIMIT, VS_strLockProdutosAcabadosIndustrial,
            TAtualizacaoCustosProdutosAcabados.Create());
          Try
            LTask.Start;
            While Not LTask.Finished Do
              Sleep(2000);
            Result := True;
          Finally
            FreeAndNil(LTask);
          End;
        Except
          On E: Exception Do
          Begin
            Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
            Exit;
          End;
        End;
      End
      Else
        Writeln(DateTimeToStr(fNow) + ' - ' +
          'O servico ja esta sendo executado ... ');

    Finally
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Encerrando servico ...');
      TUtilTaskMonitor.fRemoveLockTaskMonitor(spIdLockProdAcabadosIndustrial);
    End;
  Finally
    objConnectionsManager.EndConnection;
  End;
end;

{ TAtualizacaoCustosProdutosAcabados }

procedure TAtualizacaoCustosProdutosAcabados.pExecute;
begin
  Raise Exception.Create('Utilize somente o método pExecuteAll');
end;

procedure TAtualizacaoCustosProdutosAcabados.pExecuteAll;
Var
  objAtualizacao: TAtualizacaoCustosProdutosAcabadosGeral;
Begin
  Try
    if Not ValidarHorarioParaExecutar then
      Exit;

    Writeln(DateTimeToStr(fNow) +
      ' - Executando Atualizacao Custos Produtos Acabados...');

    objAtualizacao := TAtualizacaoCustosProdutosAcabadosGeral.Create;
    try
      objAtualizacao.objFiltroProdutoGranel.strCodigo := EmptyStr;
      objAtualizacao.objFiltroProdutoGranel.strLinhaGrupo := EmptyStr;
      objAtualizacao.objFiltroProdutoGranel.strCodigoDepartamento := EmptyStr;
      objAtualizacao.objFiltroProdutoGranel.strReferencia := EmptyStr;

      objAtualizacao.objFiltroProdutoAcabado.strCodigo := EmptyStr;
      objAtualizacao.objFiltroProdutoAcabado.strLinhaGrupo := EmptyStr;
      objAtualizacao.objFiltroProdutoAcabado.strCodigoDepartamento := EmptyStr;
      objAtualizacao.objFiltroProdutoAcabado.strReferencia := EmptyStr;

      objAtualizacao.blnMargem := False;

      objAtualizacao.fAtualizaCustos;

      FUltimaExecucao := fNow;

      Writeln(DateTimeToStr(fNow) + ' - Rotina concluida com sucesso.');
    finally
      FreeAndNil(objAtualizacao);
    end;
  Finally
    Sleep(60000);
  End;
end;

function TAtualizacaoCustosProdutosAcabados.ValidarHorarioParaExecutar: Boolean;
Var
  LHora: String;
  LHorarios: IStrings;
  LExecutar: Boolean;
begin
  If HasParam('-h') Then
  Begin
    LExecutar := False;
    LHorarios := SplitEx(GetParamValue('-h'), '-');

    For LHora In LHorarios.Obj Do
      If (StrToTimeDef(LHora, 0) > 0) Then
        If MinutesBetween(Time, StrToTime(LHora)) <= 30 Then
          LExecutar := True;

    If Not LExecutar Then
      Exit(False);
  End;

  If MinutesBetween(fNow, FUltimaExecucao) <= 30 Then
    Exit(False);

  Result := True;
end;

end.
