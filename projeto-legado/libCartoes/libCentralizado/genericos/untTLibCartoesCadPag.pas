unit untTLibCartoesCadPag;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Variants,

     Uni,

     untTLibCartoesFuncoes, untTBatchSQL, untTBatchSQL.Helper;

Type
  TLibCartoesCadPag = class
  private
    class var FCFG_CTPLBB,
              FCFG_LIBDPA,
              FCFG_LBBGRU,
              FCFG_CTPENT: String;

  public
    class function GravaCadPag(ANomeFormularioLog,
                               ADescricaoLog,
                               ACodigoFornecedor,
                               ANumeroDuplicata,
                               AParcela,
                               ACodigoEmpresa,
                               APlanoDeContas,
                               ASerieDuplicata: String;
                               ASequencialBaixa: Integer;
                               ADataCadastro,
                               ADataVencimento: TDateTime;
                               AValorDuplicata,
                               AValorOriginal: Double;
                               APrevisao,
                               AVeioBoleto,
                               ADeposito,
                               AHistorico01,
                               AHistorico02,
                               AHistoricoBaixa,
                               APortadorBaixa,
                               APlanoDeContasBaixa,
                               ADocumentoBaixa,
                               AOperadorBaixa: String;
                               ADataPagamento: TDateTime;
                               AValorPagamento,
                               AValorJuros,
                               AValorDesconto: Double;
                               AEmpresaGeradora,
                               ACentroDeCustos,
                               AUsaCheque,
                               ACodigoPortador,
                               ANumeroDocumento: String;
                               AJustosSugerido,
                               ADescontoSigerido: Double;
                               ASequencialControle: Integer;
                               AResumoCaixa: Boolean = False;
                               ASequencialRcx: Integer = 0;
                               ATipoDocumento: String = '';
                               AValorVendor: Double  = 0;
                               AVeioNF: String = '';
                               ANotEnt: String = '';
                               ANotTip: String = '';
                               ACTPCom: String = '';
                               AAutoIncremCadPag: String = '';
                               ADocTer: String = '';
                               AEspTer: String = '';
                               AEmpTer: String = '';
                               ACliTer: String = '';
                               AUsoConsumo: String = '';
                               ACompetencia: String = '';
                               ACodCliUC: String = '';
                               ANumDocUC: String = '';
                               AEspDocUC: String = '';
                               ACodEmpUC: String = '';
                               ADinheiro: Double = 0;
                               AChequeAVista: Double = 0;
                               AOrdemPagamento: Double = 0;
                               ARepasseCheque: Double = 0;
                               ACodigoVendedor: String = '';
                               AJurAnt: Double = 0;
                               ADesAnt: Double = 0;
                               ALinhaDigitavel: String = '';
                               ACodigoBarras: String = '';
                               AAutCtp: String = '';
                               ANFNumDup: String = '';
                               AAutIncBaixaEmprestimo: String = '';
                               AQ_Guia: String = '0';
                               ACodRec: String = '';
                               ABcoFor: String = '';
                               AAutIncLogCTP: String = '';
                               ACodigoProjeto: String = '';
                               APagAntecipado: String = 'N';
                               AAutIncFunrural: String = '';
                               AGnreNumeroDocumento: String = '';
                               AGnreChaveDeAcesso: String = '';
                               AGnreNumeroDeControle: String = '';
                               AGnreDataPrevisaoPagamento: TDateTime = 0;
                               AGnreConvenio: String = '';
                               AMultaSugerida: Double = 0;
                               AAutIncPix: String = '';
                               AValorGrvOri: Double = 0;
                               ADtaDoc: TDateTime = 0;
                               ADtaLiberacao: TDAteTime = 0;
                               AHorLiberacao: TDateTime = 0;
                               AOpeLiberacao: String = '';
                               AUsaMca: String = '';
                               ATemAne: String = 'N';
                               AGnreChaveDeApuracao: String = '';
                               AIncCadFis: string = '';
                               ABatchSQL: TBatchSQL = Nil): Boolean;
  end;


implementation

Uses untLibCartoesLogCtp;

class function TLibCartoesCadPag.GravaCadPag(ANomeFormularioLog,
                                             ADescricaoLog,
                                             ACodigoFornecedor,
                                             ANumeroDuplicata,
                                             AParcela,
                                             ACodigoEmpresa,
                                             APlanoDeContas,
                                             ASerieDuplicata: String;
                                             ASequencialBaixa: Integer;
                                             ADataCadastro,
                                             ADataVencimento: TDateTime;
                                             AValorDuplicata,
                                             AValorOriginal: Double;
                                             APrevisao,
                                             AVeioBoleto,
                                             ADeposito,
                                             AHistorico01,
                                             AHistorico02,
                                             AHistoricoBaixa,
                                             APortadorBaixa,
                                             APlanoDeContasBaixa,
                                             ADocumentoBaixa,
                                             AOperadorBaixa: String;
                                             ADataPagamento: TDateTime;
                                             AValorPagamento,
                                             AValorJuros,
                                             AValorDesconto: Double;
                                             AEmpresaGeradora,
                                             ACentroDeCustos,
                                             AUsaCheque,
                                             ACodigoPortador,
                                             ANumeroDocumento: String;
                                             AJustosSugerido,
                                             ADescontoSigerido: Double;
                                             ASequencialControle: Integer;
                                             AResumoCaixa: Boolean = False;
                                             ASequencialRcx: Integer = 0;
                                             ATipoDocumento: String = '';
                                             AValorVendor: Double  = 0;
                                             AVeioNF: String = '';
                                             ANotEnt: String = '';
                                             ANotTip: String = '';
                                             ACTPCom: String = '';
                                             AAutoIncremCadPag: String = '';
                                             ADocTer: String = '';
                                             AEspTer: String = '';
                                             AEmpTer: String = '';
                                             ACliTer: String = '';
                                             AUsoConsumo: String = '';
                                             ACompetencia: String = '';
                                             ACodCliUC: String = '';
                                             ANumDocUC: String = '';
                                             AEspDocUC: String = '';
                                             ACodEmpUC: String = '';
                                             ADinheiro: Double = 0;
                                             AChequeAVista: Double = 0;
                                             AOrdemPagamento: Double = 0;
                                             ARepasseCheque: Double = 0;
                                             ACodigoVendedor: String = '';
                                             AJurAnt: Double = 0;
                                             ADesAnt: Double = 0;
                                             ALinhaDigitavel: String = '';
                                             ACodigoBarras: String = '';
                                             AAutCtp: String = '';
                                             ANFNumDup: String = '';
                                             AAutIncBaixaEmprestimo: String = '';
                                             AQ_Guia: String = '0';
                                             ACodRec: String = '';
                                             ABcoFor: String = '';
                                             AAutIncLogCTP: String = '';
                                             ACodigoProjeto: String = '';
                                             APagAntecipado: String = 'N';
                                             AAutIncFunrural: String = '';
                                             AGnreNumeroDocumento: String = '';
                                             AGnreChaveDeAcesso: String = '';
                                             AGnreNumeroDeControle: String = '';
                                             AGnreDataPrevisaoPagamento: TDateTime = 0;
                                             AGnreConvenio: String = '';
                                             AMultaSugerida: Double = 0;
                                             AAutIncPix: String = '';
                                             AValorGrvOri: Double = 0;
                                             ADtaDoc: TDateTime = 0;
                                             ADtaLiberacao: TDAteTime = 0;
                                             AHorLiberacao: TDateTime = 0;
                                             AOpeLiberacao: String = '';
                                             AUsaMca: String = '';
                                             ATemAne: String = 'N';
                                             AGnreChaveDeApuracao: String = '';
                                             AIncCadFis: string = '';
                                             ABatchSQL: TBatchSQL = Nil): Boolean;
  Var
    LGravacao,
    LLogCtp: TUniQuery;

    LAtualizaCamposLiberacao: Boolean;

    LContadorErrosDuplicate: Integer;
Begin
  Result := True;

  If FCFG_CTPLBB.IsEmpty Then
  Begin
    FCFG_CTPLBB := TLibCartoesFuncoes.RetornaValorCfg('CFG_CTPLBB', EmptyStr, 'N');
    FCFG_LIBDPA := TLibCartoesFuncoes.RetornaValorCfg('CFG_LIBDPA', EmptyStr, 'N');
    FCFG_LBBGRU := TLibCartoesFuncoes.RetornaValorCfg('CFG_CTPLBB', EmptyStr, 'N');
    FCFG_CTPENT := TLibCartoesFuncoes.RetornaValorCfg('CFG_CTPENT', EmptyStr, 'N');
  End;

  LGravacao := Nil;
  LLogCtp   := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := 'SELECT * FROM CADPAG WHERE FALSE';
    LGravacao.Open;

    If AAutoIncremCadPag.IsEmpty Then
      AAutoIncremCadPag := VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada);

    LGravacao.Append;

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODFOR', ACodigoFornecedor);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NUMDUP', ANumeroDuplicata);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_PARCEL', AParcela);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODEMP', ACodigoEmpresa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_SERIE_', ASerieDuplicata, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODCTA', APlanoDeContas);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_SEQBAI', ASequencialBaixa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTACAD', TLibCartoesFuncoes.IIF(ADataCadastro = 0, Null, ADataCadastro));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTAVEN', ADataVencimento);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VALDUP', AValorDuplicata);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VALORI', AValorOriginal);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_PREVIS', APrevisao);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VEIOBO', AVeioBoleto);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_HIST01', AHistorico01, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_HIST02', AHistorico02, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_HISBAI', LeftStr(AHistoricoBaixa, 50), True);

    If ACompetencia.IsEmpty Then
      ACompetencia := FormatDateTime('mm/YYYY', ADataCadastro);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_COMPET', ACompetencia);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_PORBAI', APortadorBaixa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODPRJ', ACodigoProjeto);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DOCBAI', ADocumentoBaixa, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CTABAI', APlanoDeContasBaixa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_OPEBAI', AOperadorBaixa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTAPAG', TLibCartoesFuncoes.IIF(ADataPagamento = 0, Null, ADataPagamento));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTABAI', TLibCartoesFuncoes.IIF(ADataPagamento = 0, Null, VS_FuncoesExternas.fIGetVS_Date));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VALPAG', AValorPagamento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VALJUR', AValorJuros, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VALDES', AValorDesconto, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_EMPGER', AEmpresaGeradora, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODEVE', ACentroDeCustos);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USACHQ', AUsaCheque, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USAMCA', AUsaMca, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DEPOSI', ADeposito, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_RESCAI', TLibCartoesFuncoes.IIF(AResumoCaixa, 1, 0), True);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NUMDOC', ANumeroDocumento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODPOR', ACodigoPortador);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_LINDIG', ALinhaDigitavel);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODBAR', ACodigoBarras);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_JURSUJ', AJustosSugerido, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_MULSUJ', AMultaSugerida, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VENDOR', AValorVendor, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DESSUJ', ADescontoSigerido, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DINHEI', ADinheiro, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CHQAVI', AChequeAVista, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_ORDPAG', AOrdemPagamento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_REPCHQ', ARepasseCheque, True);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'AUTOINCREM', AAutoIncremCadPag, True);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_SEQCON', TLibCartoesFuncoes.IIF(ADataPagamento = 0, Null, ASequencialControle));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_EMPBAI', TLibCartoesFuncoes.IIF(ADataPagamento = 0, Null, VS_FuncoesExternas.fIRetEmpresaLogada));

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_RCXCON', ASequencialRcx, False, '0');
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_TIPDOC', ATipoDocumento);

    If AVeioNF.IsEmpty Then
      AVeioNF := 'S';

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_VEIONF', AVeioNF);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NOTENT', ANotEnt, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NOTTIP', ANotTip, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CTPCOM', ACTPCom, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DOCTER', ADocTer, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_ESPTER', AEspTer, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_EMPTER', AEmpTer, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CLITER', ACliTer, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODOPE', VS_FuncoesExternas.fIRetOperadorLogado, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USOCON', AUsoConsumo);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USOCLI', ACodCliUC, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USODOC', ANumDocUC, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USOESP', AEspDocUC, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_USOEMP', ACodEmpUC, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_JURANT', AJurAnt, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DESANT', ADesAnt, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NUMDDA', ANFNumDup);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_BE_INC', AAutIncBaixaEmprestimo);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_BCOFOR', ABcoFor);

    AAutCtp := LGravacao.FieldByName('AUTOINCREM').Value;

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_PAGANT', APagAntecipado, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_SEQRFR', AAutIncFunrural);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_APUGNR', AGnreChaveDeApuracao, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GNRDOC', AGnreNumeroDocumento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GNRACE', AGnreChaveDeAcesso, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GNRCNV', AGnreConvenio, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GNRCTR', AGnreNumeroDeControle, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GNRDPG', AGnreDataPrevisaoPagamento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_FORPIX', AAutIncPix);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_GRVORI', TLibCartoesFuncoes.IIF(AValorGrvOri <> 0, AValorGrvOri, AValorOriginal), True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTADOC', TLibCartoesFuncoes.IIF(ADtaDoc = 0, Null, ADtaDoc));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_TEMANE', ATemAne.ToUpper);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_INCFIS', AIncCadFis, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODVEN', TLibCartoesFuncoes.IIF(Not ACodigoVendedor.IsEmpty, ACodigoVendedor, VS_FuncoesExternas.fIRetOperadorLogado));

    LGravacao.FieldByName('CTP_Q_GUIA').Value := Null;
    LGravacao.FieldByName('CTP_CODREC').Value := Null;
    if Not MatchStr(AQ_Guia, [EmptyStr, '0']) then
    begin
      TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_Q_GUIA', AQ_Guia, True);
      TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_CODREC', ACodRec, True);
    end;


    //não mexi nessas validações
    LAtualizaCamposLiberacao :=
      FCFG_CTPLBB.Equals('S') And
        (FCFG_LIBDPA.Equals('S') Or
        ((ANomeFormularioLog = 'frmAgrupDuplicatasCtp') And FCFG_LBBGRU.Equals('S')));

    If (AnsiIndexStr(ANomeFormularioLog,['frmEntDadosFiscaisResumo',
      'untRecTransfEstoque - fGravaFinanceiro',
      'untRecTransfEstoque - fGravaFinanceiroEsp']) >= 0) Then
      LAtualizaCamposLiberacao := LAtualizaCamposLiberacao Or
        (FCFG_CTPLBB.Equals('S') And
         FCFG_CTPENT.Equals('S'));

    LGravacao.FieldByName('CTP_DTALIB').Value := Null;
    LGravacao.FieldByName('CTP_HORLIB').Value := Null;
    LGravacao.FieldByName('CTP_OPELIB').Value := Null;

    If LAtualizaCamposLiberacao Then
    Begin
      TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_DTALIB', TLibCartoesFuncoes.IIF(ADtaLiberacao = 0, Null, ADtaLiberacao));
      TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_HORLIB', TLibCartoesFuncoes.IIF(AHorLiberacao = 0, Null, AHorLiberacao));
      TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_OPELIB', AOpeLiberacao);
    End;

    If Assigned(ABatchSQL) Then
      LLogCtp := untLibCartoesLogCtp.MontaLogCtp(LGravacao,
                                                 ADescricaoLog,
                                                 ANomeFormularioLog,
                                                 AAutIncLogCTP);

    LContadorErrosDuplicate := 0;
    While LContadorErrosDuplicate <= 5 Do
    Begin
      Try
        TBatchHelper.PostOuAcumula(LGravacao, 'CADPAG', ABatchSQL);
      Except
        On E: Exception Do
        Begin
          If LContadorErrosDuplicate >= 5 Then
            Raise;

          If E.Message.Contains('Duplicate entry') Then
          Begin
            If E.Message.Contains('PRIMARY') And E.Message.Contains(LGravacao.FieldByName('AUTOINCREM').AsString) Then
            Begin
              LGravacao.FieldByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada);
              AAutCtp := LGravacao.FieldByName('AUTOINCREM').AsString;
            End
            Else
              TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTP_NUMDUP', VS_FuncoesExternas.fIRetSequencialCadPag);

            Inc(LContadorErrosDuplicate);
            Continue;
          End;

          Raise;
        End;
      End;

      Break;
    End;

    If Assigned(LLogCtp) Then
      TBatchHelper.AddQueryToBatch(ABatchSQL, LLogCtp)
    Else
      untLibCartoesLogCtp.GravaLogCtp(AAutCtp,
                                      ADescricaoLog,
                                      ANomeFormularioLog,
                                      AAutIncLogCTP,
                                      ABatchSQL);



  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LLogCtp);
    TLibCartoesFuncoes.FreeAndNilDatasets(LGravacao);
  End;
End;

end.
