unit iMendes.GerenciaEstado;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  classes, SysUtils, iMendes.Constantes, iMendes.Types, iMendes.Functions;

Type
  TGerenciaEstado = class
  private
    FQryComand: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    FAutIncRegAtual: String;
    FAutIncAgrupador: String;
    FEtadoAtual: TEstadoProcessamento;
  public
    procedure SetaRegistroAtual(AAutIncRegAtual: String);
    procedure SetaRegistroAgrupador(AIncAgrupador: string);
    constructor create;
    destructor Destroy; Override;
    procedure pAtualizaMaquinaEstado(NovoEstado: TEstadoProcessamento);
    procedure pAtualizaMaquinEstadoSemItensParaProcessar;
    procedure pVoltaEstado(NovoEstado: TEstadoProcessamento);
    procedure pAtualizaQtdProcessar(intQtdTot, qtdProcessada: integer);
    function fFinalizadoExterno: Boolean;
    class procedure DeletaPendencia(AIncPendencia: String);
    property EstadoAtual: TEstadoProcessamento Read FEtadoAtual;
    property AutIncRegAtual: String read FAutIncRegAtual;
 End;

implementation

{ TGerenciaEstado }

constructor TGerenciaEstado.create;
begin
{$IFDEF LINUX}
  fQryComand := fCriaQuery;
{$ELSE}
  fQryComand := iMendesCriaQuery(iMendes_Connection);
{$ENDIF}
  FAutIncRegAtual := '';
  FAutIncAgrupador := '';
end;

class procedure TGerenciaEstado.DeletaPendencia(AIncPendencia: String);
var  QryComand: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  {$IFDEF LINUX}
  QryComand := fCriaQuery;
  {$ELSE}
  QryComand := iMendesCriaQuery(iMendes_Connection);
  {$ENDIF}
  Try
    QryComand.SQL.Add('DELETE FROM IMENDES_PARAM WHERE AUTOINCREM = "'+AIncPendencia+'"');
    QryComand.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(QryComand);
    {$ENDIF}
  End;


end;

destructor TGerenciaEstado.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FQryComand);
{$ENDIF}
  inherited;
end;

function TGerenciaEstado.fFinalizadoExterno: Boolean;
begin
  FQryComand.SQL.Text := 'SELECT MAQUINA_ESTADO FROM IMENDES_PARAM  WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
  FQryComand.Open;
  result := IntegerToEstadoProcessamento(FQryComand.FieldByName('MAQUINA_ESTADO').AsInteger)  = epFinalizadoPeloAutcom;
  If result Then
    FEtadoAtual := IntegerToEstadoProcessamento(FQryComand.FieldByName('MAQUINA_ESTADO').AsInteger);
end;

procedure TGerenciaEstado.pAtualizaMaquinaEstado(
  NovoEstado: TEstadoProcessamento);
begin
  If FAutIncRegAtual = '' Then
    Exit;
  Try

    case NovoEstado of
      epIniciaprocesso : Begin
                          FQryComand.SQL.Text := 'UPDATE IMENDES_PARAM SET ACAO_ATUAL = "Carregando Itens", ' +
                            '       MAQUINA_ESTADO_ANT = MAQUINA_ESTADO,' +
                            '       MAQUINA_ESTADO = ' + fEstadoProcessamentoToInteger(epIniciaprocesso).ToString + ',' +
                            '       STATUS = "'+cImendesAndamento+'", ' +
                            '       ID_CONNECTION = CONNECTION_ID() ' +
                            ' WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
                           FQryComand.ExecSQL;
                         End;

      epCriandoEstruturaBanco : begin
                                  FQryComand.SQL.Text := 'DELETE FROM IMENDES_ITENS WHERE IME_SEQCON = "'+FAutIncRegAtual+'"';
                                  FQryComand.ExecSQL;
                                  FQryComand.SQL.Text := 'UPDATE IMENDES_PARAM SET ACAO_ATUAL = "Criando estrutura no banco para processar", ' +
                                    '       MAQUINA_ESTADO_ANT = MAQUINA_ESTADO,' +
                                    '       MAQUINA_ESTADO = ' + fEstadoProcessamentoToInteger(epCriandoEstruturaBanco).ToString  +
                                    ' WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
                                   FQryComand.ExecSQL;
                                End;
      epProcessando: Begin
                       FQryComand.SQL.Text := 'UPDATE IMENDES_PARAM SET ACAO_ATUAL = "Processando Itens...", ' +
                                              '       MAQUINA_ESTADO_ANT = MAQUINA_ESTADO,' +
                                              '      MAQUINA_ESTADO = ' + fEstadoProcessamentoToInteger(epProcessando).ToString  +
                                              ' WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
                       FQryComand.ExecSQL;
                     End;


      epFinalizadoOk,
      epFinalizadoSemItem,
      epFinalizadoComErro,
      epFinalizadoPeloAutcom,
      epFinalizadoItemNaoEncontradoNaImendes,
      epFalhaAutenticacao    : Begin
                                  FQryComand.SQL.Clear;

                                  FQryComand.SQL.Add('UPDATE IMENDES_PARAM SET');
                                  case NovoEstado of
                                    epFinalizadoOk         : FQryComand.SQL.Add('ACAO_ATUAL = "Concluido com sucesso!"');
                                    epFinalizadoSemItem    : FQryComand.SQL.Add('ACAO_ATUAL = "Sem itens para processar!"');
                                    epFinalizadoComErro    : FQryComand.SQL.Add('ACAO_ATUAL = "Finalizado com erro!"');
                                    epFinalizadoPeloAutcom : FQryComand.SQL.Add('ACAO_ATUAL = "Finalizado pelo Autcom!"');
                                    epFalhaAutenticacao    : FQryComand.SQL.Add('ACAO_ATUAL = "Falha ao autenticar usuario!"');
                                    epFinalizadoItemNaoEncontradoNaImendes : FQryComand.SQL.Add('ACAO_ATUAL = "Item não encontrado na IMendes!"');
                                  End;
                                  If NovoEstado <> epFalhaAutenticacao Then
                                  Begin
                                    FQryComand.SQL.Add('      ,MAQUINA_ESTADO_ANT = MAQUINA_ESTADO,');
                                    FQryComand.SQL.Add('      MAQUINA_ESTADO = ' + fEstadoProcessamentoToInteger(NovoEstado).ToString  + ',');
                                    FQryComand.SQL.Add('      STATUS = "'+cImendesConcluido+'"  ');
                                  End;
                                  FQryComand.SQL.Add(' WHERE AUTOINCREM = "'+FAutIncRegAtual+'"');
                                  If FAutIncAgrupador <> '' Then
                                    FQryComand.SQL.Add(' OR IME_AGRUPADOR = "'+FAutIncAgrupador+'"');

                                 FQryComand.ExecSQL;
                                End;
    End;

    FEtadoAtual := NovoEstado;

  Except
    on e: Exception do
      Raise Exception.Create('Falha Local: TGerenciaEstado.pAtualizaMaquinaEstado(Novo Estado = ' +fRetDescricaoEstadoMaquina(NovoEstado)+ ')' + e.Message);
  End


end;

procedure TGerenciaEstado.pAtualizaMaquinEstadoSemItensParaProcessar;
begin
  pAtualizaMaquinaEstado(epFinalizadoSemItem)
end;

procedure TGerenciaEstado.pAtualizaQtdProcessar(intQtdTot, qtdProcessada:  integer);
begin
  FQryComand.SQL.Text := ' UPDATE IMENDES_PARAM SET TOTAL_PARA_PROCESSAR = ' +intQtdTot.ToString+',' +
                         '        PROCESSADOS = ' + qtdProcessada.ToString +
                         ' WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
  FQryComand.ExecSQL;
end;

procedure TGerenciaEstado.pVoltaEstado(NovoEstado: TEstadoProcessamento);
var intEstadoAtual: integer;
    intEstadoNovo : integer;
begin
  intEstadoAtual := fEstadoProcessamentoToInteger(FEtadoAtual);
  intEstadoNovo  := fEstadoProcessamentoToInteger(NovoEstado);
  while (intEstadoAtual >  intEstadoNovo) do
  Begin
    intEstadoAtual := intEstadoAtual -1;
    pAtualizaMaquinaEstado(IntegerToEstadoProcessamento(intEstadoAtual));
  End;
end;

procedure TGerenciaEstado.SetaRegistroAgrupador(AIncAgrupador: string);
begin
  FAutIncAgrupador := AIncAgrupador;

end;

procedure TGerenciaEstado.SetaRegistroAtual(AAutIncRegAtual: String);
begin
  FAutIncRegAtual := AAutIncRegAtual;
  If FAutIncRegAtual = '' then
    Exit;

  FQryComand.SQL.Text := 'SELECT MAQUINA_ESTADO FROM IMENDES_PARAM WHERE AUTOINCREM = "'+FAutIncRegAtual+'"';
  FQryComand.Open;

  FEtadoAtual :=  IntegerToEstadoProcessamento(FQryComand.FieldByName('MAQUINA_ESTADO').AsInteger);

end;

end.
