unit untTValidacaoSaldoTotalPositivoCat42;

interface

uses untTValidacaoSaldoTotalCat42,
     untTEstoqueCat42,
     untTRegistroCat,
     SysUtils,
     Classes,
     Forms;

type
  TValidacaoSaldoTotalPositivoCat42 = class(TValidacaoSaldoTotalCat42)
  public
    procedure pValidarSaldoTotal; override;
  end;

implementation

uses untFuncoes,
     untTipo;

{ TValidacaoSaldoTotalPositivoCat42 }

procedure TValidacaoSaldoTotalPositivoCat42.pValidarSaldoTotal;
  var
    blnMovimentacaoDevoluc: boolean;
    blnMovimentacaoEntrada, blnMovimentacao, blnCongelado: boolean;
    registroCat: TRegistroCat;
    estoque: TEstoqueCat42;

    {** Vl. Retido Não Creditado Congelado!}
    fltValorRetidoNaoCreditado: Double;
    intCFOP1409_2409: Integer;
begin
  inherited;

  abertura.lblOperacao.Caption := 'Validando estoque...';
  abertura.lblOperacao.Visible := True;

  abertura.progressoTela.Max := listaSaldoEstoque.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for estoque in listaSaldoEstoque do
  begin
    blnMovimentacao := false;

    //inicializa
    intCFOP1409_2409 := 0;
    fltValorRetidoNaoCreditado := -1;
    fltSaldoFinal := 0;
    fltQtdFinal := 0;
    fltCampo23 := 0;

    //Inicia
    fltSaldoFinal := estoque.fltSaldoFinal;
    fltQtdFinal := estoque.fltQtdFinal;

    blnCongelado:= True;
    blnMovimentacaoEntrada:= False;
    blnMovimentacaoDevoluc:= False;
    if Assigned(estoque.listaRegistroCat) then
    begin
      //ordena a lista por cfop e data, para aparecer primeiro as compras, depois as devoluções e por ultimo as vendas.
      estoque.listaRegistroCat.Sort(estoque.fOrdenaListaDataCfop);

      for registroCat in estoque.listaRegistroCat do
      begin
        blnMovimentacao := True;

        if blnCongelado then
        begin
          fltValorRetidoNaoCreditado:= registroCat.itemNota.fltValorRetidoNaoCreditado;
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
            pCalculaSaldoDevolucaoSaida(estoque, registroCat);
        end
        else
          if StrToInt(registroCat.itemNota.strCfop) > 5000 then
            pCalculaSaldoSaidas(estoque, registroCat)
          else
          begin

            if Pos(registroCat.itemNota.strCfop, '1409_2409_') > 0 then
              intCFOP1409_2409:= intCFOP1409_2409 + 1;

            blnMovimentacaoEntrada:= True;
            pCalculaSaldoEntradas(estoque, registroCat);
          end;
      end;

    end;

    if abertura.strVersaoExecutada = 'v1' then
    begin
      if (fltQtdFinal < 0) or (estoque.fltQtdInicial < 0) or
         ((estoque.fltQtdInicial = 0) and (fltQtdFinal = 0) and (not blnMovimentacao)) then
        estoque.blnEnviaMovimentacao := False
    end
    else
    begin
      {'NOTAS DE ENTRADA SEM SUBS. TRIBUTÁRIA'}
      if (fltQtdFinal < 0) or (estoque.fltQtdInicial < 0) or
        ((estoque.fltQtdInicial = 0) and (fltQtdFinal = 0) and (not blnMovimentacao)) then
        estoque.blnEnviaMovimentacao := False
      else
      begin
        if (estoque.fltVlrIcmsSubst = 0) and (fltValorRetidoNaoCreditado = 0) then
        begin
          if (abertura.blnConsiderarInconsistenciaQuatro) or
            (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) or
            (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
          begin
            estoque.blnEnviaMovimentacao := False;

            if (abertura.blnConsiderarInconsistenciaQuatro) then
              if (estoque.blnMovimentacaoSaldoNegativo) then
                estoque.blnEnviaMovimentacao := True;

            if intCFOP1409_2409 = 0 then
              if (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) then
                if blnMovimentacaoEntrada then
                  if (estoque.blnMovimentacaoSaldoNegativo) then
                    estoque.blnEnviaMovimentacao := True;

            if intCFOP1409_2409 > 0 then
              if (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
                if blnMovimentacaoEntrada then
                  if (estoque.blnMovimentacaoSaldoNegativo) then
                    estoque.blnEnviaMovimentacao := True;

            {'NOTAS DE DEVOLUÇÃO COM E/OU SEM REFERENCIA'}
            if intCFOP1409_2409 = 0 then
              if (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) or
                (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
                if blnMovimentacaoDevoluc then
                  estoque.blnEnviaMovimentacao := False;

          end
          else
          begin
            if (not(abertura.blnCalculaST)) then
              estoque.blnEnviaMovimentacao := False;
          end;
        end
        else
        begin
          if fltValorRetidoNaoCreditado = 0 then
          begin
            if (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) or
              (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
            begin
              estoque.blnEnviaMovimentacao := False;

              if (estoque.fltVlrIcmsSubst > 0) then
                if (intCFOP1409_2409 = 0) then
                  if (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) then
                    if (estoque.blnMovimentacaoSaldoNegativo) then
                      estoque.blnEnviaMovimentacao := True;

              if intCFOP1409_2409 > 0 then
                if (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
                  if (estoque.blnMovimentacaoSaldoNegativo) then
                    estoque.blnEnviaMovimentacao := True;

              {'NOTAS DE DEVOLUÇÃO COM E/OU SEM REFERENCIA'}
              if (estoque.fltVlrIcmsSubst > 0) then
                if (intCFOP1409_2409 = 0) then
                  if (abertura.blnConsiderarInconsistenciaCincoEntradaSemSt) or
                    (abertura.blnConsiderarInconsistenciaCincoTransfSemSt) then
                    if not blnMovimentacaoEntrada then
                      if blnMovimentacaoDevoluc then
                        if fltSaldoFinal <= 0 then
                           estoque.blnEnviaMovimentacao := False;

            end
            else
            begin
              if blnMovimentacaoEntrada then
                if (not(abertura.blnCalculaST)) then
                  estoque.blnEnviaMovimentacao := False;

              {'NOTAS DE DEVOLUÇÃO COM E/OU SEM REFERENCIA'}
              if not blnMovimentacaoEntrada then
                if (not(abertura.blnCalculaST)) then
                  if blnMovimentacaoDevoluc then
                    if fltSaldoFinal <= 0 then
                      estoque.blnEnviaMovimentacao := False;

              if fltSaldoFinal < 0 then
                if (not(abertura.blnCalculaST)) then
                    estoque.blnEnviaMovimentacao := False

            end;
          end
          else
          begin
            if (estoque.fltVlrIcmsSubst = 0) then
            begin
              estoque.blnEnviaMovimentacao := False;
              if (abertura.blnConsiderarInconsistenciaQuatro) then
              begin
                if fltValorRetidoNaoCreditado > 0 then
                  if (estoque.blnMovimentacaoSaldoNegativo) then
                    estoque.blnEnviaMovimentacao := True
              end
              else
              begin
                if blnMovimentacaoEntrada then
                  if (abertura.blnCalculaST) then
                    if (estoque.blnMovimentacaoSaldoNegativo) then
                      estoque.blnEnviaMovimentacao := True;
              end;
            end;
          end;

          {'SALDO FINAL' (SALDO FINAL NEGATIVO)}
          if fltSaldoFinal < 0 then
            estoque.blnEnviaMovimentacao := False;

        end;
      end;
    end;

    abertura.progressoTela.StepBy(1);
    Application.ProcessMessages;
  end;
end;

end.
