unit untTRegistro1200Cat42;

interface

uses System.Generics.Collections, SysUtils, System.StrUtils,
     Classes, untTRegistroBaseCat42, untTParticipantesPresentesLfe,
     untTItensPresentesLfe, untTDadosBloco1Cat42, Forms;

type
  TRegistro1200 = class(TRegistroBase)
  private
    FParticipantesPresentes: TParticipantesPresentes;
    FDados: TObjectList<TNotaFiscalCat42>;
    FItensPresentes: TItensPresentes;
  public
    procedure pGerar; override;

    property participantesPresentes: TParticipantesPresentes read FParticipantesPresentes write FParticipantesPresentes;
    property listaDados: TObjectList<TNotaFiscalCat42> read FDados write FDados;
    property itensPresentes: TItensPresentes read FItensPresentes write FItensPresentes;
  end;

implementation

uses untFuncoes;

{ TRegistro1200 }

procedure TRegistro1200.pGerar;
  var
    dado: TNotaFiscalCat42;
    blnEnviarDevolCompraICMS_TOTMaiorQueZero: Boolean;
begin
  inherited;

  abertura.lblOperacao.Caption := 'Gerando registro 1200...';
  abertura.progressoTela.Max := FDados.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for dado in FDados do
  begin
    if not fEmptyStr(dado.strNumeroEcf) then
    begin
      pInicializaLinha;

//# Registros de Notas Fiscais de SAIDA(1)
      if (dado.intIndicadorOperacao = 1) then
      begin
        pCampo(strTipoRegistro);                                            //001 Texto fixo contendo "1200"
        pCampo(dado.participante.strCgcCpf);                                //002 Código de identificação do participante no arquivo conforme Registro 0150
        pCampo('01');                                                       //003 Código do modelo do documento fiscal, conforme a Tabela 4.1.1 do SPED
        pCampo('');                                                         //004 Número de série de fabricação do equipamento ECF.
        pCampo(dado.strSerie);                                              //005 Série do documento fiscal
        pCampo(RightStr(dado.strDocumento, 9));                             //006 Número do documento fiscal
        pCampo('1');                                                        //007 Número sequencial do item no documento fiscal
        pCampo(IntToStr(dado.intIndicadorOperacao));                        //008 Indicador do tipo de operação: 0- Entrada; 1- Saída
        pCampo(FormatDateTime('DDMMYYYY', dado.dtaDataEntrada));            //009 Data da entrada da mercadoria ou da saída
        pCampo(dado.strCfop);                                               //010 Código Fiscal de Operação e Prestação
        pCampo(dado.strCodigoProduto);                                      //011 Código do item conforme Registro 0200
        pCampo(fFloatToStrVirgula(dado.fltQuantidade, 12, 3));              //012 Quantidade do Item.

        //#pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2)); //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
        //#pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));          //014 Valor de confronto nas operações de saída.
        //#pCampo(dado.strCodigoEnquadramento, False);                         //015 Código de Enquadramento Legal do Ressarcimento ou Complemento

        if (Pos(dado.strCfop, '5411_6411_') > 0) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo(fFloatToStrVirgula(0, 12, 2))                                     //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2))                //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
        end
        else
          pCampo('');                                                                //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)

        if (IndexStr(dado.strCodigoEnquadramento,['1','2','3','4']) > -1) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo(fFloatToStrVirgula(0, 12, 2))                                     //014 Valor de confronto nas operações de saída.
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));               //014 Valor de confronto nas operações de saída.
        end
        else
        begin
          if dado.fltValorConfronto = 0 then
            pCampo('')                                                               //014 Valor de confronto nas operações de saída.
          else
            pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));               //014 Valor de confronto nas operações de saída.
        end;

        if (Pos(dado.strCfop, '5411_6411_') > 0) then
        begin
          if dado.fltValorConfronto = 0 then
            pCampo('', False)                                                        //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
          else
            pCampo(dado.strCodigoEnquadramento, False)                               //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
        end
        else
          pCampo(dado.strCodigoEnquadramento, False);                                //015 Código de Enquadramento Legal do Ressarcimento ou Complemento

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
        end;

      end else
      begin
//# Registros de Notas Fiscais de ENTRADA(0)

        //# 3- Só enviar devolução de compra, quando o ICMS_TOT campo 09 for > 0
        blnEnviarDevolCompraICMS_TOTMaiorQueZero:= True;
        if (dado.intIndicadorOperacao = 0) then
          if (Pos(dado.strCfop, '5411_') > 0) and (dado.fltValorTotalIcmsSuportado = 0) then
            blnEnviarDevolCompraICMS_TOTMaiorQueZero:= False;

        if (blnEnviarDevolCompraICMS_TOTMaiorQueZero) then
        begin
          pCampo(strTipoRegistro);                                            //001 Texto fixo contendo "1200"
          pCampo(dado.participante.strCgcCpf);                                //002 Código de identificação do participante no arquivo conforme Registro 0150
          pCampo('01');                                                       //003 Código do modelo do documento fiscal, conforme a Tabela 4.1.1 do SPED
          pCampo('');                                                         //004 Número de série de fabricação do equipamento ECF.
          pCampo(dado.strSerie);                                              //005 Série do documento fiscal
          pCampo(RightStr(dado.strDocumento, 9));                             //006 Número do documento fiscal
          pCampo('1');                                                        //007 Número sequencial do item no documento fiscal
          pCampo(IntToStr(dado.intIndicadorOperacao));                        //008 Indicador do tipo de operação: 0- Entrada; 1- Saída
          pCampo(FormatDateTime('DDMMYYYY', dado.dtaDataEntrada));            //009 Data da entrada da mercadoria ou da saída
          pCampo(dado.strCfop);                                               //010 Código Fiscal de Operação e Prestação
          pCampo(dado.strCodigoProduto);                                      //011 Código do item conforme Registro 0200
          pCampo(fFloatToStrVirgula(dado.fltQuantidade, 12, 3));              //012 Quantidade do Item.

          //#pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2)); //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
          //#pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));          //014 Valor de confronto nas operações de saída.
          //#pCampo(dado.strCodigoEnquadramento, False);                         //015 Código de Enquadramento Legal do Ressarcimento ou Complemento

          if (IndexStr(dado.strCodigoEnquadramento,['0','4']) > -1) then
          begin
            if dado.fltValorTotalIcmsSuportado = 0 then
            begin
              if dado.fltSaidasParaOutrosEstados > 0 then
              begin
                if (Pos(dado.strCfop, '1411_') > 0) then
                  pCampo(fFloatToStrVirgula('0', 12, 2))                             //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
                else
                  pCampo(fFloatToStrVirgula(dado.fltSaidasParaOutrosEstados, 12, 2)) //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
              end
              else
                pCampo(fFloatToStrVirgula(0, 12, 2));                                //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
            end
            else
              pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2));    //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)
          end
          else
            pCampo(fFloatToStrVirgula(dado.fltValorTotalIcmsSuportado, 12, 2));      //013 Valor total do ICMS suportado pelo contribuinte nas operações de entrada (v. observação feita para o Registro 1050)

          if dado.fltValorConfronto > 0 then
          begin
            if (Pos(dado.strCfop, '1411_') > 0) then
              pCampo('')                                                             //014 Valor de confronto nas operações de saída.
            else
              pCampo(fFloatToStrVirgula(dado.fltValorConfronto, 12, 2));             //014 Valor de confronto nas operações de saída.
          end
          else
            pCampo('');                                                              //014 Valor de confronto nas operações de saída.

          if (dado.fltSaidasParaOutrosEstados > 0) and
            (dado.fltValorConfronto > 0) then
          begin
            if (Pos(dado.strCfop, '1411_') > 0) then
              pCampo('0', False)                                                     //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
            else
              pCampo(dado.strCodigoEnquadramento, False)                             //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
          end
          else
            if (dado.fltSaidasParaOutrosEstados = 0) and
              (dado.fltValorConfronto = 0) and
              (Pos(dado.strCfop, '2411_2202_') > 0) then
              pCampo(dado.strCodigoEnquadramento, False)                             //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
            else
              if (Pos(dado.strCfop, '1411_') > 0) then
                pCampo('0', False)                                                   //015 Código de Enquadramento Legal do Ressarcimento ou Complemento
              else
                pCampo('', False);                                                   //015 Código de Enquadramento Legal do Ressarcimento ou Complemento

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
          end;

        end;
      end;

    end;
  end;
end;

end.
