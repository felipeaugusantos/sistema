unit untGerarTesteUnitario;

interface

Uses
  System.Classes, System.StrUtils, untConsulta,
  untClasseCfop, {untClasseDifal,}Vcl.Dialogs,
  untFuncoes, untClasseIcmsSt, untClasseFCP,
  untClasseIcmsOrgaoPublico, untClasseSTCustoAquisicao,
  untClasseIcmsEfetivo ,untClasseIpi, untModulo,
  untClassePrecoCusto, untClasseMargemVenda;


Type
  TGerarTesteUnitario = Class(TObject)
  private
    procedure SetarDadosProcessamentoAtual(
      const AIndexOpcaoSelecionada: integer);

    procedure ExibirMensagemConcluido;

  Public
    procedure pExecutarTesteUnitario(AOpcao: TStringList; ADataInicial, ADataFinal : TDate);
  End;

implementation



{ TExecutarConsulta }

procedure TGerarTesteUnitario.SetarDadosProcessamentoAtual(const AIndexOpcaoSelecionada: integer);
begin
  Case AIndexOpcaoSelecionada of
    0: frmModulo.ProcessamentoAtual('IPI');
    1: frmModulo.ProcessamentoAtual('ICMS\ST');
    2: frmModulo.ProcessamentoAtual('ICMS Efetivo');
    3: frmModulo.ProcessamentoAtual('Difal\FCP');
    4: frmModulo.ProcessamentoAtual('CFOP');
    5: frmModulo.ProcessamentoAtual('PREÇO CUSTO');
    6: frmModulo.ProcessamentoAtual('MARGEM VENDA');
  end;
end;


procedure TGerarTesteUnitario.ExibirMensagemConcluido;
begin
  if (frmModulo.ExecutandoPeloJenkins) then
    Exit;

  ShowMessage('Processo concluído com sucesso!');
end;

procedure TGerarTesteUnitario.pExecutarTesteUnitario(AOpcao: TStringList; ADataInicial, ADataFinal : TDate);
Var
  LIntCont : Integer;
  LIndexOpcaoSelecionada: integer;
begin

  Try
    For LIntCont := 0 To AOpcao.Count -1 Do
    begin
      LIndexOpcaoSelecionada := RetonarIndexOpcoesSelecionadas(AOpcao[LIntCont]);
      SetarDadosProcessamentoAtual(LIndexOpcaoSelecionada);

      Case LIndexOpcaoSelecionada of
        0: TGerarTesteIpi.New.fGerarTesteIpi(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
        1: TGerarTesteIcms.New.fGerarTesteIcmsSt(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados,AOpcao[LIntCont]);
        2: TGerarTesteIcmsEfetivo.New.fGerarTesteIcmsEfetivo(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
        3: TGerarTesteFcp.New.fGerarTesteFcp(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
        4: TGerarTesteCfop.New.fGerarTesteCfop(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
        5: TGerarTestePrecoCusto.New.fGerarTestePrecoCusto(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
        6: TGerarTesteMargemVenda.New.fGerarTesteMargemVenda(TConsulta.Create(AOpcao[LIntCont],ADataInicial,ADataFinal).fRetornarDados);
      end;

      ExitCode := ExitCode + frmModulo.RegistrosProcessadosErro;

      if (ValidarPararProcessamento) then
        Break;
    end;
  Finally
    ExibirMensagemConcluido;
  End;

end;

end.
