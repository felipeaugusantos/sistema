unit untTEstornaCartoes;

interface

Uses System.Classes, System.SysUtils, Data.DB, untTypesSistema, Uni;

Type
  TEstornaCartoes = class
  private

  public
    class function RetornaSequenciaisParaEstornoAnalitico(ADataset: TDataset): TSequenciaisBaixaCartao;

    class procedure GravarMovBanAnalitoFreteTaxasMarketPlace(ADataset: TDataset;
                                                             var ASequenciais: TSequenciaisBaixaCartao;
                                                             ADataLancamentoEstorno: TDateTime);
  end;

implementation
Uses untFuncoesSimples, untFuncoes, untTBanMca, untMovBan;
{ TEstornaCartoes }

class procedure TEstornaCartoes.GravarMovBanAnalitoFreteTaxasMarketPlace(
  ADataset: TDataset; var ASequenciais: TSequenciaisBaixaCartao;
  ADataLancamentoEstorno: TDateTime);
  Var
    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;

    LPlanoContasEstorno: String;
begin
  If Concat(ADataset.FieldByName('MCA_DOCFRE').AsString,
            ADataset.FieldByName('MCA_DOCAJU').AsString,
            ADataset.FieldByName('MCA_DOCCUP').AsString).Trim.IsEmpty Then
    Exit;

  LBanMcaDS := TBanMcaDS.Create;
  LBanMcaDS.strNumDup := ADataset.FieldByName('NRODUP').AsString;
  LBanMcaDS.strParcel := ADataset.FieldByName('PARDUP').AsString;
  LBanMcaDS.strCodEmp := ADataset.FieldByName('MCA_CODEMP').AsString;
  LBanMcaDS.strCodCli := ADataset.FieldByName('MCA_CODCLI').AsString;
  LBanMcaDS.strCodCar := ADataset.FieldByName('MCA_CODCAR').AsString;
  LBanMcaDS.strHist01 := ADataset.FieldByName('MCA_HIST01').AsString;
  LBanMcaDS.strHist02 := ADataset.FieldByName('MCA_HIST02').AsString;
  LBanMcaDS.strNumCCD := ADataset.FieldByName('MCA_NUMCCD').AsString;
  LBanMcaDS.strNumNsu := ADataset.FieldByName('MCA_NUMNSU').AsString;
  LBanMcaDS.fltValSta := ADataset.FieldByName('MCA_VALSTA').AsFloat;
  LBanMcaDS.fltValTax := ADataset.FieldByName('MCA_VALTAX').AsFloat;
  LBanMcaDS.fltValRec := ADataset.FieldByName('MCA_VALREC').AsFloat;
  LBanMcaDS.fltFreMkt := ADataset.FieldByName('MCA_FREMKT').AsFloat;
  LBanMcaDS.fltValAju := ADataset.FieldByName('MCA_VALAJU').AsFloat;
  LBanMcaDS.fltCupMkt := ADataset.FieldByName('MCA_CUPMKT').AsFloat;

  If Not ADataset.FieldByName('MCA_DOCFRE').AsString.IsEmpty Then
  Begin
    If fFormataFloat(ADataset.FieldByName('MCA_FREMKT').AsFloat, 2) > 0 Then
    Begin
      LBanMcaDS.strIdenti := 'FREMKT';
      LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      LListaBanMca := TListaBanMCA.Create;
      LListaBanMca.Add(LBanMcaDS);

      LPlanoContasEstorno := fCampoTabela('CTB_CODCTA', 'MOVBAN', ['CTB_SEQLAN'], [ADataset.FieldByName('MCA_DOCFRE').AsString]);
      If LPlanoContasEstorno.IsEmpty Then
        LPlanoContasEstorno := ADataset.FieldByName('CAR_CTAFRE').AsString;

      fGravaMovBan(LPlanoContasEstorno,                           // Centro de Custo
                   ADataset.FieldByName('MCA_PORBTX').AsString,   // Portador
                   strLoginUsuarioLogado,                         // Operador
                   ADataLancamentoEstorno,                        // Data do Lançamento
                   fTime(),                                       // Hora do Lançamento
                   '',                                            // Documento
                   'C',                                           // Credito / Debito
                   IIF(ADataset.FieldByName('MCA_EMPBAI').IsNull,
                       VS_strCodEmp,
                       ADataset.FieldByName('MCA_EMPBAI').AsString), // Empresa
                   Abs(ADataset.FieldByName('MCA_FREMKT').AsFloat),  // Valor Documento
                   'Est. Frete Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                   '',                                            // Historico 2
                   ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                   ADataset.FieldByName('MCA_FORBTX').AsString,   // Fornecedor
                   '',                                            // Numero da Duplicata
                   0,                                             // Sequencial Duplicata
                   '',                                            // Parcela da Duplicata
                   '',                                            // Empresa da Duplicata
                   '',                                            // Série
                   ADataset.FieldByName('MCA_EVETAX').AsString,   // Código do Evento
                   '',                                            // Documento da Baixa
                   Nil,                                           // Log Bancário
                   0,
                   ASequenciais.SequencialControleBaixaPagar,
                   '',
                   '',
                   ASequenciais.intSeqLan.ToString,
                   fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                   '',
                   '',
                   1,
                   True,
                   LListaBanMca);

      Inc(ASequenciais.intSeqLan);
      Inc(ASequenciais.intContadorAutIncMovBan);
      Inc(ASequenciais.intContadorAutIncBanMca);
    End;
  End;

  If Not ADataset.FieldByName('MCA_DOCAJU').AsString.IsEmpty Then
  Begin
    If fFormataFloat(ADataset.FieldByName('MCA_VALAJU').AsFloat, 2) > 0 Then
    Begin
      LBanMcaDS.strIdenti := 'VALAJU';
      LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      LListaBanMca := TListaBanMCA.Create;
      LListaBanMca.Add(LBanMcaDS);

      LPlanoContasEstorno := fCampoTabela('CTB_CODCTA', 'MOVBAN', ['CTB_SEQLAN'], [ADataset.FieldByName('MCA_DOCAJU').AsString]);
      If LPlanoContasEstorno.IsEmpty Then
        LPlanoContasEstorno := ADataset.FieldByName('CAR_CTAAJU').AsString;

      fGravaMovBan(LPlanoContasEstorno,                           // Centro de Custo
                   ADataset.FieldByName('MCA_PORBTX').AsString,   // Portador
                   strLoginUsuarioLogado,                         // Operador
                   ADataLancamentoEstorno,                        // Data do Lançamento
                   fTime(),                                       // Hora do Lançamento
                   '',                                            // Documento
                   'C',                                           // Credito / Debito
                   IIF(ADataset.FieldByName('MCA_EMPBAI').IsNull,
                       VS_strCodEmp,
                       ADataset.FieldByName('MCA_EMPBAI').AsString), // Empresa
                   Abs(ADataset.FieldByName('MCA_VALAJU').AsFloat),  // Valor Documento
                   'Est. Ajustes Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                   '',                                            // Historico 2
                   ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                   ADataset.FieldByName('MCA_FORBTX').AsString,   // Fornecedor
                   '',                                            // Numero da Duplicata
                   0,                                             // Sequencial Duplicata
                   '',                                            // Parcela da Duplicata
                   '',                                            // Empresa da Duplicata
                   '',                                            // Série
                   ADataset.FieldByName('MCA_EVETAX').AsString,   // Código do Evento
                   '',                                            // Documento da Baixa
                   Nil,                                           // Log Bancário
                   0,
                   ASequenciais.SequencialControleBaixaPagar,
                   '',
                   '',
                   ASequenciais.intSeqLan.ToString,
                   fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                   '',
                   '',
                   1,
                   True,
                   LListaBanMca);

      Inc(ASequenciais.intSeqLan);
      Inc(ASequenciais.intContadorAutIncMovBan);
      Inc(ASequenciais.intContadorAutIncBanMca);
    End;
  End;

  If Not ADataset.FieldByName('MCA_DOCCUP').AsString.IsEmpty Then
  Begin
    If fFormataFloat(ADataset.FieldByName('MCA_CUPMKT').AsFloat, 2) > 0 Then
    Begin
      LBanMcaDS.strIdenti := 'CUPMKT';
      LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      LListaBanMca := TListaBanMCA.Create;
      LListaBanMca.Add(LBanMcaDS);

      LPlanoContasEstorno := fCampoTabela('CTB_CODCTA', 'MOVBAN', ['CTB_SEQLAN'], [ADataset.FieldByName('MCA_DOCCUP').AsString]);
      If LPlanoContasEstorno.IsEmpty Then
        LPlanoContasEstorno := ADataset.FieldByName('CAR_CTACUP').AsString;

      fGravaMovBan(LPlanoContasEstorno,                           // Centro de Custo
                   ADataset.FieldByName('MCA_PORBAI').AsString,   // Portador
                   strLoginUsuarioLogado,                         // Operador
                   ADataLancamentoEstorno,                        // Data do Lançamento
                   fTime(),                                       // Hora do Lançamento
                   '',                                            // Documento
                   'D',                                           // Credito / Debito
                   IIF(ADataset.FieldByName('MCA_EMPBAI').IsNull,
                       VS_strCodEmp,
                       ADataset.FieldByName('MCA_EMPBAI').AsString), // Empresa
                   Abs(ADataset.FieldByName('MCA_CUPMKT').AsFloat),  // Valor Documento
                   'Est. Cupom Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                   '',                                            // Historico 2
                   ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                   ADataset.FieldByName('MCA_FORBTX').AsString,   // Fornecedor
                   '',                                            // Numero da Duplicata
                   0,                                             // Sequencial Duplicata
                   '',                                            // Parcela da Duplicata
                   '',                                            // Empresa da Duplicata
                   '',                                            // Série
                   ADataset.FieldByName('MCA_EVETAX').AsString,   // Código do Evento
                   '',                                            // Documento da Baixa
                   Nil,                                           // Log Bancário
                   0,
                   ASequenciais.SequencialControleBaixaPagar,
                   '',
                   '',
                   ASequenciais.intSeqLan.ToString,
                   fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                   '',
                   '',
                   1,
                   True,
                   LListaBanMca);

      Inc(ASequenciais.intSeqLan);
      Inc(ASequenciais.intContadorAutIncMovBan);
      Inc(ASequenciais.intContadorAutIncBanMca);
    End;
  End;

  If Assigned(LListaBanMca) Then
    FreeAndNil(LListaBanMca);
end;

class function TEstornaCartoes.RetornaSequenciaisParaEstornoAnalitico(
  ADataset: TDataset): TSequenciaisBaixaCartao;
begin
  {********************************************}
  {* PEGANDO OS SEQLANs NECESSÁRIOS PARA O    *}
  {* ESTORNO DE TODOS OS CARTÕES SELECIONADOS *}
  {*****************************************AJ*}
  //Débito
  ADataset.Filter := 'MCA_MARDES=''M'' AND MCA_PORDEB IS NOT NULL';
  ADataset.Filtered := True;
  Result.intSeqLan := ADataset.RecordCount;
  //Taxa
  ADataset.Filter := 'MCA_MARDES=''M'' AND MCA_VALTAX > 0';
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;
  Result.intSequencialCadPag := ADataset.RecordCount;
  //Antecipação
  ADataset.Filter := 'MCA_MARDES=''M'' AND MCA_ANTTAX > 0';
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;
  Result.intSequencialCadPag := Result.intSequencialCadPag + ADataset.RecordCount;
  //Crédito
  ADataset.Filter := 'MCA_MARDES=''M'' ';
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;
  Result.intContadorAutIncLogMca := ADataset.RecordCount;
  //Frete
  ADataset.Filter := 'MCA_MARDES=''M'' AND (MCA_DOCFRE IS NOT NULL AND MCA_DOCFRE<>'''') AND ' +
                     'MCA_FREMKT > 0 ';
  ADataset.Filtered := True;
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;
  //Ajustes
  ADataset.Filter := 'MCA_MARDES=''M'' AND (MCA_DOCAJU IS NOT NULL AND MCA_DOCAJU<>'''') AND ' +
                     'MCA_VALAJU > 0 ';
  ADataset.Filtered := True;
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;
  //Cupons
  ADataset.Filter := 'MCA_MARDES=''M'' AND (MCA_DOCCUP IS NOT NULL AND MCA_DOCCUP<>'''') AND ' +
                     'MCA_CUPMKT > 0 ';
  ADataset.Filtered := True;
  Result.intSeqLan := Result.intSeqLan + ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(fRetAutoIncrem('BANMCA', VS_strCodEmp, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(fRetAutoIncrem('MOVBAN', VS_strCodEmp, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(fRetAutoIncrem('LOGMCA', VS_strCodEmp, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(fRetAutoIncrem('CADPAG', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(fRetAutoIncrem('LOGCTP', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := fSeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(fRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;
end;

end.
