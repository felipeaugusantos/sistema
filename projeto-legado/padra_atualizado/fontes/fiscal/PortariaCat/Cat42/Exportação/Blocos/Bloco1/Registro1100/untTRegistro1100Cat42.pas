unit untTRegistro1100Cat42;

interface

uses System.StrUtils,
     System.Generics.Collections,
     SysUtils,
     Classes,
     untTRegistroBaseCat42,
     untTItensPresentesLfe,
     untTDadosBloco1Cat42,
     Forms,
     untTParticipantesPresentesLfe,
     Dialogs;

type
  TRegistro1100 = class(TRegistroBase)
  private
    FParticipantesPresentes: TParticipantesPresentes;
    FDados: TObjectList<TNotaFiscalCat42>;
    FItensPresentes: TItensPresentes;
  public
    procedure pGerar; override;

    property participantesPresentes: TParticipantesPresentes read FParticipantesPresentes write FParticipantesPresentes;
    property itensPresentes: TItensPresentes read FItensPresentes write FItensPresentes;
    property listaDados: TObjectList<TNotaFiscalCat42> read FDados write FDados;
  end;

  const
    CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_1 = '1201_1202_1203_1204_1208_1209_1410_1411_1503_1504_1505_1506_1553_1660_1661_1662_1918_1919_';
    CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_2 = '2201_2202_2203_2204_2208_2209_2410_2411_2503_2504_2505_2506_2553_2660_2661_2662_2918_2919_';
    CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5 = '5201_5202_5208_5209_5210_5410_5411_5412_5413_5503_5553_5555_5556_5660_5661_5662_5918_5919_5921_';
    CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_6 = '6201_6202_6208_6209_6210_6410_6411_6412_6413_6503_6553_6555_6556_6660_6661_6662_6918_6919_6921_';

implementation

uses Uni, DB, untFuncoes;

{ TRegistro1100 }

procedure TRegistro1100.pGerar;
  var
    dado: TNotaFiscalCat42;
    blnEnviarDevolCompraICMS_TOTMaiorQueZero: Boolean;

  function fRetCodigoConsumidorPelaChaveAcesso(strChaveAcesso, strCodigoParticipante: string): string;
    var
      qryAux: TUniQuery;
      strMovGer_Ger_CgcCon: string;
  begin
    Result := '';

    qryAux := fCriaQuery(nil);

    try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := ' SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = :COD_CLI_CON AND CLI_NOMCLI LIKE "%CONSUMID%" '
                       + ' UNION ALL SELECT CON_CODCON, CON_NOMCON FROM CLICON WHERE CON_CODCON = :COD_CLI_CON AND CON_NOMCON LIKE "%CONSUMID%" ';

      qryAux.Params.ParamByName('COD_CLI_CON').AsString := strCodigoParticipante;
      qryAux.Open;

      if not qryAux.IsEmpty then
      begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Text := ' SELECT GER_CGCCON '
                         + '   FROM CADFIS '
                         + '  INNER JOIN MOVGER ON GER_CODEMP = FIS_CODEMP '
                         + '                   AND GER_NUMDOC = FIS_NUMDOC '
                         + '                   AND GER_ESPDOC = FIS_ESPDOC '
                         + '                   AND FIS_FORCLI = IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) '
                         + '                   AND FIS_TIP_FC = GER_TIP_FC '
                         + '  WHERE FIS_ACESSO = :ACESSO ';

        qryAux.Params.ParamByName('ACESSO').AsString := strChaveAcesso;
        qryAux.Open;

        strMovGer_Ger_CgcCon := qryAux.FieldByName('GER_CGCCON').AsString;

        if not fEmptyStr(strMovGer_Ger_CgcCon) then
        begin
          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Text := ' SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_C_G_C_ = :_C_G_C_ AND CLI_NOMCLI NOT LIKE "%CONSUMID%" ';

          qryAux.Params.ParamByName('_C_G_C_').AsString := strMovGer_Ger_CgcCon;
          qryAux.Open;

          Result := qryAux.FieldByName('CLI_CODCLI').AsString;

          if fEmptyStr(Result) then
          begin
            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Text := ' SELECT CON_CODCON, CON_NOMCON FROM CLICON WHERE CON_C_P_F_ = :_C_P_F_ AND CON_NOMCON NOT LIKE "%CONSUMID%" ';

            qryAux.Params.ParamByName('_C_P_F_').AsString := strMovGer_Ger_CgcCon;
            qryAux.Open;

            Result := qryAux.FieldByName('CON_CODCON').AsString;
          end;
        end;
      end else Result := strCodigoParticipante;
    finally
      qryAux.Free;
    end;

  end;

begin
  inherited;

  abertura.lblOperacao.Caption := 'Gerando registro 1100...';
  abertura.progressoTela.Max := FDados.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for dado in FDados do
  begin
    if fEmptyStr(dado.strNumeroEcf) then
    begin
      pInicializaLinha;

      //# Registros de Notas Fiscais de SAIDA(1)
      if (dado.intIndicadorOperacao = 1) then
      begin

        pCampo(strTipoRegistro);                                                     //001 Texto fixo contendo "1100"
        pCampo(dado.strChaveAcesso);                                                 //002 Chave do documento fiscal eletrônico
        pCampo(FormatDateTime('DDMMYYYY', dado.dtaDataEntrada));                     //003 Data de entrada da mercadoria ou da saída

        if (Pos(dado.strCfop, CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5 + CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_6) > 0) then
          pCampo('1')                                                                //005 Indicador do tipo da operação: 0- Entrada; 1- Saída
        else pCampo(IntToStr(dado.intIndicadorOperacao));                            //005 Indicador do tipo da operação: 0- Entrada; 1- Saída

        pCampo(IntToStr(dado.intIndicadorOperacao));                                 //005 Indicador do tipo da operação: 0- Entrada; 1- Saída
        pCampo(dado.strCodigoProduto);                                               //006 Código do item conforme registro 0200
        pCampo(dado.strCfop);                                                        //007 Código fiscal de operação e prestação
        pCampo(fFloatToStrVirgula(dado.fltQuantidade, 12, 3));                       //008 Quantidade do item

        if (Pos(dado.strCfop, CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5 + CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_6) > 0) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo(fFloatToStrVirgula(0, 12, 2))                                     //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2))                //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)
        end
        else
          pCampo('');                                                                //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)

        if (IndexStr(dado.strCodigoEnquadramento,['1','2','3','4']) > -1) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo(fFloatToStrVirgula(0, 12, 2))                                     //010 Valor de confronto nas operações de saída
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));               //010 Valor de confronto nas operações de saída
        end
        else
        begin
          if dado.fltValorConfronto = 0 then
            pCampo('')                                                               //010 Valor de confronto nas operações de saída
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));               //010 Valor de confronto nas operações de saída
        end;

        if (Pos(dado.strCfop, CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5 + CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_6) > 0) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo('', False)                                                        //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST
          else
            pCampo(dado.strCodigoEnquadramento, False)                               //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST
        end
        else
          pCampo(dado.strCodigoEnquadramento, False);                                //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST

        intQuantidadeGerada := intQuantidadeGerada + 1;

        abertura.progressoTela.StepBy(1);
        Application.ProcessMessages;

        pAdicionaLista;

        //guarda os codigos de itens utilizados no arquivo
        FItensPresentes.listaItens.Sorted := True;
        FItensPresentes.listaItens.Duplicates := dupIgnore;
        FItensPresentes.listaItens.Add(dado.strCodigoProduto);

        //guarda os codigos dos participantes utilizados no registro
        if ((Pos(dado.strModelo, '02_02D_59_60_65') <= 0) and (dado.Participante.strCgcCpf <> '00000000000') and (dado.Participante.strCgcCpf <> '00000000000000')) and
          (dado.participante.strCgcCpf <> abertura.empresa.strCNPJ) then
        begin
          FParticipantesPresentes.listaParticipantes.Sorted := True;
          FParticipantesPresentes.listaParticipantes.Duplicates := dupIgnore;
          //FParticipantesPresentes.listaParticipantes.Add(dado.Participante.strCgcCpf); //estava sendo recuperado mas de um registro, e assim gerando informações equivocadas nos registro '0150'
          FParticipantesPresentes.listaParticipantes.Add(dado.Participante.strCodigo);
        end else FParticipantesPresentes.listaParticipantes.Add(fRetCodigoConsumidorPelaChaveAcesso(dado.strChaveAcesso, dado.Participante.strCodigo) + dado.strTipFc);

      end else
      begin
        //# Registros de Notas Fiscais de ENTRADA(0)

        //# 3- Só enviar devolução de compra, quando o ICMS_TOT campo 09 for > 0
        blnEnviarDevolCompraICMS_TOTMaiorQueZero:= True;
        if (dado.intIndicadorOperacao = 0) then
          if (Pos(dado.strCfop, CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5) > 0) and (dado.fltValorTotalIcmsSuportado = 0) then
            blnEnviarDevolCompraICMS_TOTMaiorQueZero:= False;

        if (blnEnviarDevolCompraICMS_TOTMaiorQueZero) then
        begin
          pCampo(strTipoRegistro);                                                   //001 Texto fixo contendo "1100"
          pCampo(dado.strChaveAcesso);                                               //002 Chave do documento fiscal eletrônico
          pCampo(FormatDateTime('DDMMYYYY', dado.dtaDataEntrada));                   //003 Data de entrada da mercadoria ou da saída
          pCampo('1');                                                               //004 Número sequencial do item no documento fiscal eletrônico

          if (Pos(dado.strCfop, CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_5 + CFOP_DEVOLUCAO_SAIDA_INICIADO_EM_6) > 0) then
            pCampo('1')                                                              //005 Indicador do tipo da operação: 0- Entrada; 1- Saída
          else pCampo(IntToStr(dado.intIndicadorOperacao));                          //005 Indicador do tipo da operação: 0- Entrada; 1- Saída

          pCampo(dado.strCodigoProduto);                                             //006 Código do item conforme registro 0200
          pCampo(dado.strCfop);                                                      //007 Código fiscal de operação e prestação
          pCampo(fFloatToStrVirgula(dado.fltQuantidade, 12, 3));                     //008 Quantidade do item

          if (IndexStr(dado.strCodigoEnquadramento,['0','4']) > -1) then
          begin
            if dado.fltValorTotalIcmsSuportado = 0 then
            begin
              if dado.fltSaidasParaOutrosEstados > 0 then
              begin
                if (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_1) > 0) then
                  pCampo(fFloatToStrVirgula('0', 12, 2))                             //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)

              	else if (dado.fltSaidasParaOutrosEstados <> 0) and
                        (dado.fltValorConfronto = 0) and
                        (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_2) > 0) then
        		      pCampo(fFloatToStrVirgula('0', 12, 2))                             //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)

                else
                  pCampo(fFloatToStrVirgula(dado.fltSaidasParaOutrosEstados, 12, 2)) //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)
              end
              else
                pCampo(fFloatToStrVirgula(0, 12, 2));                                //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)
            end
            else
              pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2));    //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)
          end
          else
            pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2));      //009 Valor total do ICMS suportado pelo contribuinte nas operações de entrada(observação feita para o registro 1050)

          if dado.fltValorConfronto > 0 then
          begin
            if (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_1) > 0) then
              pCampo('')                                                             //010 Valor de confronto nas operações de saída
            else
              pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));             //010 Valor de confronto nas operações de saída
          end
          else
            pCampo('');                                                              //010 Valor de confronto nas operações de saída

          if (dado.fltSaidasParaOutrosEstados > 0) and
            (dado.fltValorConfronto > 0) then
          begin
            if (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_1) > 0) then
              pCampo('0', False)                                                     //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST
            else
              pCampo(dado.strCodigoEnquadramento, False)                             //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST
          end
          else if (dado.fltSaidasParaOutrosEstados = 0) and
                  (dado.fltValorConfronto = 0) and
                  (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_2) > 0) then
                 pCampo(dado.strCodigoEnquadramento, False)                          //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST

         	else if (dado.fltSaidasParaOutrosEstados <> 0) and
                  (dado.fltValorConfronto = 0) and
                  (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_2) > 0) then
        		     pCampo('0', False)                                                  //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST

          else if (Pos(dado.strCfop, CFOP_DEVOLUCAO_ENTRADA_INICIADO_EM_1) > 0) then
                 pCampo('0', False)                                                  //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST
          else
                 pCampo('', False);                                                  //011 Código de enquadramento legal da hipótese de ressarcimento ou complemento de ICMS ST

          intQuantidadeGerada := intQuantidadeGerada + 1;

          abertura.progressoTela.StepBy(1);
          Application.ProcessMessages;

          pAdicionaLista;

          //guarda os codigos de itens utilizados no arquivo
          FItensPresentes.listaItens.Sorted := True;
          FItensPresentes.listaItens.Duplicates := dupIgnore;
          FItensPresentes.listaItens.Add(dado.strCodigoProduto);

          //guarda os codigos dos participantes utilizados no registro
          if ((Pos(dado.strModelo, '02_02D_59_60_65') <= 0) and (dado.Participante.strCgcCpf <> '00000000000') and (dado.Participante.strCgcCpf <> '00000000000000')) and
            (dado.participante.strCgcCpf <> abertura.empresa.strCNPJ) then
          begin
            FParticipantesPresentes.listaParticipantes.Sorted := True;
            FParticipantesPresentes.listaParticipantes.Duplicates := dupIgnore;
            //FParticipantesPresentes.listaParticipantes.Add(dado.Participante.strCgcCpf); //estava sendo recuperado mas de um registro, e assim gerando informações equivocadas nos registro '0150'
            FParticipantesPresentes.listaParticipantes.Add(dado.Participante.strCodigo + dado.strTipFc);
          end else FParticipantesPresentes.listaParticipantes.Add(fRetCodigoConsumidorPelaChaveAcesso(dado.strChaveAcesso, dado.Participante.strCodigo) + dado.strTipFc);

        end;
      end;
    end;
  end;
end;

end.
