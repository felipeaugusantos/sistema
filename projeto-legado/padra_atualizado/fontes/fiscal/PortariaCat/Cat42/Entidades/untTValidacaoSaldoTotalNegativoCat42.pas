unit untTValidacaoSaldoTotalNegativoCat42;

interface

uses untTValidacaoSaldoTotalCat42,
     untTEstoqueCat42,
     untTRegistroCat,
     SysUtils,
     Classes,
     Forms;

type
  TValidacaoSaldoTotalNegativoCat42 = class(TValidacaoSaldoTotalCat42)
  private
    procedure pValidarSaldoTotalV1;
    procedure pValidarSaldoTotalV2;
  public
    procedure pValidarSaldoTotal; override;
  end;

implementation

uses untFuncoes,
     untTipo;

{ TValidacaoSaldoTotalNegativoCat42 }

procedure TValidacaoSaldoTotalNegativoCat42.pValidarSaldoTotal;
begin
  inherited;

  if abertura.strVersaoExecutada = 'v1' then
    pValidarSaldoTotalV1
  else
    pValidarSaldoTotalV2;

end;

procedure TValidacaoSaldoTotalNegativoCat42.pValidarSaldoTotalV1;
  var
    registroCat: TRegistroCat;
    blnMovimentacao: boolean;
    estoque: TEstoqueCat42;
begin

  abertura.lblOperacao.Caption := 'Validando estoque...';
  abertura.lblOperacao.Visible := True;

  abertura.progressoTela.Max := listaSaldoEstoque.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for estoque in listaSaldoEstoque do
  begin
    blnMovimentacao := False;

    if Assigned(estoque.listaRegistroCat) then
    begin
      //inicializa
      fltSaldoFinal := 0;
      fltQtdFinal := 0;
      fltCampo23 := 0;

      //Inicia
      fltSaldoFinal := estoque.fltSaldoFinal;
      fltQtdFinal := estoque.fltQtdFinal;

      //ordena a lista por cfop e data, para aparecer primeiro as compras, depois as devoluções e por ultimo as vendas.
      estoque.listaRegistroCat.Sort(estoque.fOrdenaListaDataCfop);

      for registroCat in estoque.listaRegistroCat do
      begin
        blnMovimentacao := True;

        if Pos(registroCat.itemNota.strCfop, VS_strClaDev) > 0 then
        begin
          if StrToInt(registroCat.itemNota.strCfop) > 5000 then
            pCalculaSaldoDevolucaoEntrada(estoque, registroCat)
          else
            pCalculaSaldoDevolucaoSaida(estoque, registroCat)
        end
        else if StrToInt(registroCat.itemNota.strCfop) > 5000 then
          pCalculaSaldoSaidas(estoque, registroCat)
        else
          pCalculaSaldoEntradas(estoque, registroCat);
      end;

      if abertura.blnEnviaNfCredSemSubsti then
      begin
        if (fltQtdFinal > 0) and (estoque.fltQtdInicial > 0) or
          ((estoque.fltQtdInicial = 0) and (fltQtdFinal > 0)) or
          ((estoque.fltQtdInicial > 0) and (fltQtdFinal = 0)) or
          ((estoque.fltQtdInicial = 0) and (fltQtdFinal = 0) and (blnMovimentacao))then
          if estoque.fltVlrIcmsSubst <= 0 then
          begin
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True
          end else
            estoque.blnEnviaMovimentacao := False;
      end
      else
      begin
        if ((fltQtdFinal >= 0) and (estoque.fltQtdInicial >= 0)) or
           ((estoque.fltQtdInicial = 0) and (fltQtdFinal >= 0)) then
          if estoque.fltVlrIcmsSubst <= 0 then
          begin
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True
          end else
            estoque.blnEnviaMovimentacao := False;
      end;
    end
    else if abertura.blnEnviaNfCredSemSubsti then
    begin
      if estoque.fltQtdFinal > 0 then
        if estoque.fltVlrIcmsSubst <= 0 then
        begin
          if (estoque.blnMovimentacaoSaldoNegativo) then
            estoque.blnEnviaMovimentacao := True
        end else
          estoque.blnEnviaMovimentacao := False;
    end
    else
      if estoque.fltQtdFinal >= 0 then
        if estoque.fltVlrIcmsSubst <= 0 then
        begin
          if (estoque.blnMovimentacaoSaldoNegativo) then
            estoque.blnEnviaMovimentacao := True
        end else
          estoque.blnEnviaMovimentacao := False;

    abertura.progressoTela.StepBy(1);
    Application.ProcessMessages;
  end;

end;

procedure TValidacaoSaldoTotalNegativoCat42.pValidarSaldoTotalV2;
  var
    blnMovimentacaoDevoluc: Boolean;
    blnMovimentacaoEntrada, blnCongelado: boolean;
    registroCat: TRegistroCat;
    estoque: TEstoqueCat42;

    {** Vl. Retido Não Creditado Congelado!}
    fltVlRtdNCrdC: Double;
begin

  abertura.lblOperacao.Caption := 'Validando estoque...';
  abertura.lblOperacao.Visible := True;

  abertura.progressoTela.Max := listaSaldoEstoque.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for estoque in listaSaldoEstoque do
  begin

    if Assigned(estoque.listaRegistroCat) then
    begin
      //inicializa
      fltVlRtdNCrdC := -1;
      fltSaldoFinal := 0;
      fltQtdFinal := 0;
      fltCampo23 := 0;

      //Inicia
      fltSaldoFinal := estoque.fltSaldoFinal;
      fltQtdFinal := estoque.fltQtdFinal;

      //ordena a lista por cfop e data, para aparecer primeiro as compras, depois as devoluções e por ultimo as vendas.
      estoque.listaRegistroCat.Sort(estoque.fOrdenaListaDataCfop);

      blnCongelado:= True;
      blnMovimentacaoEntrada:= False;
      blnMovimentacaoDevoluc:= False;
      for registroCat in estoque.listaRegistroCat do
      begin

        if blnCongelado then
        begin
          fltVlRtdNCrdC:= registroCat.itemNota.fltValorRetidoNaoCreditado;
          blnCongelado:= False;
        end;

        if Pos(registroCat.itemNota.strCfop, VS_strClaDev) > 0 then
        begin
          if StrToInt(registroCat.itemNota.strCfop) > 5000 then
          begin
            {blnMovimentacaoEntrada:= True;}
            blnMovimentacaoDevoluc:= True;
            pCalculaSaldoDevolucaoEntrada(estoque, registroCat)
          end
          else
            pCalculaSaldoDevolucaoSaida(estoque, registroCat)
        end
        else
          if StrToInt(registroCat.itemNota.strCfop) > 5000 then
            pCalculaSaldoSaidas(estoque, registroCat)
          else
          begin
            blnMovimentacaoEntrada:= True;
            pCalculaSaldoEntradas(estoque, registroCat);
          end;
      end;

      if abertura.tipoConferencia = tccConf then
      begin

        {INVENTÁRIO COM SALDO, SEM SUBST. TRIBUTÁRIA E COM MOVIMENTO MÊS}
        if (estoque.fltQtdInicial > 0) and (estoque.fltVlrIcmsSubst = 0) then
          if (abertura.blnInvComSaldoSemSubstTributComMovtoMes) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {'SALDO FINAL' (QUANTIDADE FINAL NEGATIVA, QUANTIDADE DA VENDA MAIOR QUE A COMPRA)}
        if (fltQtdFinal < 0) and (estoque.fltQtdInicial >= 0) then
          if (abertura.blnSldFinalQtFinalNegQtVendaMaiorCompra) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {'NOTAS DE ENTRADA SEM SUBS. TRIBUTÁRIA'}
        if (estoque.fltVlrIcmsSubst = 0) and (fltVlRtdNCrdC = 0) then
        begin
          if blnMovimentacaoEntrada then
            if (abertura.blnNotasEntradaSemSubstituicaTributaria) then
              if (not(abertura.blnCalculaST)) then
                if (estoque.blnMovimentacaoSaldoNegativo) then
                  estoque.blnEnviaMovimentacao := True;
        end
        else
        begin
          if fltVlRtdNCrdC = 0 then
          begin
            if blnMovimentacaoEntrada then
              if (abertura.blnNotasEntradaSemSubstituicaTributaria) then
                if (not(abertura.blnCalculaST)) then
                  if (estoque.blnMovimentacaoSaldoNegativo) then
                    estoque.blnEnviaMovimentacao := True;

            {'NOTAS DE DEVOLUÇÃO COM E/OU SEM REFERENCIA'}
            if not blnMovimentacaoEntrada then
              if blnMovimentacaoDevoluc then
                if (abertura.blnSldFinalQtFinalNegQtVendaMaiorCompra) then
                  if (not(abertura.blnCalculaST)) then
                    if fltSaldoFinal <= 0 then
                      if (estoque.blnMovimentacaoSaldoNegativo) then
                        estoque.blnEnviaMovimentacao := True;
          end;
        end;

        {'SALDO INICIAL' (QUANTIDADE INICIAL NEGATIVA)}
        if (estoque.fltQtdInicial < 0) and (fltQtdFinal >= 0) then
          if (abertura.blnSaldoInicialQuantidadInicialNegativa) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {'SALDO FINAL' (SALDO FINAL NEGATIVO)}
        if fltSaldoFinal < 0 then
          if (abertura.blnSldFinalQtFinalNegQtVendaMaiorCompra) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

      end;

    end
    else
    begin
      if abertura.tipoConferencia = tccConf then
      begin

        {INVENTÁRIO SEM SALDO, SEM SUBST. TRIBUTÁRIA E SEM MOVIMENTO MÊS}
        if (estoque.fltQtdInicial = 0) and (estoque.fltVlrIcmsSubst = 0) then
          if (abertura.blnInvSemSaldoSemSubstTributSemMovtoMes) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {INVENTÁRIO SEM SALDO, COM SUBST. TRIBUTÁRIA E SEM MOVIMENTO MÊS}
        if (estoque.fltQtdInicial = 0) and (estoque.fltVlrIcmsSubst > 0) then
          if (abertura.blnInvSemSaldoComSubstTributSemMovtoMes) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {INVENTÁRIO COM SALDO, SEM SUBST. TRIBUTÁRIA E SEM MOVIMENTO MÊS}
        if (estoque.fltQtdInicial > 0) and (estoque.fltVlrIcmsSubst = 0) then
          if (abertura.blnInvComSaldoSemSubstTributSemMovtoMes) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {'SALDO INICIAL' (QUANTIDADE INICIAL NEGATIVA)}
        if (estoque.fltQtdInicial < 0) and (fltQtdFinal >= 0) then
          if (abertura.blnSaldoInicialQuantidadInicialNegativa) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

        {'SALDO FINAL' (SALDO FINAL NEGATIVO)}
        if fltSaldoFinal < 0 then
          if (abertura.blnSldFinalQtFinalNegQtVendaMaiorCompra) then
            if (estoque.blnMovimentacaoSaldoNegativo) then
              estoque.blnEnviaMovimentacao := True;

      end;
    end;

    abertura.progressoTela.StepBy(1);
    Application.ProcessMessages;
  end;

end;

end.
